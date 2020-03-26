---
title: Windows Server 2019 Gateway Performance
description: 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 
ms.author: lizross
author: eross-msft
ms.date: 08/22/2018
---

# Windows Server 2019 Gateway Performance

>Applies to: Windows Server


In Windows Server 2016, one of the customer concerns was the inability of SDN gateway to meet the throughput requirements of modern networks. The network throughput of IPsec and GRE tunnels had limitations with the single connection throughput for IPsec connectivity being about 300 Mbps and for GRE connectivity being about 2.5 Gbps.

We have improved significantly in Windows Server 2019, with the numbers soaring to 1.8 Gbps and 15 Gbps for IPsec and GRE connections, respectively. All this, with significant reductions in the CPU cycles/per byte, thereby providing
ultra-high-performance throughput with much less CPU utilization.

## Enable high performance with gateways in Windows Server 2019

For **GRE connections**, once you deploy/upgrade to Windows Server 2019 builds on the gateway VMs, you should automatically see the improved performance. No manual steps are involved.

For **IPsec connections**, by default, when you create the connection for your virtual networks, you get the Windows Server 2016 data path and performance numbers. To enable the Windows Server 2019 data path, do the following:

   1. On an SDN gateway VM, go to **Services** console (services.msc).
   2. Find the service named **Azure Gateway Service**, and set the startup type to **Automatic**.
   3. Restart the gateway VM.
      The active connections on this gateway failover to a redundant gateway VM.
   4. Repeat the previous steps for rest of the gateway VMs.

>[!TIP]
>For the best performance results, ensure that the cipherTransformationConstant and authenticationTransformConstant in quickMode settings of the IPsec connection uses the **GCMAES256** cipher suite.
>
>For maximum performance, the gateway host hardware must support AES-NI and PCLMULQDQ CPU instruction sets. These are available on any Westmere (32nm) and later Intel CPU except on models where AES-NI has been disabled. You can look at your hardware vendor documentation to see if the CPU supports AES-NI and PCLMULQDQ CPU instruction sets.

Below is a REST sample of IPsec connection with optimal security algorithms:

```PowerShell
# NOTE: The virtual gateway must be created before creating the IPsec connection. More details here.
# Create a new object for Tenant Network IPsec Connection  
$nwConnectionProperties = New-Object Microsoft.Windows.NetworkController.NetworkConnectionProperties   

# Update the common object properties  
$nwConnectionProperties.ConnectionType = "IPSec"   
$nwConnectionProperties.OutboundKiloBitsPerSecond = 2000000   
$nwConnectionProperties.InboundKiloBitsPerSecond = 2000000  

# Update specific properties depending on the Connection Type  
$nwConnectionProperties.IpSecConfiguration = New-Object Microsoft.Windows.NetworkController.IpSecConfiguration   
$nwConnectionProperties.IpSecConfiguration.AuthenticationMethod = "PSK"   
$nwConnectionProperties.IpSecConfiguration.SharedSecret = "111_aaa"   

$nwConnectionProperties.IpSecConfiguration.QuickMode = New-Object Microsoft.Windows.NetworkController.QuickMode   
$nwConnectionProperties.IpSecConfiguration.QuickMode.PerfectForwardSecrecy = "PFS2048"   
$nwConnectionProperties.IpSecConfiguration.QuickMode.AuthenticationTransformationConstant = "GCMAES256"   
$nwConnectionProperties.IpSecConfiguration.QuickMode.CipherTransformationConstant = "GCMAES256"   
$nwConnectionProperties.IpSecConfiguration.QuickMode.SALifeTimeSeconds = 3600   
$nwConnectionProperties.IpSecConfiguration.QuickMode.IdleDisconnectSeconds = 500   
$nwConnectionProperties.IpSecConfiguration.QuickMode.SALifeTimeKiloBytes = 2000   

$nwConnectionProperties.IpSecConfiguration.MainMode = New-Object Microsoft.Windows.NetworkController.MainMode   
$nwConnectionProperties.IpSecConfiguration.MainMode.DiffieHellmanGroup = "Group2"   
$nwConnectionProperties.IpSecConfiguration.MainMode.IntegrityAlgorithm = "SHA256"   
$nwConnectionProperties.IpSecConfiguration.MainMode.EncryptionAlgorithm = "AES256"   
$nwConnectionProperties.IpSecConfiguration.MainMode.SALifeTimeSeconds = 28800
$nwConnectionProperties.IpSecConfiguration.MainMode.SALifeTimeKiloBytes = 2000   

# L3 specific configuration (leave blank for IPSec)  
$nwConnectionProperties.IPAddresses = @()   
$nwConnectionProperties.PeerIPAddresses = @()   

# Update the IPv4 Routes that are reachable over the site-to-site VPN Tunnel  
$nwConnectionProperties.Routes = @()   
$ipv4Route = New-Object Microsoft.Windows.NetworkController.RouteInfo   
$ipv4Route.DestinationPrefix = "<<On premise subnet that must be reachable over the VPN tunnel. Ex: 10.0.0.0/24>>"   
$ipv4Route.metric = 10   
$nwConnectionProperties.Routes += $ipv4Route   

# Tunnel Destination (Remote Endpoint) Address  
$nwConnectionProperties.DestinationIPAddress = "<<Public IP address of the On-Premise VPN gateway. Ex: 192.168.3.4>>"   

# Add the new Network Connection for the tenant. Note that the virtual gateway must be created before creating the IPsec connection. $uri is the REST URI of your deployment and must be in the form of “https://<REST URI>”  
New-NetworkControllerVirtualGatewayNetworkConnection -ConnectionUri $uri -VirtualGatewayId $virtualGW.ResourceId -ResourceId "Contoso_IPSecGW" -Properties $nwConnectionProperties -Force
```

## Testing Results

We have done extensive performance testing for the SDN gateways in our test labs. In the tests, we have compared gateway network performance with Windows Server 2019 in SDN scenarios and non-SDN scenarios. You can find the results and test setup details captured in the blog article
[here](https://blogs.technet.microsoft.com/networking/2018/08/15/high-performance-gateways/).

---