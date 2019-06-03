---
title: Guest clustering in a virtual network
description: Virtual machines connected to a virtual network are only permitted to use the IP addresses that Network Controller has assigned to communicate on the network.  Clustering technologies that require a floating IP address, such as Microsoft Failover Clustering, require some extra steps to function correctly.
manager: dougkim
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e9e5c81-aa61-479e-abaf-64c5e95f90dc
ms.author: grcusanz
author: shortpatti
ms.date: 08/26/2018
---

# Guest clustering in a virtual network

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Virtual machines connected to a virtual network are only permitted to use the IP addresses that Network Controller has assigned to communicate on the network.  Clustering technologies that require a floating IP address, such as Microsoft Failover Clustering, require some extra steps to function correctly.

The method for making the floating IP reachable is to use a Software Load Balancer \(SLB\) virtual IP \(VIP\).  The software load balancer must be configured with a health probe on a port on that IP so that SLB directs traffic to the machine that currently has that IP.


## Example: Load balancer configuration

This example assumes that you've already created the VMs which will become cluster nodes, and attached them to a Virtual Network.  For guidance, refer to [Create a VM and Connect to a Tenant Virtual Network or VLAN](https://technet.microsoft.com/windows-server-docs/networking/sdn/manage/create-a-tenant-vm).  

In this example you will create a virtual IP address (192.168.2.100) to represent the floating IP address of the cluster, and configure a health probe to monitor TCP port 59999 to determine which node is the active one.

1. Select the VIP.<p>Prepare by assigning a VIP IP address, which can be any unused or reserved address in the same subnet as the cluster nodes.  The VIP must match the floating address of the cluster.

   ```PowerShell
   $VIP = "192.168.2.100"
   $subnet = "Subnet2"
   $VirtualNetwork = "MyNetwork"
   $ResourceId = "MyNetwork_InternalVIP"
   ```

2. Create the load balancer properties object.

   ```PowerShell
   $LoadBalancerProperties = new-object Microsoft.Windows.NetworkController.LoadBalancerProperties
   ```

3. Create a front\-end IP address.

   ```PowerShell
   $LoadBalancerProperties.frontendipconfigurations += $FrontEnd = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfiguration
   $FrontEnd.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfigurationProperties
   $FrontEnd.resourceId = "Frontend1"
   $FrontEnd.resourceRef = "/loadBalancers/$ResourceId/frontendIPConfigurations/$($FrontEnd.resourceId)"
   $FrontEnd.properties.subnet = new-object Microsoft.Windows.NetworkController.Subnet
   $FrontEnd.properties.subnet.ResourceRef = "/VirtualNetworks/MyNetwork/Subnets/Subnet2"
   $FrontEnd.properties.privateIPAddress = $VIP
   $FrontEnd.properties.privateIPAllocationMethod = "Static"
   ```

4. Create a back\-end pool to contain the cluster nodes.

   ```PowerShell
   $BackEnd = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPool
   $BackEnd.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPoolProperties
   $BackEnd.resourceId = "Backend1"
   $BackEnd.resourceRef = "/loadBalancers/$ResourceId/backendAddressPools/$($BackEnd.resourceId)"
   $LoadBalancerProperties.backendAddressPools += $BackEnd
   ```

5. Add a probe to detect which cluster node the floating address is currently active on. 

   >[!NOTE]
   >The probe query against the VM's permanent address at the port defined below.  The port must only respond on the active node. 

   ```PowerShell
   $LoadBalancerProperties.probes += $lbprobe = new-object Microsoft.Windows.NetworkController.LoadBalancerProbe
   $lbprobe.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerProbeProperties

   $lbprobe.ResourceId = "Probe1"
   $lbprobe.resourceRef = "/loadBalancers/$ResourceId/Probes/$($lbprobe.resourceId)"
   $lbprobe.properties.protocol = "TCP"
   $lbprobe.properties.port = "59999"
   $lbprobe.properties.IntervalInSeconds = 5
   $lbprobe.properties.NumberOfProbes = 11
   ```

6. Add the load balancing rules for TCP port 1433.<p>You can modify the protocol and port as needed.  You can also repeat this step multiple times for additional ports and protcols on this VIP.  It is important that EnableFloatingIP is set to $true because this tells the load balancer to send the packet to the node with the original VIP in place.

   ```PowerShell
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
   ```

7. Create the load balancer in Network Controller.

   ```PowerShell
   $lb = New-NetworkControllerLoadBalancer -ConnectionUri $URI -ResourceId $ResourceId -Properties $LoadBalancerProperties -Force
   ```

8. Add the cluster nodes to the backend pool.<p>You can add as many nodes to the pool as you require for the cluster.

   ```PowerShell
   # Cluster Node 1

   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid "ClusterNode1_Network-Adapter"
   $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
   $nic = new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid $nic.resourceid -properties $nic.properties -force

    # Cluster Node 2

   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid "ClusterNode2_Network-Adapter"
   $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
   $nic = new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid $nic.resourceid -properties $nic.properties -force
   ```

   Once you've created the load balancer and added the network interfaces to the backend pool, you are ready to configure the cluster.  

9. (Optional) If you are using a Microsoft Failover Cluster, continue with the next example. 

## Example 2: Configuring a Microsoft failover cluster

You can use the following steps to configure a failover cluster.

1. Install and configure properties for a failover cluster.

   ```PowerShell
   add-windowsfeature failover-clustering -IncludeManagementTools
   Import-module failoverclusters

   $ClusterName = "MyCluster"
   
   $ClusterNetworkName = "Cluster Network 1"
   $IPResourceName =  
   $ILBIP = “192.168.2.100” 

   $nodes = @("DB1", "DB2")
   ```

2. Create the cluster on one node.

   ```PowerShell
   New-Cluster -Name $ClusterName -NoStorage -Node $nodes[0]
   ```

3. Stop the cluster resource.

   ```PowerShell
   Stop-ClusterResource "Cluster Name" 
   ```

4. Set the cluster IP and probe port.<p>The IP address must match the front-end ip address used in the previous example, and the probe port must match the probe port in the previous example.

   ```PowerShell
   Get-ClusterResource "Cluster IP Address" | Set-ClusterParameter -Multiple @{"Address"="$ILBIP";"ProbePort"="59999";"SubnetMask"="255.255.255.255";"Network"="$ClusterNetworkName";"EnableDhcp"=0}
   ```

5. Start the cluster resources.

   ```PowerShell
    Start-ClusterResource "Cluster IP Address"  -Wait 60 
    Start-ClusterResource "Cluster Name"  -Wait 60 
   ```

6. Add the remaining nodes.

   ```PowerShell
   Add-ClusterNode $nodes[1]
   ```

_**Your cluster is active.**_ Traffic going to the VIP on the specified port is directed at the active node.

---