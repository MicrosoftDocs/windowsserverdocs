---
title: IP Address Management (IPAM) Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e27c024-36f7-4a36-8987-5590f13a45e2
---
# IP Address Management (IPAM) Overview
This topic provides a summary of the IP Address Management \(IPAM\) Server feature in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For detailed information, see the following topics:  
  
|Topic|Guidance|  
|---------|------------|  
|[What's New in IPAM \[redirected\]](assetId:///7c63bdb6-af0f-4fbf-ace9-10b807bfeede)|This topic provides information about additions and changes in IPAM in different Windows Server operating system versions.|  
|[Demonstrate IPAM](../Topic/Demonstrate-IPAM.md)|Step\-by\-step procedures are provided for using IPAM in a test environment.|  
|[Plan and Design IPAM](../Topic/Plan-and-Design-IPAM.md)|Architectural and planning information for IPAM is provided.|  
|[Deploy IPAM](../Topic/Deploy-IPAM.md)|Provides detailed, click\-by\-click deployment instructions to deploy IPAM in a production environment.|  
|[Manage IPAM_1](../Topic/Manage-IPAM_1.md)|Provides operational, troubleshooting, and best practices guidance for IPAM.|  
|[Windows Server 2012 Virtual Labs](http://technet.microsoft.com/windowsserver/hh968267.aspx)|Two virtual labs are available for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including [Managing Your Network Infrastructure with IP Address Management](http://go.microsoft.com/?linkid=9806475), which demonstrates IPAM only, and [Building a Resilient Network Infrastructure](http://go.microsoft.com/fwlink/p/?LinkID=317748), a virtual lab that combines IPAM with DNSSEC and DHCP failover in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. **Note**: Virtual labs might require some time to start.|  
|[IPAM Server Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj553807.aspx)|Provides a list and examples of available Windows PowerShell cmdlets for IPAM server.|  
  
## <a name="BKMK_1"></a>Feature description  
IP Address Management \(IPAM\) in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] is an integrated suite of tools to enable end\-to\-end planning, deploying, managing and monitoring of your IP address infrastructure, with a rich user experience. IPAM automatically discovers IP address infrastructure servers on your network and enables you to manage them from a central interface.  
  
IPAM includes components for:  
  
1.  [Address Space Management](../Topic/IP-Address-Management--IPAM--Overview.md#ASM)  
  
2.  [Virtual Address Space Management](../Topic/IP-Address-Management--IPAM--Overview.md#VASM)**\***  
  
3.  [Multi\-Server Management and Monitoring](../Topic/IP-Address-Management--IPAM--Overview.md#MSM)  
  
4.  [Network Audit](../Topic/IP-Address-Management--IPAM--Overview.md#Audit)  
  
5.  [Role\-based access control](../Topic/IP-Address-Management--IPAM--Overview.md#RBAC)**\*\***  
  
**\*** Virtual IP address space management is enabled through integration of IPAM with system center virtual machine manager and is available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and later operating systems. This feature is not available with IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
**\*\*** Role\-based access control is available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] using local user groups on the IPAM server. This feature was significantly enhanced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to include detailed built\-in and custom role\-based access groups.  
  
Also see the following sections in this topic:  
  
-   [IPAM deployment options](../Topic/IP-Address-Management--IPAM--Overview.md#BKMK_2): Provides a summary of IPAM design choice. For detailed information, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
-   [IPAM specifications](../Topic/IP-Address-Management--IPAM--Overview.md#BKMK_3): Provide a summary of IPAM deployment requirements and capabilities.  
  
For information about getting started with IPAM, see [Using the IPAM Client Console](../Topic/Using-the-IPAM-Client-Console.md).  
  
### <a name="ASM"></a>Address Space Management  
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
  
### <a name="VASM"></a>Virtual Address Space Management  
IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] includes the ability to manage virtual IP address space that is configured using system center virtual machine manager \(VMM\).  
  
IPAM’s virtual address space management \(VASM\) feature enables the same functions and capabilities for your virtual IP address infrastructure as the ASM feature does for physical IP address space.  
  
For more information, see [Managing Virtual IP Address Space](../Topic/Managing-Virtual-IP-Address-Space.md).  
  
### <a name="MSM"></a>Multi\-Server Management and Monitoring  
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
  
### <a name="Audit"></a>Network Audit  
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
  
### <a name="RBAC"></a>Role\-based access control  
IPAM’s role\-based access control feature enables you to customize the types of operations and access permissions for users and groups of users on specific objects in IPAM. Role based access control in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is less fine\-grained than in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. See the following comparison.  
  
|Group|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|---------|-----------------------------------------------------------|-----------------------------------------------------------------|  
|Local IPAM security groups|IPAM Users<br /><br />IPAM ASM Administrators<br /><br />IPAM MSM Administrators<br /><br />IPAM IP Audit Administrators<br /><br />IPAM Administrators|IPAM Users<br /><br />IPAM ASM Administrators<br /><br />IPAM MSM Administrators<br /><br />IPAM IP Audit Administrators<br /><br />IPAM Administrators|  
|Built\-in IPAM role\-based access groups|N\/A|DNS Record Administrator<br /><br />IP Address Record Administrator<br /><br />IPAM Administrator<br /><br />IPAM ASM Administrator<br /><br />IPAM DHCP Administrator<br /><br />IPAM DHCP Reservations Administrator<br /><br />IPAM DHCP Scope Administrator<br /><br />IPAM MSM Administrator|  
|Custom IPAM role\-based\-access groups|N\/A|Unlimited|  
  
### <a name="BKMK_2"></a>IPAM deployment options  
An IPAM server is a domain member computer.  
  
> [!IMPORTANT]  
> You cannot install the IPAM feature on an Active Directory domain controller.  
  
There are three general methods to deploy IPAM servers:  
  
1.  **Distributed**: An IPAM server deployed at every site in an enterprise.  
  
2.  **Centralized**: One IPAM server in an enterprise.  
  
3.  **Hybrid**: A central IPAM server deployed with dedicated IPAM servers at each site.  
  
The following example displays the distributed IPAM deployment method, with one IPAM server located at the corporate headquarters and also at each branch office. There is no communication or database sharing between different IPAM servers in the enterprise. If multiple IPAM servers are deployed, you can customize the scope of discovery for each IPAM server, or filter the list of managed servers. A single IPAM server might manage a specific domain or location, perhaps with a second IPAM server configured as a backup.  
  
![](../Image/IPAM_arch.gif)  
  
IPAM will periodically attempt to locate domain controllers, DNS, and DHCP servers on the network that are within the scope of discovery that you specify. You must choose whether these servers are managed by IPAM or unmanaged. In this way, you can select different groups of servers that are managed or not managed by IPAM.  
  
To be managed by IPAM, security settings and firewall ports on a server must be configured to allow the IPAM server access so that it can perform required monitoring and configuration functions.  You can configure these settings manually, or automatically using Group Policy Objects \(GPOs\). If you choose the automatic method, settings are applied when a server is marked as managed and settings are removed when it is marked as unmanaged.  
  
The IPAM server will communicate with managed servers using an RPC or WMI interface. IPAM monitors domain controllers and NPS servers for IP address tracking purposes. In addition to monitoring functions, several DHCP server and scope properties can be configured from the IPAM console. Zone status monitoring and a limited set of configuration functions are also available for DNS servers. See the following figure.  
  
![](../Image/IPAM_comm.gif)  
  
For more information, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
### <a name="BKMK_3"></a>IPAM specifications  
The scope of IPAM server discovery is limited to a single Active Directory forest. The forest itself may be comprised of a mix of trusted and untrusted domains. IPAM requires membership in an Active Directory domain, and relies on a functional network infrastructure environment to integrate with other server installations across the AD forest.  
  
IPAM has the following specifications:  
  
1.  IPAM supports only Microsoft domain controllers, DHCP, DNS, and NPS servers running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and above.  
  
2.  IPAM supports only domain joined DHCP, DNS and NPS servers in a single AD forest.  
  
3.  In its recommended configuration, IPAM is installed on a standalone server. You cannot install IPAM on a domain controller. If IPAM is installed on the same server with the DHCP Server role service, automatic discovery of DHCP servers on the network will be disabled.  
  
4.  IPAM does not support management and configuration of non\-Microsoft network elements. However, you can use Windows PowerShell to import and manage IP address data from non\-Microsoft devices.  
  
5.  IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] does not support external databases. Only a Windows Internal Database is supported.  
  
6.  A single IPAM server has been tested to support up to 150 DHCP servers and 500 DNS servers.  
  
7.  A single IPAM server has been tested to support up to 40,000 DHCP scopes and 350 DNS zones.  
  
8.  IPAM has been tested to store 3 years of forensics data \(IP address leases, host MAC addresses, user login\/logoff information\) for 100,000 users in a Windows Internal Database. Data is not purged automatically. An administrator must purge data manually as needed.  
  
9. IP address utilization trends are provided only for IPv4.  
  
10. IP address reclaiming support is provided for IPv4 and IPv6.  
  
11. IPAM does not check for IP address consistency with routers and switches.  
  
12. IPAM does not support auditing of IPv6 stateless address auto configuration on an unmanaged machine to track the user.  
  
13. IPAM supports integration with System Center Virtual Machine Manager \(VMM\) using a Windows PowerShell script that is packaged and shipped with System Center VMM. This integration enables IPAM to display detailed utilization and inventory data for IP addresses and IP address ranges used in System Center VMM.  
  
## Practical applications  
Monitoring and managing the IP address infrastructure on a corporate network is a critical part of network administration, and has become increasingly challenging as networks grow more dynamic and complex. Many IT administrators still track IP address allocation and utilization manually, using spreadsheets or custom database applications. This can be very time consuming and resource intensive, and is inherently prone to user error. IPAM in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides a platform to manage the following IP administration needs.  
  
1.  Planning: IPAM replaces manual tools and scripts that can introduce added time, inconsistency and expense into the planning process when business expansions and alterations occur, or new technology and scenario adoptions are required.  
  
2.  Managing: IPAM provides a single management platform for IP address administration on the network. IPAM also allows for optimized utilization and capacity planning for DHCP and DNS services in distributed environment.  
  
3.  Tracking: IPAM enables tracking and forecasting of IP address utilization. As the demand for public IPv4 address space continues to grow in an environment with limited supply, this can be of critical importance to an organization.  
  
4.  Auditing: IPAM assists with compliance requirements such as HIPAA and Sarbanes\-Oxley, and provides reporting for forensics and change management.  
  
## New and changed functionality  
See [What's New in IPAM in Windows Server 2012 R2](assetId:///48756719-0df9-4d5a-b6f5-fe2b3ae66953).  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
The installation of the IPAM Server feature can be performed through the Server Manager. The following features and tools are installed automatically when you install IPAM Server:  
  
|Feature or Tool|Description|  
|-------------------|---------------|  
|Remote Server Administration Tools|DHCP and DNS Server Tools and IP Address Management \(IPAM\) Client provides for remotely managing DHCP, DNS and IPAM servers.|  
|Windows Internal Database|Windows Internal Database is a relational data store that can be used only by Windows roles and features.|  
|Windows Process Activation Service|Windows Process Activation Service generalizes the IIS process model, removing the dependency on HTTP.|  
|Group Policy Management|Group Policy Management is a scriptable Microsoft Management Console \(MMC\), providing a single administrative tool for managing Group Policy.|  
|.NET Framework 4.5 Features|.NET Framework 4.5 provides a programming model for building and running applications designed for several different platforms.|  
  
## See also  
[What's New in IPAM in Windows Server 2012 R2](assetId:///48756719-0df9-4d5a-b6f5-fe2b3ae66953)  
  
[Plan and Design IPAM](../Topic/Plan-and-Design-IPAM.md)  
  
[Deploy IPAM](../Topic/Deploy-IPAM.md)  
  
[Manage IPAM_1](../Topic/Manage-IPAM_1.md)  
  
[Walkthrough: Demonstrate IPAM in Windows Server 2012](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012.md)  
  
[Walkthrough: Demonstrate IPAM in Windows Server 2012 R2](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md)  
  
