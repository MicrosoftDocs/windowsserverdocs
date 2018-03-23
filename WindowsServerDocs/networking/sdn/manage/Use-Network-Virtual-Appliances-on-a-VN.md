---
title: Use Network Virtual Appliances on a Virtual Network
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: networking-sdn
ms.assetid: 3c361575-1050-46f4-ac94-fa42102f83c1
ms.author: pashort
author: shortpatti
---
# Use Network Virtual Appliances on a Virtual Network

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to deploy network virtual appliances on tenant Virtual Networks.

You can add network virtual appliances to networks that perform user defined routing and port mirroring functions.

This topic contains the following sections.

- [Types of Network Virtual Appliances](#bkmk_types)
- [Deploying a Network Virtual Appliance](#bkmk_deploy)
- [Example: User Defined Routing](#bkmk_routing)
- [Example: Port Mirroring](#bkmk_port)

## <a name="bkmk_types"></a>Types of Network Virtual Appliances

There are two types of virtual appliances that you can use on virtual networks:

1. **User defined routing**. User defined routing replaces distributed routers on the virtual network with the routing capabilities of the virtual appliance.  With user defined routing, the virtual appliance is used as a router between the virtual subnets on the virtual network.
2. **Port mirroring**. With port mirroring, all network traffic that is entering or leaving the monitored port is duplicated and sent to a virtual appliance for analysis. 
## <a name="bkmk_deploy"></a>Deploying a Network Virtual Appliance

To deploy a virtual appliance, you must first create a virtual machine (VM) that contains the appliance, and then connect the VM to the appropriate virtual network subnets.

>[!NOTE]
>For more information, see [Create a Tenant VM and Connect to a Tenant Virtual Network or VLAN](Create-a-Tenant-VM.md)

Some appliances require multiple virtual network adapters. Usually one network adapter is dedicated to the appliance management while additional adapters are used for processing traffic. 

If your appliance requires multiple network adapters, you must create each network interface in Network Controller. 

You must also assign an interface ID on each host for each of the additional adapters that are on different virtual subnets.

After you have completed network virtual appliance deployment, you can use the appliance for user defined routing, port mirroring, or both.

##<a name="bkmk_routing"></a>Example: User Defined Routing

For most environments you will only need the system routes already defined by the virtual network's distributed router. However, you might need to create a route table and add one or more routes in specific cases, such as:

* Force tunneling to the Internet via your on-premises network.
* Use of virtual appliances in your environment.

For these scenarios, you must create a route table and add user defined routes to the table. You can have multiple route tables, and the same route table can be associated to one or more subnets. 

Each subnet can only be associated to a single route table. All VMs in a subnet use the route table that is associated to that subnet.

Subnets rely on system routes until a route table is associated to the subnet. After an association exists, routing is done based on Longest Prefix Match (LPM) among both user defined routes and system routes. 

If there is more than one route with the same LPM match, then the user defined route is selected first - before the system route. 

###Step 1: Create the route table properties

This route table will contain all of the user defined routes.  System routes will still apply according to the rules defined above.

You can use the following example commands to create route table properties.

    $routetableproperties = new-object Microsoft.Windows.NetworkController.RouteTableProperties

###Step 2: Add a route to the route table properties

This route says that any traffic that is destined for the 12.0.0.0/8 subnet should get sent the the virtual appliance at 192.168.1.10 to be routed.  It is important that the appliance has a virtual network adapter attached to the virtual network with that IP assigned to a network interface.

You can use the following example commands to add a route to the route table properties.

    $route = new-object Microsoft.Windows.NetworkController.Route
    $route.ResourceID = "0_0_0_0_0"
    $route.properties = new-object Microsoft.Windows.NetworkController.RouteProperties
    $route.properties.AddressPrefix = "0.0.0.0/0"
    $route.properties.nextHopType = "VirtualAppliance"
    $route.properties.nextHopIpAddress = "192.168.1.10"
    $routetableproperties.routes += $route

You can add additional routes by repeating this step for each route you want to define.
s
###Step 3: Add the route table to Network Controller
You can use the following example commands to add the route table to Network Controller.

    $routetable = New-NetworkControllerRouteTable -ConnectionUri $uri -ResourceId "Route1" -Properties $routetableproperties

###Step 4: Apply the route table to the virtual subnet
 
When you apply the route table to the virtual subnet, the first virtual subnet in the Tenant1_Vnet1 network uses the route table. You can assign the route table to as many of the subnets in the virtual network as you want.

You can use the following example commands to apply the route table to the virtual subnet.

    $vnet = Get-NetworkControllerVirtualNetwork -ConnectionUri $uri -ResourceId "Tenant1_VNet1"
    $vnet.properties.subnets[0].properties.RouteTable = $routetable
    new-networkcontrollervirtualnetwork -connectionuri $uri -properties $vnet.properties -resourceId $vnet.resourceid

As soon as you apply the route table to the virtual network, traffic is forwarded to the virtual appliance. You must configure the routing table in the virtual appliance to forward the traffic, in a manner that is appropriate for your environment.

##<a name="bkmk_port"></a>Example: Port Mirroring

This example allows you to configure MyVM_Ethernet1's traffic so that the traffic is mirrored to Appliance_Ethernet1.

This example assumes that you've already deployed two VMs, one as the appliance and one as the VM to monitor with mirroring.

It is important that the appliance has a second network interface for management because after mirroring is enabled as a destination on Appliance_Ethernet1, it will no longer receive traffic that is destined for the IP interface configured there.

###Step 1: Get the virtual network on which your VMs are located
You can use the following example command to get the virtual network.

    $vnet = Get-NetworkControllerVirtualNetwork -ConnectionUri $uri -ResourceId "Tenant1_VNet1"

###Step 2: Get the Network Controller network interfaces for the mirroring source and destination
You can use the following example commands to obtain the Network Controller network interfaces for the mirroring source and destination.

    $dstNic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "Appliance_Ethernet1"
    $srcNic = get-networkcontrollernetworkinterface -ConnectionUri $uri -ResourceId "MyVM_Ethernet1"

###Step 3: Create a serviceinsertionproperties object to contain the port mirroring rules and the element which represents the destination interface
You can use the following example commands to create a destination serviceinsertionproperties object.

    $portmirror = [Microsoft.Windows.NetworkController.ServiceInsertionProperties]::new()
    $portMirror.Priority = 1

###Step 4: Create a serviceinsertionrules object to contain the rules that must be matched in order for the traffic to be sent to the appliance

The rules defined below match all traffic, both inbound and outbound, which represents a traditional mirror.  You can adjust these rules if you are interested in mirroring a specific port, or specific source/destinations.

You can use the following example commands to create a serviceinsertionproperties object.

    $portmirror.ServiceInsertionRules = [Microsoft.Windows.NetworkController.ServiceInsertionRule[]]::new(1)

    $portmirror.ServiceInsertionRules[0] = [Microsoft.Windows.NetworkController.ServiceInsertionRule]::new()
    $portmirror.ServiceInsertionRules[0].ResourceId = "Rule1"
    $portmirror.ServiceInsertionRules[0].Properties = [Microsoft.Windows.NetworkController.ServiceInsertionRuleProperties]::new()

    $portmirror.ServiceInsertionRules[0].Properties.Description = "Port Mirror Rule"
    $portmirror.ServiceInsertionRules[0].Properties.Protocol = "All"
    $portmirror.ServiceInsertionRules[0].Properties.SourcePortRangeStart = "0"
    $portmirror.ServiceInsertionRules[0].Properties.SourcePortRangeEnd = "65535"
    $portmirror.ServiceInsertionRules[0].Properties.DestinationPortRangeStart = "0"
    $portmirror.ServiceInsertionRules[0].Properties.DestinationPortRangeEnd = "65535"
    $portmirror.ServiceInsertionRules[0].Properties.SourceSubnets = "*"
    $portmirror.ServiceInsertionRules[0].Properties.DestinationSubnets = "*"

###Step 5: Create a serviceinsertionelements object to contain the network interface of the appliance you are mirroring to
You can use the following example commands to create a network interface serviceinsertionelements object.

    $portmirror.ServiceInsertionElements = [Microsoft.Windows.NetworkController.ServiceInsertionElement[]]::new(1)

    $portmirror.ServiceInsertionElements[0] = [Microsoft.Windows.NetworkController.ServiceInsertionElement]::new()
    $portmirror.ServiceInsertionElements[0].ResourceId = "Element1"
    $portmirror.ServiceInsertionElements[0].Properties = [Microsoft.Windows.NetworkController.ServiceInsertionElementProperties]::new()

    $portmirror.ServiceInsertionElements[0].Properties.Description = "Port Mirror Element"
    $portmirror.ServiceInsertionElements[0].Properties.NetworkInterface = $dstNic
    $portmirror.ServiceInsertionElements[0].Properties.Order = 1

###Step 6: Add the service insertion object in Network Controller
When you issue this command, all traffic to the appliance network interface specified in the previous step will stop.

You can use the following example commands to add the service insertion object in Network Controller.

    $portMirror = New-NetworkControllerServiceInsertion -ConnectionUri $uri -Properties $portmirror -ResourceId "MirrorAll"

###Step 7: Update the network interface of the source to be mirrored
You can use the following example commands to update the network interface.

    $srcNic.Properties.IpConfigurations[0].Properties.ServiceInsertion = $portMirror
    $srcNic = New-NetworkControllerNetworkInterface -ConnectionUri $uri  -Properties $srcNic.Properties -ResourceId $srcNic.ResourceId

When you have completed these steps, the traffic from the MyVM_Ethernet1 interface is  mirrored by the Appliance_Ethernet1 interface.
 
