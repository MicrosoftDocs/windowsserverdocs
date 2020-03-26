---
title: Windows Server supported networking scenarios
description: This topic provides information about new supported Networking scenarios in Windows Server 2016 and later
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.date: 
ms.assetid: 6de4232d-b0b3-4e43-8735-ebae35ae4f9f
ms.author: lizross
author: eross-msft
---
# Windows Server supported networking scenarios

>Applies to: Windows Server \(Semi-Annual Channel\), Windows Server 2016

This topic provides information about supported and unsupported scenarios that you can or cannot perform with this release of Windows Server 2016.  
>[!IMPORTANT]
>For all production scenarios, use the latest signed hardware drivers from your original equipment manufacturer \(OEM\) or independent hardware vendor \(IHV\).
  
## <a name="bkmk_supp"></a>Supported Networking Scenarios

This section includes information about the supported networking scenarios for Windows Server 2016, and includes the following scenario categories.  
  
-   [Software Defined Networking (SDN) scenarios](#bkmk_sdn)  
  
-   [Network Platform scenarios](#bkmk_netp)  
  
-   [DNS Server scenarios](#bkmk_dns)  
  
-   [IPAM scenarios with DHCP and DNS](#bkmk_ipam)  
  
-   [NIC Teaming scenarios](#bkmk_nicteam)

- [Switch Embedded Teaming \(SET\) scenarios](#bkmk_set)
  
### <a name="bkmk_sdn"></a>Software Defined Networking (SDN) scenarios
 
You can use the following documentation to deploy SDN scenarios with Windows Server 2016.  
  
  
-   [Deploy a Software Defined Network infrastructure using scripts](sdn/deploy/Deploy-a-Software-Defined-Network-infrastructure-using-scripts.md)  
  
For more information, see [Software Defined Networking &#40;SDN&#41;](sdn/software-defined-networking.md).  
  
#### <a name="bkmk_netc"></a>Network Controller scenarios

The Network Controller scenarios allow you to:  
  
-   Deploy and manage a multiple-node instance of Network Controller. For more information, see [Deploy Network Controller using Windows PowerShell](sdn/deploy/Deploy-Network-Controller-using-Windows-PowerShell.md).  
  
-   Use Network Controller to programmatically define network policy by using the REST Northbound API.  
  
-   Use Network Controller to create and manage virtual networks with Hyper-V Network Virtualization - using NVGRE or VXLAN encapsulation.  
  
For more information, see [Network Controller](sdn/technologies/network-controller/Network-Controller.md).  
  
#### <a name="bkmk_netf"></a>Network Function Virtualization (NFV) scenarios  
The NFV scenarios allow you to:  
  
-   Deploy and use a software load balancer to distribute both northbound and southbound traffic.  
  
-   Deploy and use a software load balancer to distribute eastbound and westbound traffic for virtual networks created with Hyper-V Network Virtualization.  
  
-   Deploy and use a NAT software load balancer for virtual networks created with Hyper-V Network Virtualization.  
  
-   Deploy and use a Layer 3 forwarding gateway  
  
-   Deploy and use a virtual private network (VPN) gateway for site-to-site IPsec (IKEv2) tunnels  
  
-   Deploy and use a Generic Routing Encapsulation (GRE) gateway.  
  
-   Deploy and configure dynamic routing and transit routing between sites using Border Gateway Protocol (BGP).  
  
-   Configure M+N redundancy for Layer 3 and site-to-site gateways, and for BGP routing.  
  
-   Use Network Controller to specify ACLs on virtual networks and network interfaces.  
  
For more information, see [Network Function Virtualization](sdn/technologies/network-function-virtualization/Network-Function-Virtualization.md).  
  
### <a name="bkmk_netp"></a>Network Platform scenarios

For the scenarios in this section the Windows Server Networking team supports the use of any Windows Server 2016 certified driver. Please check with your network interface card \(NIC\) manufacturer to ensure you have the most recent driver updates.
  
The network platform scenarios allow you to:  
  
-   Use a converged NIC to combine both RDMA and Ethernet traffic using a single network adapter.  
  
-   Create a low-latency data path by using Packet Direct, enabled in the Hyper-V Virtual Switch, and a single network adapter.  
  
-   Configure SET to spread SMB Direct and RDMA traffic flows between up to two network adapters.  
  
For more information, see [Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).  
  
#### <a name="bkmk_switch"></a>Hyper-V Virtual Switch Scenarios

The Hyper-V Virtual Switch scenarios allow you to:  
  
-   Create a Hyper-V Virtual Switch with a Remote Direct Memory Access (RDMA) vNIC  
  
-   Create a Hyper-V Virtual Switch with Switch Embedded Teaming (SET) and RDMA vNICs  
  
-   Create a SET team in Hyper-V Virtual Switch  
  
-   Manage a SET team by using Windows PowerShell commands  
  
For more information, see [Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md)  
  
### <a name="bkmk_dns"></a>DNS Server scenarios

DNS Server scenarios allow you to:  
  
-   Specify Geo-Location based traffic management using DNS Policies  
  
-   Configure split-brain DNS using DNS Policies  
  
-   Apply filters on DNS queries  using DNS Policies  
  
-   Configure Application Load Balancing using DNS Policies  
  
-   Specify Intelligent DNS Responses based on the time of day  
  
-   Configure DNS Zone transfer policies  
  
-   Configure DNS server policies on Active Directory Domain Services (AD DS) integrated zones  
  
-   Configure Response Rate Limiting  
  
-   Specify DNS-based Authentication of Named Entities (DANE)  
  
-   Configure support for Unknown Records in DNS  
  
For more information, see the topics [What's New in DNS Client in Windows Server 2016](dns/What-s-New-in-DNS-Client.md) and [What's New in DNS Server in Windows Server 2016](dns/What-s-New-in-DNS-Server.md).  
  
### <a name="bkmk_ipam"></a>IPAM scenarios with DHCP and DNS

The IPAM scenarios allow you to:  
  
-   Discover and administer DNS and DHCP servers and IP addressing across multiple federated Active Directory forests  
  
-   Use IPAM for centralized management of DNS properties, including zones and resource records.  
  
-   Define granular role-based access control policies and delegate IPAM users or user groups to manage the set of DNS properties that you specify.  
  
-   Use the Windows PowerShell commands for IPAM to automate access control configuration for DHCP and DNS.  
  
    For more information, see [Manage IPAM](technologies/ipam/Manage-IPAM.md).  
  
### <a name="bkmk_nicteam"></a>NIC Teaming scenarios

The NIC Teaming scenarios allow you to:  
  
-   Create a NIC team in a supported configuration  
  
-   Delete a NIC team  
  
-   Add network adapters to the NIC team in a supported configuration  
  
-   Remove network adapters from the NIC team  
  
> [!NOTE]  
> In Windows Server 2016, you can use NIC Teaming in Hyper-V, however in some cases Virtual Machine Queues (VMQ) might not automatically enable on the underlying network adapters when you create a NIC Team. If this occurs, you can use the following Windows PowerShell command to ensure that VMQ is enabled on the NIC team member adapters: `Set-NetAdapterVmq -Name <NetworkAdapterName> -Enable`  

For more information, see [NIC Teaming](technologies/nic-teaming/NIC-Teaming.md). 

### <a name="bkmk_set"></a>Switch Embedded Teaming \(SET\) scenarios

SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch. 

For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://technet.microsoft.com/windows-server-docs/networking/technologies/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming)
  
 
  
## <a name="bkmk_unsupp"></a>Unsupported Networking Scenarios  
The following networking scenarios are not supported in Windows Server 2016.  
  
-   VLAN-based tenant virtual networks.  
  
-   IPv6 is not supported in either the underlay or overlay.  
  


