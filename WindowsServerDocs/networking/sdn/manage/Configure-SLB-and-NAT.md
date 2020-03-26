---
title: Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)
description: This topic is part of the Software Defined Networking guide on how to Manage Tenant Workloads and Virtual Networks in Windows Server 2016.
manager: dougkim
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 73bff8ba-939d-40d8-b1e5-3ba3ed5439c3
ms.author: lizross
author: eross-msft
ms.date: 08/23/2018
---
# Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to use the Software Defined Networking \(SDN\)  software load balancer \(SLB\) to provide outbound network address translation \(NAT\), inbound NAT, or load balancing between multiple instances of an application.

## Software Load Balancer overview

The SDN Software Load Balancer \(SLB\) delivers high availability and network performance to your applications. It is a Layer 4 \(TCP, UDP\) load balancer that distributes incoming traffic among healthy service instances in cloud services or virtual machines defined in a load balancer set.

Configure SLB to do the following:

- Load balance incoming traffic external to a virtual network to virtual machines \(VMs\), also called public VIP load balancing.
- Load balance incoming traffic between VMs in a virtual network, between VMs in cloud services, or between on-premises computers and VMs in a cross-premises virtual network. 
- Forward VM network traffic from the virtual network to external destinations using network address translation (NAT), also called outbound NAT.
- Forward external traffic to a specific VM, also called inbound NAT.




## Example: Create a public VIP for load balancing a pool of two VMs on a virtual network

In this example, you create a load balancer object with a public VIP and two VMs as pool members to serve requests to the VIP. This example code also adds an HTTP health probe to detect whether one of the pool members becomes non-responsive.

1. Prepare the load balancer object.

   ```PowerShell
    import-module NetworkController

    $URI = "https://sdn.contoso.com"

    $LBResourceId = "LB2"

    $LoadBalancerProperties = new-object Microsoft.Windows.NetworkController.LoadBalancerProperties
   ```

2. Assign a front-end IP address, commonly referred to as a Virtual IP (VIP).<p>The VIP must be from an unused IP in one of the logical network IP pools given to the load balancer manager. 

   ```PowerShell
    $VIPIP = "10.127.134.5"
    $VIPLogicalNetwork = get-networkcontrollerlogicalnetwork -ConnectionUri $uri -resourceid "PublicVIP" -PassInnerException
    
    $FrontEndIPConfig = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfiguration
    $FrontEndIPConfig.ResourceId = "FE1"
    $FrontEndIPConfig.ResourceRef = "/loadBalancers/$LBResourceId/frontendIPConfigurations/$($FrontEndIPConfig.ResourceId)"

    $FrontEndIPConfig.Properties = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfigurationProperties
    $FrontEndIPConfig.Properties.Subnet = new-object Microsoft.Windows.NetworkController.Subnet
    $FrontEndIPConfig.Properties.Subnet.ResourceRef = $VIPLogicalNetwork.Properties.Subnets[0].ResourceRef
    $FrontEndIPConfig.Properties.PrivateIPAddress = $VIPIP
    $FrontEndIPConfig.Properties.PrivateIPAllocationMethod = "Static"
      
    $LoadBalancerProperties.FrontEndIPConfigurations += $FrontEndIPConfig
   ```

3. Allocate a back-end address pool, which contains the Dynamic IPs (DIPs) that make up the members of the load-balanced set of VMs. 

   ```PowerShell 
    $BackEndAddressPool = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPool
    $BackEndAddressPool.ResourceId = "BE1"
    $BackEndAddressPool.ResourceRef = "/loadBalancers/$LBResourceId/backendAddressPools/$($BackEndAddressPool.ResourceId)"

    $BackEndAddressPool.Properties = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPoolProperties

    $LoadBalancerProperties.backendAddressPools += $BackEndAddressPool
   ```

4. Define a health probe that the load balancer uses to determine the health state of the backend pool members.<p>In this example, you define an HTTP probe that queries to the RequestPath of "/health.htm."  The query runs every 5 seconds, as specified by the IntervalInSeconds property.<p>The health probe must receive an HTTP response code of 200 for 11 consecutive queries for the probe to consider the back-end IP to be healthy. If the back-end IP is not healthy, it does not receive traffic from the load balancer.

   >[!IMPORTANT]
   >Do not block traffic to or from the first IP in the subnet for any Access Control Lists (ACLs) that you apply to the back-end IP because that is the origination point for the probes.

   Use the following example to define a health probe.

   ```PowerShell
    $Probe = new-object Microsoft.Windows.NetworkController.LoadBalancerProbe
    $Probe.ResourceId = "Probe1"
    $Probe.ResourceRef = "/loadBalancers/$LBResourceId/Probes/$($Probe.ResourceId)"

    $Probe.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerProbeProperties
    $Probe.properties.Protocol = "HTTP"
    $Probe.properties.Port = "80"
    $Probe.properties.RequestPath = "/health.htm"
    $Probe.properties.IntervalInSeconds = 5
    $Probe.properties.NumberOfProbes = 11

    $LoadBalancerProperties.Probes += $Probe
   ```

