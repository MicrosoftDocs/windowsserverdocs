---
title: What's new in networking
description: This topic provides overview information about new features and technologies for Networking in Windows Server 2016
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: get-started-article
ms.assetid: 08fb7563-d319-48a9-b181-ca0ca3032c18
ms.author: pashort
author: shortpatti
---
# What's new in networking

>Applies to: Windows Server 2016

Following are the new or enhanced networking technologies in Windows Server 2016.  
  Upd
This topic contains the following sections.  
  
-   [New Networking Features and Technologies](#bkmk_features)  
  
-   [New Features for Additional Networking Technologies](#bkmk_existing)  
  
## <a name="bkmk_features"></a>New Networking Features and Technologies

Networking is a foundational part of the Software Defined Datacenter (SDDC) platform, and Windows Server 2016 provides new and improved Software Defined Networking (SDN) technologies   to help you move to a fully realized SDDC solution for your organization.  
  
When you manage networks as a software defined resource, you can describe an application's infrastructure requirements one time, and then choose where the application  runs - on premises or in the cloud.  This consistency means that your applications are now easier to scale and you can seamlessly run  applications , anywhere, with equal confidence around security, performance, quality of service, and availability.  
  
The following sections contain information about these new networking features and technologies.  
  
### Software Defined Networking Infrastructure

Following are the new or improved SDN infrastructure technologies.  
  
-   **Network Controller**. New in Windows Server 2016, Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter. Using Network Controller, you can automate the configuration of network infrastructure instead of performing manual configuration of network devices and services. For more information, see [Network Controller](sdn/technologies/network-controller/Network-Controller.md) and [Deploy Software Defined Networks using scripts](https://technet.microsoft.com/library/mt427380.aspx).  
  
-   **Hyper-V Virtual Switch**. The Hyper-V Virtual Switch runs on Hyper-V hosts, and allows you to create distributed switching and routing, and a policy enforcement layer that is aligned and compatible with Microsoft Azure. For more information, see [Hyper-V Virtual Switch](../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md).  
  
-   **Network Function Virtualization (NFV)**. In today's software defined datacenters, network functions that are being performed by hardware appliances (such as load balancers, firewalls, routers, switches, and so on) are increasingly being deployed as virtual appliances. This "network function virtualization" is a natural progression of server virtualization and network virtualization. Virtual appliances are quickly emerging and creating a brand new market. They continue to generate interest and gain momentum in both virtualization platforms and cloud services. The following NFV technologies are available in Windows Server 2016.  
  
    -   **Datacenter Firewall**. This distributed firewall provides granular access control lists (ACLs),  enabling you to apply firewall policies at the VM interface level or at the subnet level.  
  
        For more information, see [Datacenter Firewall Overview](sdn/technologies/network-function-virtualization/Datacenter-Firewall-Overview.md).  
  
    -   **RAS Gateway**. You can use RAS Gateway for routing traffic between virtual networks and physical networks, including site-to-site VPN connections from your cloud datacenter to your tenants' remote sites. Specifically, you can deploy  Internet Key Exchange version 2 (IKEv2) site-to-site virtual private networks (VPNs), Layer 3 (L3) VPN, and Generic Routing Encapsulation (GRE) gateways. In addition, gateway pools and M+N redundancy of gateways are now supported; and Border Gateway Protocol (BGP) with Route Reflector capabilities provides dynamic routing between networks for all gateway scenarios (IKEv2 VPN, GRE VPN, and L3 VPN).  
  
        For more information, see  [What's New in RAS Gateway](sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md) and [RAS Gateway for SDN](sdn/technologies/network-function-virtualization/RAS-Gateway-for-SDN.md).  
          
    - **Software Load Balancer (SLB) and Network Address Translation (NAT)**. The north-south and east-west layer 4 load balancer and NAT enhances throughput by supporting Direct Server Return, with which the return network traffic can bypass the Load Balancing multiplexer.  
       For more information, see [Software Load Balancing &#40;SLB&#41; for SDN](sdn/technologies/network-function-virtualization/Software-Load-Balancing--SLB--for-SDN.md).  
  
    For more information, see [Network Function Virtualization](sdn/technologies/network-function-virtualization/Network-Function-Virtualization.md).  
  
-   **Standardized Protocols**. Network Controller uses Representational State Transfer (REST) on its northbound interface with JavaScript Object Notation (JSON) payloads. The Network Controller southbound interface uses Open vSwitch Database Management Protocol (OVSDB).  
  
-   **Flexible encapsulation technologies**. These technologies operate at the data plane, and support both Virtual Extensible LAN (VxLAN) and Network Virtualization Generic Routing Encapsulation (NVGRE). For more information, see [GRE Tunneling in  Windows Server 2016](../remote/remote-access/ras-gateway/gre-tunneling-windows-server.md).  
  
For more information about SDN, see [Software Defined Networking &#40;SDN&#41;](sdn/software-defined-networking.md).  
  
### Cloud Scale Fundamentals
 
The following cloud scale fundamentals are now available.  
  
-   **Converged Network Interface Card (NIC)**. The converged NIC allows you to use a single network adapter for management, Remote Direct Memory Access (RDMA)-enabled storage, and tenant traffic. This reduces the capital expenditures that are associated with each server in your datacenter, because you need fewer network adapters to manage different types of traffic per server.  
  
-   **Packet Direct**.  Packet Direct provides a high network traffic throughput and low-latency packet processing infrastructure.  
  
-   **Switch Embedded Teaming (SET)**.        SET is a NIC Teaming solution that is integrated in the Hyper-V Virtual Switch. SET allows the teaming of up to eight physical NICS into a single SET team, which improves availability and provides failover. In Windows Server 2016, you can create SET teams that are restricted to the use of Server Message Block (SMB) and RDMA. In addition, you can use SET teams to distribute network traffic for Hyper-V Network Virtualization. For more information, see [Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).  
  
## <a name="bkmk_existing"></a>New Features for Additional Networking Technologies

This section contains information about new features for familiar networking technologies.
  
## <a name="bkmk_dhcp"></a>DHCP  
DHCP is an Internet Engineering Task Force (IETF) standard that is designed to reduce the administrative burden and complexity of configuring hosts on a TCP/IP-based network, such as a private intranet. By using the DHCP Server service, the process of configuring TCP/IP on DHCP clients is automatic.  
  
For more information, see [What's New in DHCP](technologies/dhcp/What-s-New-in-DHCP.md).  
  
## <a name="bkmk_dns"></a>DNS  
DNS is a system that is used in TCP/IP networks for naming computers and network services. DNS naming locates computers and services through user-friendly names. When a user enters a DNS name in an application, DNS services can resolve the name to other information that is associated with the name, such as an IP address.  
  
Following is information about DNS Client and DNS Server.  
  
### <a name="bkmk_dnsc"></a>DNS Client  
Following are the new or improved DNS client technologies.  
  
-   **DNS Client service binding**. In Windows 10, the DNS Client service offers enhanced support for computers with more than one network interface.  
  
For more information, see [What's New in DNS Client in Windows Server 2016](dns/What-s-New-in-DNS-Client.md)  
  
### <a name="bkmk_dnss"></a>DNS Server  
Following are the new or improved DNS server technologies.  
  
-   **DNS Policies**.  You can configure DNS policies to specify how a DNS server responds to DNS queries. DNS responses can be based on client IP address (location), time of the day, and several other parameters. DNS policies enable location-aware DNS, traffic management, load balancing, split-brain DNS, and other scenarios.  
  
-   **Nano Server support for file based DNS**,   You can deploy DNS server in Windows Server 2016 on a Nano Server image. This deployment option is available to you if you are using file based DNS. By running DNS server on a Nano Server image, you can run your DNS servers with reduced footprint, quick boot up, and minimized patching.  
  
    > [!NOTE]   
    > Active Directory integrated DNS is not supported on Nano Server.  
  
-   **Response Rate Limiting (RRL)**.  You can enable response rate limiting on your DNS servers. By doing this, you avoid the possibility of malicious systems using your DNS servers to initiate a denial of service attack on a DNS client.  
  
-   **DNS-based Authentication of Named Entities (DANE)**.   You can use TLSA (Transport Layer Security Authentication) records to provide information to DNS clients that state what certification authority (CA) they should expect a certificate from for your domain name. This prevents man-in-the-middle attacks where someone might corrupt the DNS cache to point to their own website, and provide a certificate they issued from a different CA.  
  
-   **Unknown record support**.   
     You can add records which are not explicitly supported by the Windows DNS server using the unknown record functionality.  
  
-   **IPv6 root hints**.   
     You can use the native IPV6 root hints support to perform internet name resolution using the IPV6 root servers.  
  
-   **Improved Windows PowerShell Support**.   
      New Windows PowerShell cmdlets are available for DNS Server.  
  
For more information, see [What's New in DNS Server in Windows Server 2016](dns/What-s-New-in-DNS-Server.md)  
  
## <a name="bkmk_GRE"></a>GRE Tunneling  
RAS Gateway now supports high availability Generic Routing Encapsulation (GRE) tunnels for site to site connections and M+N redundancy of gateways. GRE is a lightweight tunneling protocol that can encapsulate a wide variety of network layer protocols inside virtual point-to-point links over an Internet Protocol internetwork.  
  
For more information, see [GRE Tunneling in Windows Server 2016](../remote/remote-access/ras-gateway/gre-tunneling-windows-server.md).  
  
## <a name="HNV"></a>Hyper-V Network Virtualization  
Introduced in Windows Server 2012, Hyper-V Network Virtualization (HNV) enables virtualization of customer networks on top of a shared physical network infrastructure. With minimal changes necessary on the physical network fabric, HNV gives service providers the agility to deploy and migrate tenant workloads anywhere across the three clouds: the service provider cloud, the private cloud, or the Microsoft Azure public cloud.  
  
For more information, see [What's New in Hyper-V Network Virtualization in Windows Server 2016](sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md)  
  
## <a name="bkmk_ipam"></a>IPAM  
IPAM provides highly customizable administrative and monitoring capabilities for the IP address and DNS infrastructure on an organization network. Using IPAM, you can monitor, audit, and manage servers that are running Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS).  
  
-   **Enhanced IP address management**.  
     IPAM capabilities are improved for scenarios such as handling IPv4 /32 and IPv6 /128 subnets and finding free IP address subnets and ranges in an IP address block.  
  
-   **Enhanced DNS service management**.  
     IPAM supports DNS resource record, conditional forwarder, and DNS zone management for both domain-joined Active Directory-integrated and file-backed DNS servers.  
  
-   **Integrated DNS, DHCP, and IP address (DDI) management**.  
     Several new experiences and integrated lifecycle management operations are enabled, such as visualizing all DNS resource records that pertain to an IP address, automated inventory of IP addresses based on DNS resource records, and IP address lifecycle management for both DNS and DHCP operations.  
  
-   **Multiple Active Directory Forest support**.  
     You can use IPAM to manage the DNS and DHCP servers of multiple Active Directory forests when there is a two-way trust relationship between the forest where IPAM is installed and each of the remote forests.  
  
-   **Windows PowerShell support for Role Based Access Control**.  
     You can use Windows PowerShell to set access scopes on IPAM objects.  
  
For more information, see [What's New in IPAM](technologies/ipam/What-s-New-in-IPAM.md) and [Manage IPAM](technologies/ipam/Manage-IPAM.md).  
  

