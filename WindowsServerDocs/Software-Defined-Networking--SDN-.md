---
title: Software Defined Networking (SDN)
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a1ea73c-20cd-42c5-95ad-b003b9cc6d64
author: vhorne
---
# Software Defined Networking (SDN)
You can use this topic to learn about the Software Defined Networking \(SDN\) technologies that are provided in Windows Server, System Center, and Microsoft Azure.  
  
> [!NOTE]  
> In addition to this topic, the following SDN content is available.  
>   
> -   [Software Defined Networking Technologies](Software-Defined-Networking-Technologies.md)  
> -   [Plan Software Defined Networking](Plan-Software-Defined-Networking.md)  
> -   [Deploy Software Defined Networking](Deploy-Software-Defined-Networking.md)  
> -   [Manage Tenant Workloads and Virtual Networks](Manage-Tenant-Workloads-and-Virtual-Networks.md)  
> -   [Troubleshoot Software Defined Networking](Troubleshoot-Software-Defined-Networking.md)  
  
This topic contains the following sections.  
  
-   [Software Defined Networking Overview](#bkmk_sdn)  
  
-   [Windows Server Technologies for Software Defined Networking](#bkmk_ws)  
  
-   [System Center Technologies for Software Defined Networking](#bkmk_sc)  
  
-   [Microsoft Azure](#bkmk_az)  
  
## <a name="bkmk_sdn"></a>Software Defined Networking Overview  
Software Defined Networking \(SDN\) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. Virtual network elements such as Hyper\-V Virtual Switch, Hyper\-V Network Virtualization, and Windows Server Gateway are designed to be integral elements of your software defined networking infrastructure. While you can still use your existing physical switches, routers, and other hardware devices, you can achieve deeper integration between the virtual network and the physical network if these devices are designed for compatibility with software defined networking.  
  
Software defined networking is possible because the network planes \- the management, control, and data planes \- are no longer bound to the network devices themselves, but are abstracted for use by other entities, such as datacenter management software like System Center.  
  
Software defined networking allows you to dynamically manage your datacenter network to provide an automated, centralized way to meet the requirements of your applications and workloads. Software defined networking provides the following capabilities.  
  
-   The ability to abstract your applications and workloads from the underlying physical network, which is accomplished by virtualizing the network. Just as with server virtualization using Hyper\-V, the abstractions are consistent and work with your applications and workloads in a non\-disruptive manner. For example, software defined networking provides virtual abstractions for your physical network elements, such as IP addresses, switches, and load balancers.  
  
-   The ability to centrally define and control policies that govern both physical and virtual networks, including traffic flow between these two network types.  
  
-   The ability to implement network policies in a consistent manner at scale, even as you deploy new workloads or move workloads across virtual or physical networks.  
  
## <a name="bkmk_ws"></a>Windows Server Technologies for Software Defined Networking  
Windows Server includes the following software defined networking technologies.  
  
-   [Network Controller](#bkmk_nc)  
  
-   [Hyper-V Network Virtualization](#bkmk_hv)  
  
-   [Hyper-V Virtual Switch](#bkmk_switch)  
  
-   [Network Function Virtualization](#bkmk_nfv)  
  
-   [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](#bkmk_rdma)  
  
-   [RAS Gateway for SDN](#bkmk_rras)  
  
-   [Software Load Balancing (SLB)](#bkmk_slb)  
  
-   [NIC Teaming](#bkmk_team)  
  
### <a name="bkmk_nc"></a>Network Controller  
New in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot both virtual and physical network infrastructure in your datacenter. Using Network Controller, you can automate the configuration of network infrastructure instead of performing manual configuration of network devices and services.  
  
Network Controller is a highly available and scalable server role, and provides one application programming interface \(API\) – the Southbound API \- that allows Network Controller to communicate with the network, and a second API – the Northbound API \- that allows you to communicate with Network Controller.  
  
Using Windows PowerShell, the Representational State Transfer \(REST\) API, or a management application, you can use Network Controller to manage the following physical and virtual network infrastructure.  
  
-   Hyper\-V VMs and virtual switches  
  
-   Physical network switches  
  
-   Physical network routers  
  
-   Firewall software  
  
-   VPN Gateways, including Remote Access Service \(RAS\) Multitenant Gateways  
  
-   Load Balancers  
  
For more information, see [Network Controller](Network-Controller.md).  
  
### <a name="bkmk_hv"></a>Hyper\-V Network Virtualization  
Hyper\-V Network Virtualization helps you abstract your applications and workloads from the physical network by using virtual networks. Virtual networks provide the necessary multitenant isolation while running on a shared physical network fabric, thereby driving up resource utilization. To ensure that you can carry forward your existing investments, you can set up virtual networks on existing networking gear. In addition, virtual networks are compatible with virtual Local Area Networks \(VLANs\).  
  
For more information, see [Hyper-V Network Virtualization](Hyper-V-Network-Virtualization.md).  
  
### <a name="bkmk_switch"></a>Hyper\-V Virtual Switch  
The Hyper\-V Virtual Switch is a software\-based layer\-2 Ethernet network switch that is available in Hyper\-V Manager after you have installed the Hyper\-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. In addition, Hyper\-V Virtual Switch provides policy enforcement for security, isolation, and service levels.  
  
In Hyper\-V Virtual Switch in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], you can also deploy Switch Embedded Teaming \(SET\) and Remote Direct Memory Access \(RDMA\). For more information, see the section [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](#bkmk_rdma) in this topic.  
  
For more information about Hyper\-V Virtual Switch, see [Hyper-V Virtual Switch](Hyper-V-Virtual-Switch.md).  
  
### <a name="bkmk_nfv"></a>Network Function Virtualization  
In today’s software defined datacenters, network functions that are being performed by hardware appliances \(such as load balancers, firewalls, routers, switches, and so on\) are increasingly being virtualized as virtual appliances. This “network function virtualization” is a natural progression of server virtualization and network virtualization. Virtual appliances are quickly emerging and creating a brand new market. They continue to generate interest and gain momentum in both virtualization platforms and cloud services.  
  
The following NFV technologies are now available.  
  
-   **Software Load Balancer \(SLB\) and Network Address Translation \(NAT\)**. The north\-south and east\-west layer 4 load balancer and NAT enhances throughput by supporting Direct Server Return, with which the return network traffic can bypass the Load Balancing multiplexer.  
  
-   **Datacenter Firewall**. This distributed firewall provides granular access control lists \(ACLs\),  enabling you to apply firewall policies at the VM interface level or at the subnet level.  
  
    For more information, see [Datacenter Firewall Overview](Datacenter-Firewall-Overview.md).  
  
-   **Gateways**. You can use gateways for bridging traffic between virtual networks and non\-virtualized networks; specifically, you can deploy site\-to\-site VPN gateways, forwarding gateways, and Generic Routing Encapsulation \(GRE\) gateways. In addition, M\+N redundancy of gateways is supported.  
  
For more information, see [Network Function Virtualization](Network-Function-Virtualization.md).  
  
### <a name="bkmk_rdma"></a>Remote Direct Memory Access \(RDMA\) and Switch Embedded Teaming \(SET\)  
In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], you can  enable RDMA on network adapters that are  bound to a Hyper\-V Virtual Switch with or without Switch Embedded Teaming \(SET\). This allows you to use fewer network adapters when you want to use RDMA and SET at the same time.  
  
SET is an alternative NIC Teaming solution that you can use in environments that include Hyper\-V and the Software Defined Networking \(SDN\) stack in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. SET integrates some of the NIC Teaming functionality into the Hyper\-V Virtual Switch.  
  
SET allows you to group between one and eight physical Ethernet network adapters into one or more software\-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.  
SET member network adapters must all be installed in the same physical Hyper\-V host to be placed in a team.  
  
In addition,  you can use Windows PowerShell commands to enable Data Center Bridging \(DCB\), create a Hyper\-V Virtual Switch with an RDMA virtual NIC \(vNIC\), and create a Hyper\-V Virtual Switch with SET and RDMA vNICs.  
  
For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://technet.microsoft.com/library/mt403349.aspx).  
  
### <a name="bkmk_rras"></a>RAS Gateway for SDN  
RAS Gateway is a software\-based, multitenant, Border Gateway Protocol \(BGP\) capable router in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] that is designed for Cloud Service Providers \(CSPs\) and Enterprises that host multiple tenant virtual networks using Hyper\-V Network Virtualization.  
  
RAS Gateway provides gateway pools, M\+N redundancy, multiple types of site\-to\-site VPN connections, and BGP Route Reflector to provide you with flexible design choices for your gateway infrastructure.  
  
For more information, see [RAS Gateway for SDN](RAS-Gateway-for-SDN.md)  
  
### <a name="bkmk_slb"></a>Software Load Balancing \(SLB\)  
Cloud Service Providers \(CSPs\) and Enterprises that are deploying Software Defined Networking \(SDN\) in Windows Server 2016 Technical Preview can use Software Load Balancing \(SLB\) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.  
  
For more information, see [Software Load Balancing &#40;SLB&#41; for SDN](Software-Load-Balancing--SLB--for-SDN.md).  
  
### <a name="bkmk_team"></a>NIC Teaming  
NIC Teaming allows you to group between one and thirty\-two physical Ethernet network adapters into one or more software\-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.  
  
When you configure network adapters into a NIC team, they are connected into the NIC teaming solution common core, which then presents one or more virtual adapters \(also called team NICs \[tNICs\] or team interfaces\) to the operating system. [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] supports up to 32 team interfaces per team. There are a variety of algorithms that distribute outbound traffic \(load\) between the NICs.  
  
In addition, you can use NIC Teaming with both VMs and VLANs.  
  
For more information, see [NIC Teaming](NIC-Teaming.md) and [Windows Server 2012 R2 NIC Teaming (LBFO) Deployment and Management](https://www.microsoft.com/en-us/download/details.aspx?id=40319).  
  
## <a name="bkmk_sc"></a>System Center Technologies for Software Defined Networking  
System Center includes the following technologies for use with software defined networking.  
  
-   [System Center Operations Manager](#bkmk_scom)  
  
-   [System Center Virtual Machine Manager](#bkmk_scvmm)  
  
-   [Windows Server Gateway](#bkmk_wsgateway)  
  
### <a name="bkmk_scom"></a>System Center Operations Manager  
System Center 2012 Operations Manager provides infrastructure monitoring that is flexible and cost\-effective, helps ensure the predictable performance and availability of vital applications, and offers comprehensive monitoring for your datacenter and cloud, both private and public.  
  
For more information, see [Operations Manager](https://technet.microsoft.com/library/hh205987.aspx).  
  
### <a name="bkmk_scvmm"></a>System Center Virtual Machine Manager  
With  System Center 2012 SP1 Virtual Machine Manager, you can provision and manage virtual networks at scale. You can define and control virtual network policies centrally and link them to your applications or workloads. When your workload is deployed or moved, the network configuration adjusts itself automatically. This is important because it removes the need for manual reconfiguration of network hardware, thereby reducing operational complexity while saving your valuable resources for higher\-impact work. Virtual Machine Manager also helps you to control traffic flow between virtual networks, including the ability to define guaranteed bandwidth for your critical applications and workloads.  
  
For more information, see [Virtual Machine Manager](https://technet.microsoft.com/library/gg610610.aspx).  
  
### <a name="bkmk_wsgateway"></a>Windows Server Gateway  
To deploy Windows Server Gateway, you must use System Center 2012 R2 and Virtual Machine Manager. The Windows Server Gateway router is designed for use with multitenant deployments. With the System Center 2012 R2 Virtual Machine Manager Windows Server Gateway router, only a very limited set of Border Gateway Protocol \(BGP\) configuration options are available in the Virtual Machine Manager software interface, including Local BGP IP Address and Autonomous System Numbers \(ASN\), List of BGP Peer IP Addresses, and ASN, values. You can, however, use Remote Access Windows PowerShell BGP commands to configure all other features of Windows Server Gateway.  
  
For more information, see [Windows Server Gateway](https://technet.microsoft.com/library/dn313101.aspx).  
  
## <a name="bkmk_az"></a>Microsoft Azure  
Microsoft Azure is Microsoft’s cloud platform: a growing collection of integrated services—compute, storage, data, networking, and app—that help you move faster, do more, and save money.  
  
Microsoft’s approach to software defined networking includes designing, building, and operating global\-scale datacenter networks for services like Microsoft Azure. Microsoft Azure global datacenters perform tens of thousands of network changes every day, which is possible only because of software defined networking.  
  
Microsoft Azure runs on the same Windows Server and Hyper\-V platform that are included in Windows Server. Windows Server and System Center include improvements and best practices from Microsoft’s experience in operating global scale datacenter networks like Microsoft Azure to you so that you can deploy the same technologies for flexibility, automation, and control when using software designed networking technologies.  
  
For more information, see [What is Microsoft Azure?](http://azure.microsoft.com/overview/what-is-azure/?WT.mc_id=azurebg_us_sem_bing_br_nontest_whatisazure_whatisazure&WT.srch=1).  
  