5. Define a load balancing rule to send traffic that arrives at the front-end IP to the back-end IP.  In this example, the back-end pool receives TCP traffic to port 80.<p>Use the following example to define a load balancing rule:

   ```PowerShell
   $Rule = new-object Microsoft.Windows.NetworkController.LoadBalancingRule
   $Rule.ResourceId = "webserver1"

   $Rule.Properties = new-object Microsoft.Windows.NetworkController.LoadBalancingRuleProperties
   $Rule.Properties.FrontEndIPConfigurations += $FrontEndIPConfig
   $Rule.Properties.backendaddresspool = $BackEndAddressPool 
   $Rule.Properties.protocol = "TCP"
   $Rule.Properties.FrontEndPort = 80
   $Rule.Properties.BackEndPort = 80
   $Rule.Properties.IdleTimeoutInMinutes = 4
   $Rule.Properties.Probe = $Probe

   $LoadBalancerProperties.loadbalancingRules += $Rule
   ```

6. Add the load balancer configuration to Network Controller.<p>Use the following example to add the load balancer configuration to Network Controller:

   ```PowerShell
    $LoadBalancerResource = New-NetworkControllerLoadBalancer -ConnectionUri $URI -ResourceId $LBResourceId -Properties $LoadBalancerProperties -Force -PassInnerException
   ```

7. Follow the next example to add the network interfaces to this back-end pool.


## Example: Use SLB for outbound NAT

In this example, you configure SLB with a back-end pool for providing outbound NAT capability for a VM on a virtual network's private address space to reach outbound to the internet. 

1. Create the load balancer properties, front-end IP, and back-end pool.

   ```PowerShell
    import-module NetworkController
    $URI = "https://sdn.contoso.com"

    $LBResourceId = "OutboundNATMMembers"
    $VIPIP = "10.127.134.6"

    $VIPLogicalNetwork = get-networkcontrollerlogicalnetwork -ConnectionUri $uri -resourceid "PublicVIP" -PassInnerException

    $LoadBalancerProperties = new-object Microsoft.Windows.NetworkController.LoadBalancerProperties

    $FrontEndIPConfig = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfiguration
    $FrontEndIPConfig.ResourceId = "FE1"
    $FrontEndIPConfig.ResourceRef = "/loadBalancers/$LBResourceId/frontendIPConfigurations/$($FrontEndIPConfig.ResourceId)"

    $FrontEndIPConfig.Properties = new-object Microsoft.Windows.NetworkController.LoadBalancerFrontendIpConfigurationProperties
    $FrontEndIPConfig.Properties.Subnet = new-object Microsoft.Windows.NetworkController.Subnet
    $FrontEndIPConfig.Properties.Subnet.ResourceRef = $VIPLogicalNetwork.Properties.Subnets[0].ResourceRef
    $FrontEndIPConfig.Properties.PrivateIPAddress = $VIPIP
    $FrontEndIPConfig.Properties.PrivateIPAllocationMethod = "Static"

    $LoadBalancerProperties.FrontEndIPConfigurations += $FrontEndIPConfig

    $BackEndAddressPool = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPool
    $BackEndAddressPool.ResourceId = "BE1"
    $BackEndAddressPool.ResourceRef = "/loadBalancers/$LBResourceId/backendAddressPools/$($BackEndAddressPool.ResourceId)"
    $BackEndAddressPool.Properties = new-object Microsoft.Windows.NetworkController.LoadBalancerBackendAddressPoolProperties

    $LoadBalancerProperties.backendAddressPools += $BackEndAddressPool
   ```

2. Define the outbound NAT rule.

   ```PowerShell
    $OutboundNAT = new-object Microsoft.Windows.NetworkController.LoadBalancerOutboundNatRule
    $OutboundNAT.ResourceId = "onat1"
    
    $OutboundNAT.properties = new-object Microsoft.Windows.NetworkController.LoadBalancerOutboundNatRuleProperties
    $OutboundNAT.properties.frontendipconfigurations += $FrontEndIPConfig
    $OutboundNAT.properties.backendaddresspool = $BackEndAddressPool
    $OutboundNAT.properties.protocol = "ALL"

    $LoadBalancerProperties.OutboundNatRules += $OutboundNAT
   ```

3. Add the load balancer object in Network Controller.

   ```PowerShell
    $LoadBalancerResource = New-NetworkControllerLoadBalancer -ConnectionUri $URI -ResourceId $LBResourceId -Properties $LoadBalancerProperties -Force -PassInnerException
   ```

4. Follow the next example to add the network interfaces to which you want to provide internet access.

