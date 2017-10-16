---
title: Plan a Software Defined Network Infrastructure
description: This topic provides information on how to plan your Software Defined Network (SDN) infrastructure deployment.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: virtual-network
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: ea7e53c8-11ec-410b-b287-897c7aaafb13
ms.author: jamesmci
author: jamesmci
---
# Plan a Software Defined Network Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Review the following information to help plan your Software Defined Network (SDN) infrastructure deployment. After you review this information, see [Deploy a Software Defined Network infrastructure](../deploy/Deploy-a-Software-Defined-Network-Infrastructure.md) for deployment information.

>[!NOTE]
>In addition to this topic, the following SDN planning content is available.  
>
> - [Installation and Preparation Requirements for Deploying Network Controller](Installation-and-Preparation-Requirements-for-Deploying-Network-Controller.md)  

For information about Hyper-V Network Virtualization (HNV), which you can use to virtualize networks in a Microsoft SDN deployment, see [Hyper-V Network Virtualization](../technologies/hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md).  

## Prerequisites
This topic describes a number of hardware and software prerequisites, including:

-   **Physical network**  
    You need access to your physical network devices to configure VLANs, Routing, BGP, Data Center Bridging (ETS) if using an RDMA technology, and Data Center Bridging (PFC) if using a RoCE based RDMA technology. This topic shows manual switch configuration as well as BGP Peering on Layer-3 switches / routers or a Routing and Remote Access Server (RRAS) virtual machine.   

-   **Physical compute hosts**  
These hosts run Hyper-V and are required to host SDN infrastructure and tenant virtual machines.  Specific network hardware is required in these hosts for best performance, which is described later in the **Network hardware** section.  
      
  
## Physical Network Configuration

