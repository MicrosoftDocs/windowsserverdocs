---
title: Networking
description: This topic provides an overview of the Software Defined Networking and Network Platform technologies that are available in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 05/08/2018
ms.assetid: daaf6b61-5953-4c2d-b6b8-7c885b552646
manager: dougkim
ms.author: pashort
author: shortpatti
ms.localizationpriority: medium
---
# Networking

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<img src="../media/landing-icons/network.png" style='float:left; padding:.5em;' alt="Icon depicting two networked computers"> Networking is a foundational part of the Software Defined Datacenter \(SDDC\) platform, and Windows Server 2016 provides new and improved Software Defined Networking \(SDN\) technologies to help you move to a fully realized SDDC solution for your organization.

When you manage networks as a software defined resource, you can describe an application’s infrastructure requirements one time, and then choose where the application runs - on premises or in the cloud. 

This consistency means that your applications are now easier to scale, and you can seamlessly run applications - anywhere - with equal confidence about security, performance, quality of service, and availability.

>[!Note]
> To download Windows Server, see [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-technical-preview).

Windows Server 2016 adds the following new networking technologies:

- Software Defined Networking: Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter. Network Controller allows you to use Network Function Virtualization to easily deploy virtual machines \(VMs\) for Software Load Balancing \(SLB\) to optimize network traffic loads for your tenants, and RAS Gateways to provide tenants with the connectivity options they need between Internet, on-prem, and cloud resources. You can also use Network Controller to manage Datacenter Firewall on VMs and Hyper-V hosts.

- Network Platform: Using new features for existing Network Platform technologies, you can use DNS Policy to customize your DNS server responses to queries, use a converged NIC that handles combined Remote Direct Memory Access \(RDMA\) and Ethernet traffic, use Switch Embedded Teaming \(SET\) to create Hyper-V Virtual Switches connected to RDMA NICs, and use IP Address Management \(IPAM\) to manage DNS zones and servers as well as DHCP and IP addresses.

For more information, see [Windows Server Supported Networking Scenarios](windows-server-supported-networking-scenarios.md).

The following sections provide information about SDN technologies and Network Platform technologies.

## Software Defined Networking technologies

### [Software Defined Networking &#40;SDN&#41;](sdn/software-defined-networking.md)

You can use this topic to learn about the SDN technologies that are provided in Windows Server, System Center, and Microsoft Azure.

>[!NOTE]
>For Hyper-V hosts and virtual machines \(VMs\) that run SDN infrastructure servers, such as Network Controller and Software Load Balancing nodes, you must install Windows Server 2016 Datacenter edition. For Hyper-V hosts that contain only tenant workload VMs that are connected to SDN\-controlled networks, you can run Windows Server 2016 Standard edition.

### [Deploy a Software Defined Network infrastructure using scripts](sdn/deploy/Deploy-a-Software-Defined-Network-infrastructure-using-scripts.md)
This guide provides instructions on how to deploy Network Controller with virtual networks and gateways in a test lab environment.

### [Network Controller](sdn/technologies/network-controller/Network-Controller.md)

Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter.

### [Software Load Balancing &#40;SLB&#41; for SDN](sdn/technologies/network-function-virtualization/software-load-balancing-for-sdn.md)

Cloud Service Providers \(CSPs\) and Enterprises that are deploying Software Defined Networking (SDN) in Windows Server 2016 can use Software Load Balancing \(SLB\) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.

### [RAS Gateway for SDN](sdn/technologies/network-function-virtualization/RAS-Gateway-for-SDN.md)

RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol \(BGP\) capable router in Windows Server 2016, is designed for Cloud Service Providers \(CSPs\) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization. 

### [Network Function Virtualization](sdn/technologies/network-function-virtualization/Network-Function-Virtualization.md)

In software defined datacenters, network functions that are being performed by hardware appliances \(such as load balancers, firewalls, routers, switches, and so on\) are increasingly being virtualized as virtual appliances. This "network function virtualization" is a natural progression of server virtualization and network virtualization.

