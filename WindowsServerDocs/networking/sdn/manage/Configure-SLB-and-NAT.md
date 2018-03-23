---
title: Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 73bff8ba-939d-40d8-b1e5-3ba3ed5439c3
ms.author: pashort
author: shortpatti
---
# Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to use the Software Defined Networking \(SDN\)  software load balancer \(SLB\) to provide outbound network address translation NAT, inbound NAT, or load balancing between multiple instances of an application.

This topic contains the following sections.

- [Software Load Balancer Overview](#bkmk_slbover)
- [Example: Create a public VIP for load balancing a pool of two VMs on a virtual network](#bkmk_publicvip)
- [Example: Use SLB for outbound NAT](#bkmk_obnat)
- [Example: Add network interfaces to the back-end pool](#bkmk_backend)
- [Example: Use the Software Load Balancer for forwarding traffic](#bkmk_forward)

## <a name="bkmk_slbover"></a>Software Load Balancer Overview

The SDN Software Load Balancer \(SLB\) delivers high availability and network performance to your applications. It is a Layer 4 \(TCP, UDP\) load balancer that distributes incoming traffic among healthy service instances in cloud services or virtual machines defined in a load-balancer set.

You can configure SLB to do the following.

* Load balance incoming traffic external to a virtual network to virtual machines \(VMs\). This is called public VIP load balancing.
* Load balance incoming traffic between VMs in a virtual network, between VMs in cloud services, or between on-premises computers and VMs in a cross-premises virtual network. 
* Forward VM network traffic from the virtual network to external destinations using network address translation (NAT).  This is called outbound NAT.
* Forward external traffic to a specific VM.  This is called inbound NAT.

>[!IMPORTANT]
>A known issue prevents the Load Balancer objects in the NetworkController Windows PowerShell module from working correctly in  Windows Server 2016 5. The workaround is to use dynamic hash tables and Invoke-WebRequest instead. This method is demonstrated in the following examples.


## <a name="bkmk_publicvip"></a>Example: Create a public VIP for load balancing a pool of two VMs on a virtual network

You can use this example to create a load balancer object with a public VIP and two VMs as pool members to serve requests to the VIP.  This example code also adds a HTTP health probe to detect whether one of the pool members becomes non-responsive.

###Step 1: Prepare the load balancer object
You can use the following example to prepare the load balancer object.

    $lbresourceId = "LB2"

    $lbproperties = @{}
    $lbproperties.frontendipconfigurations = @()
    $lbproperties.backendAddressPools = @()
    $lbproperties.probes = @()
    $lbproperties.loadbalancingRules = @()
    $lbproperties.OutboundNatRules = @()

###Step 2: Assign a front-end IP
The front-end IP is commonly referred to as a Virtual IP (VIP).  The VIP must be taken from an unused IP in one of the logical network IP Pool which has been previously given to the load balancer manager.

You can use the following example to assign a front-end IP address.

    $vipip = "10.127.132.5"
    $vipln = get-networkcontrollerlogicalnetwork -ConnectionUri $uri -resourceid "f8f67956-3906-4303-94c5-09cf91e7e311"

    $fe = @{}
    $fe.resourceId = "FE1"
    $fe.resourceRef = "/loadBalancers/$lbresourceId/frontendIPConfigurations/$($fe.resourceId)"
    $fe.properties = @{}
    $fe.properties.subnet = @{}
    $fe.properties.subnet.ResourceRef = $vipln.properties.Subnets[0].ResourceRef
    $fe.properties.privateIPAddress = $vipip
    $fe.properties.privateIPAllocationMethod = "Static"
    $lbproperties.frontendipconfigurations += $fe

###Step 3: Allocate a backend address pool
The backend address pool contains the Dynamic IPs (DIPs) that make up the members of the load balanced set of VMs. In this step you only allocate the pool; the IP configurations are added in a later step.

You can use the following example to allocate a back-end address pool.
 
    $backend = @{}
    $backend.resourceId = "BE1"
    $backend.resourceRef = "/loadBalancers/$lbresourceId/backendAddressPools/$($backend.resourceId)"
    $lbproperties.backendAddressPools += $backend

###Step 4: Define a health probe
Health probes are used by the load balancer to determine the health state of the backend pool members. With this example, you define a HTTP probe that queries to the RequestPath of "/health.htm".  THe query is performed every 5 seconds, as specified by the IntervalInSeconds property.

The health probe must receive an HTTP response code of 200 for 11 consecutive queries for the probe to consider the backend IP to be healthy. If the backend IP is not healthy, the load balancer will not send traffic to the IP.

>[!Note]
>It is important that any Access Control Lists that you apply to the back-end IP do not block traffic to or from the first IP in the subnet, because that is the origination point for the probes.

You can use the following example to define a health probe.
 
    $lbprobe = @{}
    $lbprobe.ResourceId = "Probe1"
    $lbprobe.resourceRef = "/loadBalancers/$lbresourceId/Probes/$($lbprobe.resourceId)"
    $lbprobe.properties = @{}
    $lbprobe.properties.protocol = "HTTP"
    $lbprobe.properties.port = "80"
    $lbprobe.properties.RequestPath = "/health.htm"
    $lbprobe.properties.IntervalInSeconds = 5
    $lbprobe.properties.NumberOfProbes = 11
    $lbproperties.probes += $lbprobe

###Step 5: Define a load balancing rule
This load balancing rule defines how traffic that arrives at the front-end IP is to be sent to the backend IP.  In this example, TCP traffic to port 80 is sent to the backend pool.

You can use the following example to define a load balancing rule.

    $lbrule = @{}
    $lbrule.ResourceId = "webserver1"
    $lbrule.properties = @{}
    $lbrule.properties.FrontEndIPConfigurations = @()
    $lbrule.properties.FrontEndIPConfigurations += $fe
    $lbrule.properties.backendaddresspool = $backend 
    $lbrule.properties.protocol = "TCP"
    $lbrule.properties.frontendPort = 80
    $lbrule.properties.Probe = $lbprobe
    $lbproperties.loadbalancingRules += $lbrule

###Step 6: Add the load balancer configuration to Network Controller
Thus far in this example, all created objects are in the memory of the Windows PowerShell session. This step adds the objects to Network Controller.

You can use the following example to add the load balancer configuration to Network Controller.

    $lb = @{}
    $lb.ResourceId = $lbresourceid
    $lb.properties = $lbproperties

    $body = convertto-json $lb -Depth 100

    Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Put" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -Body $body -DisableKeepAlive -UseBasicParsing

After this step you will need to follow the example below to add the network interfaces to this backend pool.

## <a name="bkmk_obnat"></a>Example: Use SLB for outbound NAT

You can use this example to configure SLB with a back-end pool for providing outbound NAT capability for a VM on a virtual network's private address space to reach outbound to the internet.

###Step 1: Create the loadbalancer properties, front-end IP and Backend Pool.
You can use the following example to create the loadbalancer properties, front-end IP and Backend Pool.

    $lbresourceId = "OutboundNATMembers"
    $vipip = "10.127.132.7"

    $vipln = get-networkcontrollerlogicalnetwork -ConnectionUri $uri -resourceid "f8f67956-3906-4303-94c5-09cf91e7e311"

    $lbproperties = @{}
    $lbproperties.frontendipconfigurations = @()
    $lbproperties.backendAddressPools = @()
    $lbproperties.probes = @()
    $lbproperties.loadbalancingRules = @()
    $lbproperties.OutboundNatRules = @()

    $fe = @{}
    $fe.resourceId = "FE1"
    $fe.resourceRef = "/loadBalancers/$lbresourceId/frontendIPConfigurations/$($fe.resourceId)"
    $fe.properties = @{}
    $fe.properties.subnet = @{}
    $fe.properties.subnet.ResourceRef = $vipln.properties.Subnets[0].ResourceRef
    $fe.properties.privateIPAddress = $vipip
    $fe.properties.privateIPAllocationMethod = "Static"
    $lbproperties.frontendipconfigurations += $fe

    $backend = @{}
    $backend.resourceId = "BE1"
    $backend.resourceRef = "/loadBalancers/$lbresourceId/backendAddressPools/$($backend.resourceId)"
    $lbproperties.backendAddressPools += $backend

###Step 2: Define the outbound NAT rule
You can use the following example to define the outbound NAT rule. 

    $onat = @{}
    $onat.ResourceId = "onat1"
    $onat.properties = @{}
    $onat.properties.frontendipconfigurations = @()
    $onat.properties.frontendipconfigurations += $fe
    $onat.properties.backendaddresspool = $backend
    $onat.properties.protocol = "ALL"
    $lbproperties.OutboundNatRules += $onat

###Step 3: Add the load balancer object in Network Controller
You can use the following example to add the load balancer object in Network Controller.

    $lb = @{}
    $lb.ResourceId = $lbresourceid
    $lb.properties = $lbproperties

    $body = convertto-json $lb -Depth 100

    Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Put" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -Body $body -DisableKeepAlive -UseBasicParsing

In the next step, you can add the network interfaces to which you want to provide internet access.

## <a name="bkmk_backend"></a>Example: Add network interfaces to the back-end pool
You can use this example to add network interfaces to the back-end pool.

You must repeat this step for each network interface that can process requests that are made to the VIP. You can also repeat this process on a single network interface to add it to multiple load balancer objects. For example, if you have a load balancer object for a Web Server VIP and a separate load balancer object to provide outbound NAT.
    
### Step 1: Get the load balancer object containing the back-end pool to which you will add a network interface
You can use the following example to retrieve the load balancer object.

    $lbresourceid = "LB2"
    $lb = (Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Get" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -DisableKeepAlive -UseBasicParsing).content | convertfrom-json 

### Step 2: Get the network interface and add the backendaddress pool to the loadbalancerbackendaddresspools array.
You can use the following example to get the network interface and add the backendaddress pool to the loadbalancerbackendaddresspools array.

    $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
    $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
    
### Step 3: Put the network interface to apply the change
You can use the following example to put the network interface to apply the change.

    new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06 -properties $nic.properties -force
 
## <a name="bkmk_forward"></a>Example: Use the Software Load Balancer for forwarding traffic
If you need to map a Virtual IP to a single network interface on a virtual network without defining individual ports, you can create a L3 forwarding rule.  This rule forwards all traffic to and from the VM via the assigned VIP, which must be contained in a PublicIPAddress object.

If the VIP and DIP are defined as the same subnet, then this is equivalent to performing L3 forwarding without NAT.

>[!NOTE]
>This process does not require you to create a load balancer object.  Assigning the PublicIPAddress to the network interface is enough information for the Software Load Balancer to perform its configuration.

###Step 1: Create a public IP object to contain the VIP
You can use the following example to create a public IP object.

    $publicIPProperties = new-object Microsoft.Windows.NetworkController.PublicIpAddressProperties
    $publicIPProperties.ipaddress = "10.127.132.6"
    $publicIPProperties.PublicIPAllocationMethod = "static"
    $publicIPProperties.IdleTimeoutInMinutes = 4
    $publicIP = New-NetworkControllerPublicIpAddress -ResourceId "MyPIP" -Properties $publicIPProperties -ConnectionUri $uri

####Step 2: Assign the PublicIPAddress to a network interface
You can use the following example to assign the PublicIPAddress to a network interface.

    $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
    $nic.properties.IpConfigurations[0].Properties.PublicIPAddress = $publicIP
    New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $nic.ResourceId -Properties $nic.properties



 