Each physical compute host requires network connectivity through one or more network adapters attached to a physical switch port(s). The network is segregated into multiple logical network segments optionally backed by a Layer-2 [VLAN](https://en.wikipedia.org/wiki/Virtual_LAN). The IP subnet prefixes and VLAN IDs shown below are examples and must be customized for your environment based on guidance from your network administrator. If any of your logical networks are untagged or in access mode, use VLAN ID 0 for these networks when configuring the logical subnets in either System Center Virtual Machine Manager or PowerShell script configuration files.

>[!IMPORTANT]
>Windows Server 2016 Software Defined Networking supports IPv4 addressing for the underlay and the overlay. IPv6 is not supported.
  
### Management and HNV Provider logical networks

All physical compute hosts need to have access to the Management logical network and the HNV Provider logical network. If the logical networks use VLANs, the physical compute hosts must to be connected to a trunked switch port which has access to these VLANs. Similarly, the physical network adapters on the compute host must not have any VLAN filtering activated. If you are using Switch-Embedded Teaming (SET) and have multiple NIC team members (i.e. network adapters) in your compute hosts, you must connect all of the NIC team members for that particular host to the same Layer-2 broadcast domain.  
  
For IP Address planning purposes, each physical compute host must have at least one IP address assigned from the Management logical network. The network controller automatically assigns exactly two IP addresses from the HNV Provider logical network. If the physical compute host is running additional infrastructure virtual machines (for example, Network Controller, SLB/MUX, or Gateway) that host must have an additional IP address assigned from the Management logical network for each of the infrastructure virtual machines hosted.   
  
Additionally, each SLB/MUX infrastructure virtual machine must have an IP address reserved from the HNV Provider logical network. 

>[!IMPORTANT]
>These SLB/MUX IP addresses must be assigned from outside the IP address pool that is configured for the HNV Provider logical network. Failure to do this may result in duplicate IP addresses on your network. 

The Network Controller requires a reserved address from the Management network to serve as the REST IP address. You must manually create the HOST A record in DNS for the REST IP address.  
  
A DHCP server can automatically assign IP addresses for the Management network or you can manually assign static IP address. The SDN stack automatically assigns IP addresses for the HNV provider network for the individual Hyper-V hosts from an IP Pool specified through and managed by the Network Controller.   
  
The fabric administrator statically assigns the HNV Provider IP addresses used by the SLB/MUX via PowerShell scripts or VMM. The Network Controller assigns an HNV Provider IP address to a physical compute host only after the Network Controller Host Agent receives network policy for a specific tenant virtual machine.  
  
#### Sample network topology

Customize the subnet prefixes, VLAN IDs, and gateway IP addresses based on your network administrator's guidance.  
  
Network Name|Subnet|Mask|VLAN ID on trunk|Gateway|Reservations<br />(examples)  
----------------|----------|--------|--------------------|-----------|-----------------------------  
|**Management**|10.184.108.0|24|7|10.184.108.1|10.184.108.1 - Router<br /><br />10.184.108.4 - Network Controller<br /><br />10.184.108.10 - Compute host 1<br /><br />10.184.108.11 - Compute host 2<br /><br />10.184.108.X - Compute host X  
|**HNV Provider**|10.10.56.0|23|11|10.10.56.1|10.10.56.1 - Router<br /><br />10.10.56.2 - SLB/MUX1  
  
### Logical Networks for Gateways and the Software Load Balancer
  
Additional logical networks need to be created and provisioned for gateway and SLB usage. Once again, you need to work with your network administrator to obtain the correct IP prefixes, VLAN IDs, and gateway IP addresses for these networks.

#### Transit logical network
  
The RAS Gateway and SLB/MUX use the Transit logical network to exchange BGP peering information and North/South (external-internal) tenant traffic. The size of this subnet will typically be smaller than the others. Only physical compute hosts that run RAS Gateway or SLB/MUX virtual machines need to have connectivity to this subnet with these VLANs trunked and accessible on the switch ports to which the compute hosts' network adapters are connected. Each SLB/MUX or RAS Gateway virtual machine is statically assigned one IP address from the Transit logical network.

#### Public VIP logical network  
  
The Public VIP logical network is required to have IP subnet prefixes that are routable outside of the cloud environment (typically Internet routable).  These will be the front-end IP addresses used by external clients to access resources in the virtual networks including the front end VIP for the Site-to-site gateway.

#### Private VIP logical network
  
The Private VIP logical network is not required to be routable outside of the cloud as it is used for VIPs that are only accessed from internal cloud clients, such as the SLB Mananger or private services.
  
#### GRE VIP logical network

The GRE VIP network is a subnet that exists solely for defining VIPs that are assigned to gateway virtual machines running on your SDN fabric for a S2S GRE connection type. This network does not need to be pre-configured in your physical switches or router and need not have a VLAN assigned.   

### Sample network topology

Customize the subnet prefixes, VLAN IDs, and gateway IP addresses based on your network administrator's guidance.  
  
Network Name|Subnet|Mask|VLAN ID on trunk|Gateway|Reservations<br />(examples)  
----------------|----------|--------|--------------------|-----------|-----------------------------  
|**Transit**|10.10.10.0|24|10|10.10.10.1|10.10.10.1 - router  
|**Public VIP**|41.40.40.0|27|NA|41.40.40.1|41.40.40.1 - router<br /> 41.40.40.2 - SLB/MUX VIP<br />41.40.40.3 - IPSec S2S VPN VIP  
|**Private VIP**|20.20.20.0|27|NA|20.20.20.1|20.20.20.1 - default GW (router)  
|**GRE VIP**|31.30.30.0|24|NA|31.30.30.1|31.30.30.1 - default GW|  
  
### Logical networks required for RDMA-based storage  
  
If you are using RDMA based storage, then you will need to define a VLAN and subnet for each physical adapter in your compute and storage hosts. Typically you will have two physical adapters per node for this configuration.  
  
> [!IMPORTANT]  
> Most physical switches require RDMA traffic to be sent on a tagged VLAN in order for quality of service settings to be applied correctly.  Do not place RDMA traffic onto an untagged VLAN or on a physical access-mode port.  
  
Network Name  |Subnet  |Mask  |VLAN ID on trunk  |Gateway  |Reservations<br />(examples)    
---------|---------|---------|---------|---------|---------  
**Storage1**     |    10.60.36.0     | 25        |   8      |  10.60.36.1       |  10.60.36.1 - router<br />10.60.36.x - Compute  host x<br />10.60.36.y - compute host y<br />10.60.36.v - compute cluster<br />10.60.36.w - storage cluster  
|**Storage2**|10.60.36.128|25|9|10.60.36.129|10.60.36.129 - router<br />10.60.36.x - compute  host x<br />10.60.36.y - compute host y<br />10.60.36.v - compute cluster<br />10.60.36.w - storage cluster  
  
For more information about configuring switches, see the **Configuration Examples** section.  
  
## Routing infrastructure  
  
If you are deploying your SDN infrastructure using scripts, the Management, HNV Provider, Transit, and VIP subnets must be routable to each other on the physical network.     
  
Routing information \(e.g. next-hop\) for the VIP subnets is advertised by the SLB/MUX and RAS Gateways into the physical network using internal BGP peering. The VIP logical networks do not have a VLAN assigned and is not pre-configured in the Layer-2 switch (e.g. Top-of-Rack switch).  
  
You need to create a BGP peer on the router that is used by your SDN infrastructure to receive routes for the VIP logical networks advertised by the SLB/MUXes and RAS Gateways. BGP peering only needs to occur one way (from SLB/MUX or RAS Gateway to external BGP peer).  Above the first layer of routing you can use static routes or another dynamic routing protocol such as OSPF, however, as previously stated, the IP subnet prefix for the VIP logical networks do need to be routable from the physical network to the external BGP peer.   
  
BGP peering is typically configured in a managed switch or router as part of the network infrastructure. The BGP peer could also be configured on a Windows Server with the Remote Access Server (RAS) role installed in a Routing Only mode. This BGP router peer in the network infrastructure must be configured to have its own ASN and allow peering from an ASN that is assigned to the SDN components \(SLB/MUX and RAS Gateways\). You must obtain the following information from your physical router, or from the network administrator in control of that router:

- Router ASN  
- Router IP address  
- ASN for use by SDN components (can be any AS number from the private ASN range)

>[!NOTE]
>Four byte ASNs are not supported by the SLB/MUX. You must allocate two byte ASNs to the SLB/MUX and the router wo which it connects. You can use 4 byte ASNs elsewhere in your environment.  
  
You or your network administrator must configure the BGP router peer to accept connections from the ASN and IP address or subnet address of the Transit logical network that your RAS gateway and SLB/MUXes are using.
  
For more information, see [Border Gateway Protocol &#40;BGP&#41;](../../../remote/remote-access/bgp/Border-Gateway-Protocol-BGP.md).
  
## Default gateways

Machines that are configured to connect to multiple networks, such as the physical hosts and gateway virtual machines must only have one default gateway configured. The default gateway will typically be configured on the adapter used to reach all the way to the Internet.

For virtual machines, use the following rules to decide which network to use as the default gateway:

1. Use the Transit network as the default gateway if a virtual machine is connected to the Transit network, or if it is multi-homed to the Transit and any other network.  
2. Use the Management network as the default gateway if a virtual machine is only connected to the Management network.  
3.  The HNV Provider network must never be used as a default gateway. The only virtual machines connected to this network will be the SLB/MUXes and RAS Gateways.  
4.  Virtual Machines will never be connected directly to the Storage1, Storage2, Public VIP or Private VIP networks.  
  
For Hyper-V hosts and storage nodes, use the Management network as the default gateway.  The storage networks must never have a default gateway assigned.
  
## Network hardware

You can use the following sections to plan network hardware deployment.

### Network Interface Cards (NICs)

To achieve best performance, specific capabilities are required in the network interface cards you use in your Hyper-V hosts and storage hosts.  
 
Remote Direct Memory Access (RDMA) is a kernel bypass technique that makes it possible to transfer large amounts of data without involving the host CPU. Because the DMA engine on the network adapter performs the transfer, the CPU is not used for the memory movement.  This frees the CPU to perform other work.  

Switch Embedded Teaming (SET) is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch.

For more information, see [Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](../../../virtualization//hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).  

To account for the overhead in tenant virtual network traffic caused by VXLAN or NVGRE encapsulation headers, the MTU of the Layer-2 fabric network (switches and hosts) must be set to greater than or equal to 1674 Bytes \(including Layer-2 Ethernet headers\). NICs  that support the new *EncapOverhead* advanced adapter keyword will set the MTU  automatically through the network controller Host Agent. NICs  that do not support the new *EncapOverhead* keyword need to set the MTU size manually on each physical host using the *JumboPacket* \(or equivalent\) keyword.

### Switches
  
When selecting a physical switch and router for your environment make sure it supports the following set of capabilities.  

- Switchport MTU settings \(required\)  
- MTU set to >= 1674 Bytes \(including L2-Ethernet Header\)  
- L3 protocols \(required\)  
- ECMP  
- BGP \(IETF RFC 4271\)\-based ECMP

Implementations should support the MUST statements in the following IETF standards.

- RFC 2545: "BGP-4 Multiprotocol extensions for IPv6 Inter-Domain Routing"  
- RFC 4760: "Multiprotocol Extensions for BGP-4"  
- RFC 4893: "BGP Support for Four-octet AS Number Space"  
- RFC 4456: "BGP Route Reflection: An Alternative to Full Mesh Internal BGP (IBGP)"  
- RFC 4724: "Graceful Restart Mechanism for BGP"  

The following tagging protocols are required.

- VLAN - Isolation of various types of traffic
- 802.1q trunk

The following items provide Link control.

- Quality of service \(PFC only required if using RoCE\)
- Enhanced Traffic Selection \(802.1Qaz\)
- Priority Based Flow Control \(802.1p/Q and 802.1Qbb\)

The following items provide availability and redundancy.

- Switch availability (required)
- A highly available router is required to perform gateway functions. You can do this by using a multi-chassis switch\ router or technologies like VRRP.
        
The following items provide management capabilities.

**Monitoring**

- SNMP v1 or SNMP v2 (required if using Network Controller for physical switch monitoring)  
- SNMP MIBs \(required if you are using Network Controller for physical switch monitoring\)  
- MIB-II (RFC 1213), LLDP, Interface MIB \(RFC 2863\), IF-MIB, IP-MIB, IP-FORWARD-MIB, Q-BRIDGE-MIB, BRIDGE-MIB, LLDB-MIB, Entity-MIB, IEEE8023-LAG-MIB  
  
The following diagrams show a sample four node setup. For clarity purposes, the first diagram shows just the network controller, the second shows the network controller plus the software load balancer, and the third diagram shows the network controller, software load balancer, and the gateway.  
  
Storage networks and vNICs are not shonwn in these diagrams. If you plan to use SMB-based storage, these are required.    
  
Both the infrastructure and tenant virtual machines can be redistributed across any physical compute host (assuming the correct network connectivity exists for the correct logical networks).  
  
### Network Controller deployment

Before you deploy Network Controller, you must review installation and software requirements, as well as configuring security groups and dynamic DNS registration. For more information, see [Installation and Preparation Requirements for Deploying Network Controller](Installation-and-Preparation-Requirements-for-Deploying-Network-Controller.md).

The setup is highly available with three Network Controller nodes  configured on virtual machines. Also shown is two tenants with Tenant 2's virtual network broken into two virtual subnets to simulate a web tier and a database tier.  

![SDN NC Planning](../../media/Plan-a-Software-Defined-Network-Infrastructure/SDN-NC-Planning.png)

### Network controller and software load balancer deployment

For high availablity, there are two or more SLB/MUX nodes.
   
![SDN NC Planning](../../media/Plan-a-Software-Defined-Network-Infrastructure/SDN-SLB-Deployment.png)
  
### Network Controller, Software Load Balancer, and RAS Gateway deployment

There are three gateway virtual machines; two are active, and one is redundant.

![SDN NC Planning](../../media/Plan-a-Software-Defined-Network-Infrastructure/SDN-GW-Deployment.png)  
  
  
  
For TP5-based deployment automation, Active Directory must be available and reachable from these subnets. For more information about Active Directory, see [Active Directory Domain Services Overview](https://technet.microsoft.com/en-us/library/mt703721.aspx).  
  
>[!IMPORTANT] 
>If you deploy using VMM, ensure your infrastructure virtual machines (VMM Server, AD/DNS, SQL Server, etc.) are not hosted on any of the four hosts shown in the diagrams.  
  
## Switch configuration examples  
  
To help configure your physical switch or router, a set of sample configuration files for a variety of switch models and vendors are available at the [Microsoft SDN Github repository](https://github.com/microsoft/SDN/tree/master/SwitchConfigExamples). A detailed readme and tested command line interface (CLI) commands for specific switches are provided.         
  
  
## Compute  
All Hyper-V hosts must have Windows Server 2016 installed, Hyper-V enabled, and an external Hyper-V virtual switch created with at least one physical adapter connected to the Management logical network. The host must be reachable via a Management IP address assigned to the Management Host vNIC.  
  
Any storage type that is compatible with Hyper-V, shared or local may be used.   
  
> [!TIP]  
> It is convenient if you use the same name for all your virtual switches, but it is not mandatory. If you plan to deploy with scripts, see the comment associated with the `vSwitchName` variable in the config.psd1 file.  
  
**Host compute requirements**  
The following table shows the minimum hardware and software requirements for the four physical hosts used in the example deployment.  
  
Host|Hardware Requirements|Software Requirements|  
--------|-------------------------|-------------------------  
|Physical Hyper-v host|4-Core 2.66 GHz CPU<br /><br />32 GB of RAM<br /><br />300 GB Disk Space<br /><br />1 Gb/s (or faster) physical network adapter|OS: Windows Server 2016<br /><br />Hyper-V Role installed|  
  
  
**SDN infrastructure virtual machine role requirements**  
  
Role|vCPU requirements|Memory requirements|Disk requirements|  
--------|---------------------|-----------------------|---------------------  
|Network controller (three node)|4 vCPUs|4 GB min (8 GB recommended)|75 GB for the OS drive  
|SLB/MUX (three node)|8 vCPUs|8 GB recommended|75 GB for the OS drive  
|RAS Gateway<br /><br />(single pool of three node gateways, two active, one passive)|8 vCPUs|8 GB recommended|75 GB for the OS drive  
|RAS Gateway BGP router for SLB/MUX peering<br /><br />(alternatively use ToR switch as BGP Router)|2 vCPUs|2 GB|75 GB for the OS drive|  
  
  
If you use VMM for deployment, additional infrastructure virtual machine resources are required for VMM and other non-SDN infrastructure. For additional information, see [Minimum Hardware Recommendations for System Center Technical Preview.](https://technet.microsoft.com/library/dn997303.aspx)  
  
## Extending your infrastructure  
The sizing and resource requirements for your infrastructure are dependent on the tenant workload virtual machines that you plan to host. The CPU, memory, and disk requirements for the infrastructure virtual machines (for example: network controller, SLB, gateway, etc.) are listed in the previous table. You can add more of these infrastructure virtual machines to scale out as needed. However, any tenant virtual machines running on the Hyper-V hosts have their own CPU, memory, and disk requirements that you must consider.   
  
When the tenant workload virtual machines begin to consume too many resources on the physical Hyper-V hosts, you can extend your infrastructure by adding additional physical hosts. This can be done with Virtual Machine Manager or by using PowerShell scripts (depending on how you initially deployed the infrastructure) to create new server resources through the network controller. If you need to add additional IP addresses for the HNV Provider network, you can create new logical subnets (with corresponding IP Pools) that the hosts can use.  
  
  
## See Also  
[Installation and Preparation Requirements for Deploying Network Controller](Installation-and-Preparation-Requirements-for-Deploying-Network-Controller.md)  
[Software Defined Networking &#40;SDN&#41;](../Software-Defined-Networking--SDN-.md)  
  


