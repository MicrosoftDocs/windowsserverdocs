---
title: Guest Clustering in a Virtual Network
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e9e5c81-aa61-479e-abaf-64c5e95f90dc
ms.author: grcusanz
author: jamesmci
---

# Guest Clustering in a Virtual Network

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Virtual machines that are connected to a virtual network are only permitted to use the IP addresses that Network Controller has assigned in order to communicate on the network.  This means clustering technologies that require a floating IP address, such as Microsoft Failover Clustering, require some extra steps in order to function correctly.

The method for making the floating IP reachable is to use a Software Load Balancer \(SLB\) virtual IP \(VIP\).  The software load balancer must be configured with a health probe on a port on that IP so that SLB will direct traffic to the machine that currently has that IP.

## Example: Load balancer configuration

This example assumes that you've already created the VMs which will become cluster nodes, and attached them to a Virtual Network.  For guidance, refer to [Create a VM and Connect to a Tenant Virtual Network or VLAN](https://technet.microsoft.com/windows-server-docs/networking/sdn/manage/create-a-tenant-vm).  

In this example you will create a virtual IP address (192.168.2.100) to represent the floating IP address of the cluster, and configure a health probe to monitor TCP port 59999 to determine which node is the active one.

### Step 1: Select the VIP
Prepare by assigning a VIP IP address.  This address can be any unused or reserved address in the same subnet as the cluster nodes.  The VIP must match the floating address of the cluster.

    $VIP = "192.168.2.100"
    $subnet = "Subnet2"
    $VirtualNetwork = "MyNetwork"
    $ResourceId = "MyNetwork_InternalVIP"

### Step 2: Create the load balancer properties object

You can use the following example command to create the load balancer properties object.

    $LoadBalancerProperties = new-object Microsoft.Windows.NetworkController.LoadBalancerProperties

### Step 3: Create a front\-end IP address

You can use the following example command to create a front\-end IP address.

    $LoadBalancerProperties.frontendipconfigurations += $FrontEnd = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfiguration
    $FrontEnd.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfigurationProperties
    $FrontEnd.resourceId = "Frontend1"
    $FrontEnd.resourceRef = "/loadBalancers/$ResourceId/frontendIPConfigurations/$($FrontEnd.resourceId)"
    $FrontEnd.properties.subnet = new-object Microsoft.Windows.NetworkController.Subnet
    $FrontEnd.properties.subnet.ResourceRef = "/VirtualNetworks/MyNetwork/Subnets/Subnet2"
    $FrontEnd.properties.privateIPAddress = $VIP
    $FrontEnd.properties.privateIPAllocationMethod = "Static"

### Step 4: Create a back\-end pool to contain the cluster nodes

You can use the following example command to create a back\-end pool

    $BackEnd = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPool
    $BackEnd.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPoolProperties
    $BackEnd.resourceId = "Backend1"
    $BackEnd.resourceRef = "/loadBalancers/$ResourceId/backendAddressPools/$($BackEnd.resourceId)"
    $LoadBalancerProperties.backendAddressPools += $BackEnd

### Step 5: Add a probe
The probe is necessary to detect which cluster node the floating address is currently active on.

>[!NOTE]
>The probe query against the VM's permanent address at the port defined below.  The port must only respond on the active node. 

    $LoadBalancerProperties.probes += $lbprobe = new-object Microsoft.Windows.NetworkController.LoadBalancerProbe
    $lbprobe.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerProbeProperties

    $lbprobe.ResourceId = "Probe1"
    $lbprobe.resourceRef = "/loadBalancers/$ResourceId/Probes/$($lbprobe.resourceId)"
    $lbprobe.properties.protocol = "TCP"
    $lbprobe.properties.port = "59999"
    $lbprobe.properties.IntervalInSeconds = 5
    $lbprobe.properties.NumberOfProbes = 11

### Step 5: Add the load balancing rules
This step creates a load balancing rule for TCP port 1433.  You can modify the protocol and port as needed.  You can also repeat this step multiple times for additional ports and protcols on this VIP.  It is important that EnableFloatingIP is set to $true because this tells the load balancer to send the packet to the node with the original VIP in place.

    $LoadBalancerProperties.loadbalancingRules += $lbrule = new-object Microsoft.Windows.NetworkController.LoadBalancingRule
    $lbrule.properties = new-object Microsoft.Windows.NetworkController.LoadBalancingRuleProperties
    $lbrule.ResourceId = "Rules1"

    $lbrule.properties.frontendipconfigurations += $FrontEnd
    $lbrule.properties.backendaddresspool = $BackEnd 
    $lbrule.properties.protocol = "TCP"
    $lbrule.properties.frontendPort = $lbrule.properties.backendPort = 1433 
    $lbrule.properties.IdleTimeoutInMinutes = 4
    $lbrule.properties.EnableFloatingIP = $true
    $lbrule.properties.Probe = $lbprobe

### Step 5: Create the load balancer in Network Controller

You can use the following example command to create the load balancer.

    $lb = New-NetworkControllerLoadBalancer -ConnectionUri $URI -ResourceId $ResourceId -Properties $LoadBalancerProperties -Force

### Step 6: Add the cluster nodes to the backend pool

This example shows adding two pool members, but you can add as many nodes to the pool as you require for the cluster.

    # Cluster Node 1

    $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid "ClusterNode1_Network-Adapter"
    $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
    $nic = new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid $nic.resourceid -properties $nic.properties -force

    # Cluster Node 2

    $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid "ClusterNode2_Network-Adapter"
    $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
    $nic = new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid $nic.resourceid -properties $nic.properties -force

Once you've created the load balancer and added the network interfaces to the backend pool, you are ready to configure the cluster.  If you are using a Microsoft Failover Cluster you can continue with the next example. 

## Example 2: Configuring a Microsoft Failover Cluster

You can use the following steps to configure a failover cluster.

### Step 1: Install failover clustering

You can use the following example commands to install and configure properties for a failover cluster.

    add-windowsfeature failover-clustering -IncludeManagementTools
    Import-module failoverclusters

    $ClusterName = "MyCluster"
   
    $ClusterNetworkName = "Cluster Network 1"
    $IPResourceName =  
    $ILBIP = “192.168.2.100” 

    $nodes = @("DB1", "DB2")

### Step 2: Create the cluster on one node

You can use the following example command to create the cluster on a node.

    New-Cluster -Name $ClusterName -NoStorage -Node $nodes[0]

### Step 3: Stop the cluster resource

You can use the following example command to stop the cluster resource.

    Stop-ClusterResource "Cluster Name" 

### Step 4: Set the cluster IP and probe port
The IP address must match the front-end ip address used in the previous example, and the probe port must match the probe port in the previous example.

    Get-ClusterResource "Cluster IP Address" | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"="59999";"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}

### Step 5: Start the cluster resources

You can use the following example command to start the cluster resources.

    Start-ClusterResource "Cluster IP Address"  -Wait 60 
    Start-ClusterResource "Cluster Name"  -Wait 60 

### Step 6: Add the remaining nodes

You can use the following example command to add cluster nodes.

    Add-ClusterNode $nodes[1]

Upon completion of the last step, your cluster is active. Traffic going to the VIP on the specified port will be directed at the active node.