---
title: What is IPAM?
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 717a16af-d39e-4463-ad46-747be62bb498
---
# What is IPAM?
IP Address Management \(IPAM\) in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] is an integrated suite of tools to enable end\-to\-end planning, deploying, managing and monitoring of your IP address infrastructure, with a rich user experience. IPAM automatically discovers IP address infrastructure servers on your network and enables you to manage them from a central interface.  
  
IPAM includes components for:  
  
1.  [Address Space Management](../Topic/What-is-IPAM-.md#ASM)  
  
2.  [Virtual Address Space Management](../Topic/What-is-IPAM-.md#VASM)  
  
3.  [Multi\-Server Management and Monitoring](../Topic/What-is-IPAM-.md#MSM)  
  
4.  [Network Audit](../Topic/What-is-IPAM-.md#Audit)  
  
5.  [Role\-based access control](../Topic/What-is-IPAM-.md#RBAC)  
  
> [!NOTE]  
> Virtual IP address space management is enabled through integration of IPAM with system center virtual machine manager and is available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and later operating systems. This feature is not available with IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The role\-based access control feature is available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], but was significantly enhanced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to include detailed built\-in and custom role\-based access groups.  
  
## <a name="ASM"></a>Address Space Management  
IPAM’s address space management \(ASM\) feature enables you to gain visibility into all aspects of your IP address infrastructure from a single console. With IPAM, you can create a highly customized, multi\-level hierarchy of address space on your network and use it to manage IPv6 addresses and IPv4 public and private addresses. The ASM feature includes a robust reporting capability that enables detailed tracking of IP address utilization trends with customized thresholds and alerts.  
  
Key features of ASM include the following.  
  
-   Integrated management of dynamic and static IP address space  
  
-   Detection and management of conflicts, overlaps, and duplicates in address space across systems  
  
-   Highly customizable inventory view of IP address space  
  
-   Centralized monitoring and reporting of address utilization statistics and trends  
  
-   Support for IPv4 and stateless IPv6 address utilization monitoring  
  
-   Automated discovery of IP address ranges from DHCP scopes  
  
-   Export and import of IP addresses and IP address ranges with Windows PowerShell support  
  
-   IP address usage alerts and notifications with custom thresholds  
  
-   Detection and assignment of available IP addresses  
  
The following example shows how IPAM’s ASM feature enables you to monitor IP address utilization. In this example, 7 days of utilization data is displayed for the 10.72.144.0\/22 IP address range.  
  
![](../Image/IPAM_address_trend_small.png)  
  
For more information, see [Managing IP Address Space](../Topic/Managing-IP-Address-Space.md).  
  
## <a name="VASM"></a>Virtual Address Space Management  
IPAM’s virtual address space management \(VASM\) feature enables the same functions and capabilities for your virtual IP address infrastructure as the ASM feature does for physical IP address space.  
  
For more information, see [Managing Virtual IP Address Space](../Topic/Managing-Virtual-IP-Address-Space.md).  
  
## <a name="MSM"></a>Multi\-Server Management and Monitoring  
IPAM’s multi\-server management \(MSM\) feature enables you to automatically discover DHCP and DNS servers on the network, monitor service availability, and centrally manage their configuration. Using the Group Policy provisioning mode, IPAM provides quick and painless provisioning of agentless IPAM access settings on managed servers. A manual provisioning mode is also available.  
  
Key features of MSM include the following.  
  
-   Discovery of Microsoft DHCP and DNS servers automatically across an Active Directory forest  
  
-   Manual addition or removal of managed servers  
  
-   End\-to end configuration and management of DHCP servers and scopes  
  
-   Support for advanced constructs to enable add, delete, overwrite, or find and replace operations on multiple DHCP scopes and servers  
  
-   Simultaneous update of common settings across multiple DHCP scopes or DHCP servers  
  
-   Availability monitoring for DHCP and DNS services and DNS zones  
  
-   Management of Microsoft DHCP and DNS servers running Windows 2008 or later operating systems  
  
-   Addition of custom information to servers enabling visualization using logical groups based on business logic  
  
-   Monitoring of DHCP scope utilization  
  
-   Automatic and on\-demand retrieval of server data from managed DHCP and DNS servers  
  
-   DNS zone status monitoring based on DNS zone events  
  
-   Classify discovered servers and roles as managed or unmanaged  
  
The following example shows how IPAM’s MSM feature enables you to monitor IP DHCP scopes on the network. In this example, detailed data is displayed for the scope US\_SEA\_zzz3.  
  
![](../Image/IPAM_scopes_view_small.png)  
  
For more information, see [Multi-server Management](../Topic/Multi-server-Management.md).  
  
## <a name="Audit"></a>Network Audit  
IPAM’s audit feature provides a centralized repository for all configuration changes performed on DHCP servers and the IPAM server, and for IP addresses issued on the network. IPAM audit tools enable you to view potential configuration problems on DHCP servers by actively tracking and reporting all administrative actions. Detailed IP address tracking data is also provided, including client IP addresses, client ID, host name, and user name. Advanced search capabilities enable you to selectively search for events and obtain results that associate user logons to specific devices and times.  
  
Key features of network audit include the following.  
  
-   Query the event catalog for DHCP configuration changes across multiple servers from a single console  
  
-   Track users, devices, and IP addresses for specified intervals with advanced queries using DHCP lease logs and logon events from domain controllers and network policy servers  
  
-   Track and report changes made to the IPAM server  
  
-   Export audit findings and create reports  
  
-   Quickly resolve configuration problems and track service level agreements  
  
The following example shows how IPAM’s network audit feature enables you to track IP addresses on the network. In this example, details are displayed for a lease event in the contoso.com domain.  
  
![](../Image/IPAM_tracking_small.png)  
  
For more information, see [IP Address Tracking](../Topic/IP-Address-Tracking.md) and [Operational Event Tracking](../Topic/Operational-Event-Tracking.md).  
  
## <a name="RBAC"></a>Role\-based access control  
IPAM’s role\-based access control feature enables you to customize the types of operations and access permissions for users and groups of users on specific objects in IPAM. Role based access control in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is less fine\-grained than in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. See the following comparison.  
  
|Group|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|---------|-----------------------------------------------------------|-----------------------------------------------------------------|  
|Local IPAM security groups|IPAM Users<br /><br />IPAM ASM Administrators<br /><br />IPAM MSM Administrators<br /><br />IPAM IP Audit Administrators<br /><br />IPAM Administrators|IPAM Users<br /><br />IPAM ASM Administrators<br /><br />IPAM MSM Administrators<br /><br />IPAM IP Audit Administrators<br /><br />IPAM Administrators|  
|Built\-in IPAM role\-based access groups|N\/A|DNS Record Administrator<br /><br />IP Address Record Administrator<br /><br />IPAM Administrator<br /><br />IPAM ASM Administrator<br /><br />IPAM DHCP Administrator<br /><br />IPAM DHCP Reservations Administrator<br /><br />IPAM DHCP Scope Administrator<br /><br />IPAM MSM Administrator|  
|Custom IPAM role\-based\-access groups|N\/A|Unlimited|  
  
## See also  
[IPAM Terminology](../Topic/IPAM-Terminology.md)  
  
[Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md)  
  
[IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md)  
  
[IPAM Architecture](../Topic/IPAM-Architecture.md)  
  
