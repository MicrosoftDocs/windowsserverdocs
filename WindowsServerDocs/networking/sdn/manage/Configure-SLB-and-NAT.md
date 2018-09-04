---
title: Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: elizapo
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
ms.date: 08/23/2018
---
# Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to use the Software Defined Networking \(SDN\)  software load balancer \(SLB\) to provide outbound network address translation NAT, inbound NAT, or load balancing between multiple instances of an application.

This topic contains the following sections.

- [Software Load Balancer Overview](#bkmk_slbover)
- [Example: Create a public VIP for load balancing a pool of two VMs on a virtual network](#bkmk_publicvip)
- [Example: Use SLB for outbound NAT](#bkmk_obnat)
- [Example: Add network interfaces to the back-end pool](#bkmk_backend)
- [Example: Use the Software Load Balancer for forwarding traffic](#bkmk_forward)

## Software Load Balancer overview

The SDN Software Load Balancer \(SLB\) delivers high availability and network performance to your applications. It is a Layer 4 \(TCP, UDP\) load balancer that distributes incoming traffic among healthy service instances in cloud services or virtual machines defined in a load balancer set.

Configure SLB to do the following:

- Load balance incoming traffic external to a virtual network to virtual machines \(VMs\), also called public VIP load balancing.
- Load balance incoming traffic between VMs in a virtual network, between VMs in cloud services, or between on-premises computers and VMs in a cross-premises virtual network. 
- Forward VM network traffic from the virtual network to external destinations using network address translation (NAT), also called outbound NAT.
- Forward external traffic to a specific VM, also called inbound NAT.

>[!IMPORTANT]
>A known issue prevents the Load Balancer objects in the NetworkController Windows PowerShell module from working correctly in Windows Server 2016 5. Use dynamic hash tables and Invoke-WebRequest instead., shown in the following examples in this topic.



## Example: Create a public VIP for load balancing a pool of two VMs on a virtual network

In this example, you create a load balancer object with a public VIP and two VMs as pool members to serve requests to the VIP. This example code also adds an HTTP health probe to detect whether one of the pool members becomes non-responsive.

1. Prepare the load balancer object.

   ```PowerShell
   $lbresourceId = "LB2"

   $lbproperties = @{}
   $lbproperties.frontendipconfigurations = @()
   $lbproperties.backendAddressPools = @()
   $lbproperties.probes = @()
   $lbproperties.loadbalancingRules = @()
   $lbproperties.OutboundNatRules = @()
   ```

2. Assign a front-end IP address, commonly referred to as a Virtual IP (VIP).<p>The VIP must be from an unused IP in one of the logical network IP pools given to the load balancer manager. 

   ```PowerShell
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
   ```

3. Allocate a back-end address pool, which contains the Dynamic IPs (DIPs) that make up the members of the load-balanced set of VMs. 

   ```PowerShell 
   $backend = @{}
   $backend.resourceId = "BE1"
   $backend.resourceRef = "/loadBalancers/$lbresourceId/backendAddressPools/$($backend.resourceId)"
   $lbproperties.backendAddressPools += $backend
   ```

4. Define a health probe that the load balancer uses to determine the health state of the backend pool members.<p>In this example, you define an HTTP probe that queries to the RequestPath of "/health.htm."  The query runs every 5 seconds, as specified by the IntervalInSeconds property.<p>The health probe must receive an HTTP response code of 200 for 11 consecutive queries for the probe to consider the back-end IP to be healthy. If the back-end IP is not healthy, it does not receive traffic from the load balancer.

   >[!IMPORTANT]
   >Do not block traffic to or from the first IP in the subnet for any Access Control Lists (ACLs) that you apply to the back-end IP because that is the origination point for the probes.

   Use the following example to define a health probe.

   ```PowerShell
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
   ```

5.  Define a load balancing rule to send traffic that arrives at the front-end IP to the back-end IP.  In this example, the back-end pool receives TCP traffic to port 80.<p> Use the following example to define a load balancing rule:

   ```PowerShell
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
   ```

6. Add the load balancer configuration to Network Controller.<p>Use the following example to add the load balancer configuration to Network Controller:

   ```PowerShell
   $lb = @{}
   $lb.ResourceId = $lbresourceid
   $lb.properties = $lbproperties

   $body = convertto-json $lb -Depth 100

   Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Put" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -Body $body -DisableKeepAlive -UseBasicParsing
   ```

7. Follow the next example to add the network interfaces to this back-end pool.


## Example: Use SLB for outbound NAT

In this example, you configure SLB with a back-end pool for providing outbound NAT capability for a VM on a virtual network’s private address space to reach outbound to the internet. 

1. Create the load balancer properties, front-end IP, and back-end pool.

   ```PowerShell
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
   ```

2. Define the outbound NAT rule.

   ```PowerShell
   $onat = @{}
   $onat.ResourceId = "onat1"
   $onat.properties = @{}
   $onat.properties.frontendipconfigurations = @()
   $onat.properties.frontendipconfigurations += $fe
   $onat.properties.backendaddresspool = $backend
   $onat.properties.protocol = "ALL"
   $lbproperties.OutboundNatRules += $onat
   ```

3. Add the load balancer object in Network Controller.

   ```PowerShell
   $lb = @{}
   $lb.ResourceId = $lbresourceid
   $lb.properties = $lbproperties

   $body = convertto-json $lb -Depth 100

   Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Put" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -Body $body -DisableKeepAlive -UseBasicParsing
   ```

4. Follow the next example to add the network interfaces to which you want to provide internet access.

## Example: Add network interfaces to the back-end pool
In this example, you add network interfaces to the back-end pool.  You must repeat this step for each network interface that can process requests made to the VIP. 

You can also repeat this process on a single network interface to add it to multiple load balancer objects. For example, if you have a load balancer object for a web server VIP and a separate load balancer object to provide outbound NAT.
    
1. Get the load balancer object containing the back-end pool to add a network interface.

   ```PowerShell
   $lbresourceid = "LB2"
   $lb = (Invoke-WebRequest -Headers @{"Accept"="application/json"} -ContentType "application/json; charset=UTF-8" -Method "Get" -Uri "$uri/Networking/v1/loadbalancers/$lbresourceid" -DisableKeepAlive -UseBasicParsing).content | convertfrom-json 
  ```

2. Get the network interface and add the backendaddress pool to the loadbalancerbackendaddresspools array.

   ```PowerShell
   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
   $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
   ```  

3. Put the network interface to apply the change. 

   ```PowerShell
   new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06 -properties $nic.properties -force
   ``` 


## Example: Use the Software Load Balancer for forwarding traffic
If you need to map a Virtual IP to a single network interface on a virtual network without defining individual ports, you can create an L3 forwarding rule.  This rule forwards all traffic to and from the VM via the assigned VIP contained in a PublicIPAddress object.

If you defined the VIP and DIP as the same subnet, then this is equivalent to performing L3 forwarding without NAT.

>[!NOTE]
>This process does not require you to create a load balancer object.  Assigning the PublicIPAddress to the network interface is enough information for the Software Load Balancer to perform its configuration.


1. Create a public IP object to contain the VIP.

   ```PowerShell
   $publicIPProperties = new-object Microsoft.Windows.NetworkController.PublicIpAddressProperties
   $publicIPProperties.ipaddress = "10.127.132.6"
   $publicIPProperties.PublicIPAllocationMethod = "static"
   $publicIPProperties.IdleTimeoutInMinutes = 4
   $publicIP = New-NetworkControllerPublicIpAddress -ResourceId "MyPIP" -Properties $publicIPProperties -ConnectionUri $uri
   ```

2. Assign the PublicIPAddress to a network interface.

   ```PowerShell
   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
   $nic.properties.IpConfigurations[0].Properties.PublicIPAddress = $publicIP
   New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $nic.ResourceId -Properties $nic.properties
   ```

---


 