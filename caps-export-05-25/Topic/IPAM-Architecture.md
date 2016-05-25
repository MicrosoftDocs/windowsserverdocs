---
title: IPAM Architecture
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9116896d-9582-4f13-bc98-f0bcfa0e4581
---
# IPAM Architecture
An IPAM infrastructure includes the following primary components:  
  
-   [IPAM Client](../Topic/IPAM-Architecture.md#client): A computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] or a later operating system.  
  
-   [IPAM Server](../Topic/IPAM-Architecture.md#server): A computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system.  
  
-   [Managed servers](../Topic/IPAM-Architecture.md#managed_servers): Domain controllers, NPS, DNS, and DHCP servers running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] or later.  
  
IPAM components and interactions are illustrated in the following figure.  
  
![](../Image/IPAM_infrastructure.png)  
  
> [!IMPORTANT]  
> Role\-based access control for IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is enhanced, enabling you to configure custom administrator roles. The same local security groups are available; however you can also use the IPAM client console to create groups with specific access control settings. For more information, see [Access Control](../Topic/Access-Control.md).  
  
See the following topics for more information about IPAM infrastructure components.  
  
## <a name="client"></a>IPAM Client  
An IPAM client computer is a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] with the Remote Server Administration Tools \(RSAT\) for Windows 8 installed. If the computer is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], IPAM Client is automatically selected for installation under **Features > Remote Server Administration Tools > Feature Administration Tools > IP Address Management \(IPAM\) Client** when you install IPAM Server.  
  
In its default configuration, IPAM Client is installed on the same computer with IPAM Server, however this is not required. You can also install the IPAM client on a computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] by installing the [Remote Server Administration Tools \(RSAT\) for Windows 8](http://www.microsoft.com/download/details.aspx?id=28972) \(http:\/\/www.microsoft.com\/download\/details.aspx?id\=28972\). You can install the IPAM client on a computer running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] by installing the [Remote Server Administration Tools \(RSAT\) for Windows 8.1](http://www.microsoft.com/download/details.aspx?id=39296) \(http:\/\/www.microsoft.com\/download\/details.aspx?id\=39296\). You can also install the IPAM client on more than one computer. IPAM Server supports multiple concurrent connections from different IPAM Clients. A single IPAM Client can connect to one IPAM Server at a time.  
  
Available IPAM installation options are summarized in the following table.  
  
|Operating system|Configuration|Available IPAM connections|  
|--------------------|-----------------|------------------------------|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|IPAM Server \+ IPAM Client|Connect to the local IPAM server or a remote IPAM server from the local client|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|IPAM Client only|Connect to a remote IPAM server from the local client|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|IPAM Server only|Connect to the local server from a remote client|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|RSAT for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|Connect to a remote IPAM server from the local client|  
  
### Client communications  
The IPAM client communicates with an IPAM server using the Windows Communication Foundation \(WCF\) protocol with TCP as the transport method. By default, TCP binding is performed on port 48885 on the IPAM server. If there is a port conflict, or there is a need to reconfigure the server port, the port number on the server can be configured using the Windows PowerShell cmdlets **Get\-IpamConfiguration** and **Set\-IpamConfiguration**. For more information about IPAM and Windows PowerShell, see [Using Windows PowerShell with IPAM](../Topic/Using-Windows-PowerShell-with-IPAM.md).  
  
## <a name="server"></a>IPAM Server  
An IPAM server is a domain member computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or a later operating system. You cannot install IPAM Server on a domain controller, and it is not recommended to install IPAM Server on the same server with DHCP Server. For more information about specifications and requirements for IPAM Server, see [IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md).  
  
### Server communications  
The IPAM server uses Lightweight Directory Access Protocol \(LDAP\) to discover domains and DHCP servers in the Active Directory forest. The Session Message Block \(SMB\) protocol is used to retrieve IP address lease information from the audit log file on DHCP servers.  
  
The IPAM server communicates with managed DHCP servers to get DHCP scope utilization, scope configuration, server configuration information, and DHCP operational events. Configuration information is acquired by Windows PowerShell for DHCP Server using \[MS\-DHCPM\]. Specific communication ports must be enabled in Windows Firewall for this communication to be successful.  
  
> [!NOTE]  
> For information about \[MS\-DHCPM\] and other Microsoft protocol specifications, see the [Technical Specification Cross\-Reference Matrix](http://msdn.microsoft.com/library/hh564200.aspx) on MSDN.  
  
IPv4 and IPv6 address lease information is obtained from an audit log file on the DHCP server using SMB, and the IPAM server also regularly retrieves service status for DHCP and DNS servers using \[MS\-SCMR\]. The IPAM server communicates with DNS servers to get server configuration and DNS zone settings with Windows PowerShell commands for DNS Server using \[MS\-DNSP\], respectively.  
  
The IPAM server communicates with domain controllers and NPS using \[MS\-EVEN6\] to collect user and computer logon events that are generated when a network access request is authenticated.  
  
### <a name="scheduled_tasks"></a>Scheduled tasks  
The IPAM server maintains a local database that is dynamically updated by regularly scheduled data collection tasks. These tasks run on the IPAM server at configurable intervals and communicate with managed servers \(domain controllers, NPS, DNS, and DHCP servers\) using an agentless architecture. IPAM scheduled data collection tasks are summarized below. These tasks can be viewed and modified in Task Scheduler by navigating to **Microsoft > Windows > IPAM**.  
  
|Task Name|Description|Default Frequency|Duration|  
|-------------|---------------|---------------------|------------|  
|AddressExpiry|Tracks IP address expiry state and logs notifications.|1 day|Indefinite|  
|AddressUtilization|Collects IP address space usage data from DHCP servers to display current and historical utilization.|2 hours|Indefinite|  
|Audit|Collects DHCP and IPAM server operational events. Also collects events from domain controllers, NPS, and DHCP servers for IP address tracking.|1 day|Indefinite|  
|ServerAvailability|Collects service status information from DHCP and DNS servers.|15 minutes|Indefinite|  
|ServerConfiguration|Collects configuration information from DHCP and DNS servers for display in IP address space and server management functions.|6 hours|Indefinite|  
|ServerDiscovery|Automatically discovers the domain controllers, DHCP servers, and DNS servers in the domains you select.|1 day|Indefinite|  
|ServiceMonitoring|Collects DNS zone status events from DNS servers.|30 minutes|Indefinite|  
  
### The IPAM database  
Information in the IPAM database is regularly updated by data collection tasks, and can be modified by administrators. For example, when an administrator creates a custom logical group or assigns an expiration date to an IP address, this information is stored in the IPAM database and associated to specific managed servers.  
  
The IPAM database leverages the Windows Internal Database \(WID\) feature, a relational data store that is automatically installed when you install IPAM Server. IPAM does not support the use of an external database. For more information about WID, see [Windows Internal Database Overview](http://technet.microsoft.com/library/cc754405.aspx).  
  
> [!IMPORTANT]  
> IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] introduced the option to specify a SQL database to store IPAM data. To use SQL, the database server must be running SQL Server 2008 R2 or later. When you use a SQL database with IPAM, this does not enable additional IPAM reporting features, such as those associated with SQL Server Reporting Services. The use of a SQL server database is only intended to provide the option of using your existing database infrastructure, which might include existing backup and failover capabilities.  
  
### Role\-based access control  
When you install IPAM, local security groups are created on the IPAM server to provide role\-based access control for different sets of IPAM administrators and users. IPAM uses these role\-based access controls to determine what information is displayed in the IPAM client console. For example, viewing of IP address lease data can be restricted to a specific set of administrators by adding their user account to the IPAM IP Audit Administrators or IPAM Administrators group.  
  
The following local user groups are created when you install IPAM:  
  
|Group Name|Description|  
|--------------|---------------|  
|IPAM Users|IPAM Users is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group can view all information in server inventory, IP address space, and the monitor and manage IPAM console nodes. IPAM Users can view IPAM and DHCP operational events under in the Event Catalog node, but cannot view IP address tracking data.|  
|IPAM MSM Administrators|IPAM MSM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group, and can perform server monitoring and management tasks in addition to IPAM common management tasks.|  
|IPAM ASM Administrators|IPAM ASM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group, and can perform IP address space tasks in addition to IPAM common management tasks.|  
|IPAM IP Audit Administrators|IPAM IP Audit Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have all the privileges of the IPAM Users security group. They can view IP address tracking data and perform IPAM common management tasks.|  
|IPAM Administrators|IPAM Administrators is a local security group on an IPAM server that is created when you install the IPAM feature. Members of this group have privileges to view all IPAM data and perform all IPAM tasks.|  
  
> [!IMPORTANT]  
> Role\-based access control for IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is enhanced, enabling you to configure custom administrator roles. The same local security groups that are listed in the previous table are available; however you can also use the IPAM client console to create groups with specific access control settings. For more information, see [Access Control](../Topic/Access-Control.md).  
  
## <a name="managed_servers"></a>Managed servers  
Managed servers must be running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or above.  
  
The IPAM server communicates on a periodic basis with DHCP servers, DNS servers, domain controllers, and NPS using remote management technologies including: remote procedure call \(RPC\), Windows Management Instrumentation \(WMI\), Server Message Block \(SMB\) and Web Services for Management \(WS\-Management\). This eliminates the need for deploying and maintaining dedicated management agents on each server, but requires that specific firewall ports be made available to the IPAM server.  
  
The following table summarizes communications between the IPAM server and the specified managed server roles.  
  
|Server Role|Communication Methods|Actions|  
|---------------|-------------------------|-----------|  
|DHCP|RPC, WMI, SMB, WS\-Management|-   Monitor: IP address utilization<br />-   Monitor: Service status<br />-   Configure: Servers and scopes<br />-   Audit: IP address lease events<br />-   Audit: DHCP configuration events|  
|DNS|RPC, WMI, WS\-Management|-   Discover: DNS servers<br />-   Monitor: DNS zone health<br />-   Configure: DNS zones|  
|Domain Controller|RPC, WMI, LDAP|-   Discover: DNS and DHCP servers<br />-   Validate: Managed servers<br />-   Audit: User and device logon events|  
|NPS|RPC|-   Audit: User and device logon events|  
  
Protocol specifications used by the IPAM server to communicate with managed servers include Microsoft Dynamic Host Configuration Protocol \(DHCP\) Server Management Protocol Specification \[MS\-DHCPM\], Domain Name Service \(DNS\) Server Management Protocol Specification \[MS\-DNSP\], EventLog Remoting Protocol Version 6.0 Specification \[MS\-EVEN6\], and Service Control Manager Remote Protocol Specification \[MS\-SCMR\]. These specifications use RCP as the underlying communication protocol.  
  
The IPAM client communicates with managed servers to remotely manage DHCP and DNS servers using Windows PowerShell provider with \[MS\-DHCPM\] and \[MS\-DNSP\]. The IPAM client also uses Windows PowerShell with \[MS\-PSRP\] to query the IPAM server port configuration and \[MS\-GPOL\] to configure Group Policy.  
  
## See also  
[What is IPAM?](../Topic/What-is-IPAM-.md)  
  
[IPAM Terminology](../Topic/IPAM-Terminology.md)  
  
[Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md)  
  
[IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md)  
  
[IPAM Backup and Restore](../Topic/IPAM-Backup-and-Restore.md)  
  