### [Datacenter Firewall Overview](sdn/technologies/network-function-virtualization/Datacenter-Firewall-Overview.md)

Datacenter Firewall is a network layer, 5-tuple (protocol, source and destination port numbers, source and destination IP addresses), stateful, multitenant firewall.

## <a name="bkmk_networking"></a>Networking Technologies

The following table provides links to some of the networking technologies in Windows Server 2016.

### [What's New in Networking](../networking/What-s-New-in-Networking.md)

You can use the following sections to discover new networking technologies and new features for existing technologies in Windows Server 2016.

### [BranchCache](branchcache/BranchCache.md)

BranchCache is a wide area network \(WAN\) bandwidth optimization technology. To optimize WAN bandwidth when users access content on remote servers, BranchCache fetches content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.

### [Core Network Guide for Windows Server 2016](core-network-guide/core-network-guide-windows-server.md)

Learn how to deploy a Windows Server network with the Core Network Guide, as well as add features to your network deployment with Core Network Companion Guides.

### [DirectAccess](../remote/remote-access/directaccess/DirectAccess.md)

DirectAccess allows connectivity for remote users to organization network resources. 

DirectAccess documentation is now located in the [Remote access and server management](https://docs.microsoft.com/windows-server/remote/) section of the Windows Server 2016 table of contents, under [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access). For more information, see [DirectAccess](../remote/remote-access/directaccess/DirectAccess.md).

### [Domain Name System &#40;DNS&#41;](dns/dns-top.md)

Domain Name System \(DNS\) is one of the industry-standard suite of protocols that comprise TCP/IP, and together the DNS Client and DNS Server provide computer name-to-IP address mapping name resolution services to computers and users.

### [Dynamic Host Configuration Protocol &#40;DHCP&#41;](technologies/dhcp/dhcp-top.md)

Dynamic Host Configuration Protocol \(DHCP\) is a client/server protocol that automatically provides an Internet Protocol \(IP\) host with its IP address and other related configuration information, such as the subnet mask and default gateway.

### [Hyper-V Network Virtualization](sdn/technologies/hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md)

Hyper-V Network Virtualization \(HNV\) enables virtualization of customer networks on top of a shared physical network infrastructure.

### [Hyper-V Virtual Switch](../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md)

The Hyper-V Virtual Switch is a software-based layer-2 Ethernet network switch that is available in Hyper-V Manager when you install the Hyper-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. In addition, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels. 

Hyper-V Virtual Switch documentation is now located in the **Virtualization** section of the Windows Server 2016 table of contents. For more information, see [Hyper-V Virtual Switch](../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md).

### [IP Address Management &#40;IPAM&#41;](technologies/ipam/ipam-top.md)

IP Address Management \(IPAM\) is an integrated suite of tools to enable end-to-end planning, deploying, managing and monitoring of your IP address infrastructure, with a rich user experience. IPAM automatically discovers IP address infrastructure servers and Domain Name System \(DNS\) servers on your network and enables you to manage them from a central interface.

### [Network Load Balancing](technologies/Network-Load-Balancing.md)

Network Load Balancing \(NLB\) distributes traffic across several servers using the TCP/IP networking protocol. For non-SDN deployments, NLB ensures that stateless applications, such as Web servers running Internet Information Services \(IIS\), are scalable by adding more servers as the load increases.

### [High-Performance Networking](technologies/hpn/hpn-top.md)

Network offload and optimization technologies in Windows Server 2016 include Software Only (SO) features and technologies, Software and Hardware (SH) integrated features and technologies, and Hardware Only (HO) features and technologies.

The following offload and optimization technology documentation is also available.

- [Converged Network Interface Card (NIC) Configuration Guide](technologies/conv-nic/cnic-top.md)
- [Data Center Bridging (DCB)](technologies/dcb/dcb-top.md)
- [Virtual Receive Side Scaling (vRSS)](technologies/vrss/vrss-top.md)


### [Network Policy Server](technologies/nps/nps-top.md)

Network Policy Server (NPS) allows you to create and enforce organization-wide network access policies for connection request authentication and authorization.

### [Network Shell (Netsh)](technologies/netsh/netsh.md)

You can use the Network Shell \(netsh\) networking utility to manage networking technologies in Windows Server 2016 and Windows 10.

### [Network Subsystem Performance Tuning](technologies/network-subsystem/net-sub-performance-top.md)

This topic provides information about choosing the right network adapter for your server workload, ordering network interfaces, network related performance counters, and performance tuning network adapters and related networking technologies, such as Receive Side Scaling \(RSS\), Receive Side Coalescing \(RSC\), and others.

### [NIC Teaming](technologies/nic-teaming/NIC-Teaming.md)

NIC Teaming allows you to group physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.

### [Quality of Service (QoS) Policy](technologies/qos/qos-policy-top.md)

You can use QoS Policy as a central point of network bandwidth management across your entire Active Directory infrastructure by creating QoS profiles, whose settings are distributed with Group Policy.

### [Remote Access](../remote/remote-access/remote-access.md)

You can use Remote Access technologies, such as DirectAccess and Virtual Private Networking \(VPN\) to provide remote workers with connectivity to internal network resources. In addition, you can use Remote Access for local area network \(LAN\) routing, and for Web Application Proxy. which provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network.

Remote Access documentation is now located in the [Remote access and server management](https://docs.microsoft.com/windows-server/remote/) section of the Windows Server 2016 table of contents. For more information, see [Remote Access](../remote/remote-access/remote-access.md).

For more information about Web Application Proxy, which is a role service of the Remote Access server role, see [Web Application Proxy in Windows Server 2016](https://docs.microsoft.com/windows-server/remote/remote-access/web-application-proxy/web-application-proxy-windows-server).

### [Virtual Private Networking (VPN)](../remote/remote-access/vpn/vpn-top.md)

In Windows Server 2016, **DirectAccess and VPN** is a role service of the **Remote Access** server role.

When you install Remote Access as a VPN server, you can use Virtual Private Networking \(VPN\) to provide your remote employees with connections to your organization network across the Internet - while also maintaining information privacy with encrypted connections.

With Windows Server 2016 Remote Access VPN - and Windows 10 client computers - you can now deploy Always On VPN. Always On VPN gives you the ability to manage remote VPN clients that are always connected, while also providing convenience for remote workers, who no longer need to manually connect to and disconnect from VPN to your organization network.

For more information, see [Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy).

>[!NOTE]
>VPN documentation is now located in the [Remote access and server management](https://docs.microsoft.com/windows-server/remote/) section of the Windows Server 2016 table of contents, under [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

For more information about VPN, see [Virtual Private Networking (VPN)](https://docs.microsoft.com/windows-server/remote/remote-access/vpn/vpn-top).

### [Windows Container Networking](https://docs.microsoft.com/virtualization/windowscontainers/manage-containers/container-networking)

Windows Container Networking allows you to create and manage networks for connecting container endpoints on both Windows 10 and Windows Server hosts by using standard industry tools and workflows. Windows container networks support multiple topologies, including private, flat-L2, and routed-L3.

Also supported are overlays that you can create locally on the host by using Docker, Kubernetes, or Windows PowerShell through plugins that communicate with the Windows Host Networking Service \(HNS\). You can create and manage multi\-node cluster networks through higher level orchestration systems by communicating through a local agent to each node’s HNS.

### [Windows Internet Name Service (WINS)](technologies/wins/wins-top.md)

Windows Internet Name Service (WINS) is a legacy computer name registration and resolution service that maps computer NetBIOS names to IP addresses. Using DNS is recommended over using WINS.

## Additional Resources

Networking resources for operating systems earlier than Windows Server 2016 are available at the following locations.

- Windows Server 2012 and Windows Server 2012 R2 [Networking Overview](https://technet.microsoft.com/library/hh831357.aspx)
- Windows Server 2008 and Windows Server 2008 R2 [Networking](https://technet.microsoft.com/library/cc753940)
- Windows Server 2003 [Windows Server 2003/2003 R2 Retired Content](https://www.microsoft.com/download/details.aspx?id=53314)