## Example: Add network interfaces to the back-end pool
In this example, you add network interfaces to the back-end pool.  You must repeat this step for each network interface that can process requests made to the VIP. 

You can also repeat this process on a single network interface to add it to multiple load balancer objects. For example, if you have a load balancer object for a web server VIP and a separate load balancer object to provide outbound NAT.
    
1. Get the load balancer object containing the back-end pool to add a network interface.

   ```PowerShell
   $lbresourceid = "LB2"
   $lb = get-networkcontrollerloadbalancer -connectionuri $uri -resourceID $LBResourceId -PassInnerException
   ```

2. Get the network interface and add the backendaddress pool to the loadbalancerbackendaddresspools array.

   ```PowerShell
   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06 -PassInnerException
   $nic.properties.IpConfigurations[0].properties.LoadBalancerBackendAddressPools += $lb.properties.backendaddresspools[0]
   ```  

3. Put the network interface to apply the change. 

   ```PowerShell
   new-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06 -properties $nic.properties -force -PassInnerException
   ``` 


## Example: Use the Software Load Balancer for forwarding traffic
If you need to map a Virtual IP to a single network interface on a virtual network without defining individual ports, you can create an L3 forwarding rule.  This rule forwards all traffic to and from the VM via the assigned VIP contained in a PublicIPAddress object.

If you defined the VIP and DIP as the same subnet, then this is equivalent to performing L3 forwarding without NAT.

>[!NOTE]
>This process does not require you to create a load balancer object.  Assigning the PublicIPAddress to the network interface is enough information for the Software Load Balancer to perform its configuration.


1. Create a public IP object to contain the VIP.

   ```PowerShell
   $publicIPProperties = new-object Microsoft.Windows.NetworkController.PublicIpAddressProperties
   $publicIPProperties.ipaddress = "10.127.134.7"
   $publicIPProperties.PublicIPAllocationMethod = "static"
   $publicIPProperties.IdleTimeoutInMinutes = 4
   $publicIP = New-NetworkControllerPublicIpAddress -ResourceId "MyPIP" -Properties $publicIPProperties -ConnectionUri $uri -Force -PassInnerException
   ```

2. Assign the PublicIPAddress to a network interface.

   ```PowerShell
   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
   $nic.properties.IpConfigurations[0].Properties.PublicIPAddress = $publicIP
   New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $nic.ResourceId -Properties $nic.properties -PassInnerException
   ```

## Example: Use the Software Load Balancer for forwarding traffic with a dynamically allocated VIP
This example repeats the same action as the previous example, but it automatically allocates the VIP from the available pool of VIPs in the load balancer instead of specifying a specific IP Address. 

1. Create a public IP object to contain the VIP.

   ```PowerShell
   $publicIPProperties = new-object Microsoft.Windows.NetworkController.PublicIpAddressProperties
   $publicIPProperties.PublicIPAllocationMethod = "dynamic"
   $publicIPProperties.IdleTimeoutInMinutes = 4
   $publicIP = New-NetworkControllerPublicIpAddress -ResourceId "MyPIP" -Properties $publicIPProperties -ConnectionUri $uri -Force -PassInnerException
   ```

2. Query the PublicIPAddress resource to determine which IP Address was assigned.

   ```PowerShell
    (Get-NetworkControllerPublicIpAddress -ConnectionUri $uri -ResourceId "MyPIP").properties
   ```

   The IpAddress property contains the assigned address.  The output will look similar to this:
   ```
    Counters                 : {}
    ConfigurationState       :
    IpAddress                : 10.127.134.2
    PublicIPAddressVersion   : IPv4
    PublicIPAllocationMethod : Dynamic
    IdleTimeoutInMinutes     : 4
    DnsSettings              :
    ProvisioningState        : Succeeded
    IpConfiguration          :
    PreviousIpConfiguration  :
   ```
 
3. Assign the PublicIPAddress to a network interface.

   ```PowerShell
   $nic = get-networkcontrollernetworkinterface  -connectionuri $uri -resourceid 6daca142-7d94-0000-1111-c38c0141be06
   $nic.properties.IpConfigurations[0].Properties.PublicIPAddress = $publicIP
   New-NetworkControllerNetworkInterface -ConnectionUri $uri -ResourceId $nic.ResourceId -Properties $nic.properties -PassInnerException
   ```
   ## Example: Remove a PublicIP address that is being used for forwarding traffic and return it to the VIP pool
   This example removes the PublicIPAddress resource that was created by the previous examples.  Once the PublicIPAddress is removed, the reference to the PublicIPAddress will automatically be removed from the network interface, the traffic will stop being forwarded, and the IP address will be returned to the Public VIP pool for re-use.  

4. Remove the PublicIP

   ```PowerShell
   Remove-NetworkControllerPublicIPAddress -ConnectionURI $uri -ResourceId "MyPIP"
   ```

---


 