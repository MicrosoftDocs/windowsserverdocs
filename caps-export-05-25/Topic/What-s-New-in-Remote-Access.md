---
title: What&#39;s New in Remote Access
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e12d73fc-269c-49b0-916e-51793a0fe6a0
author: vhorne
---
# What&#39;s New in Remote Access
This topic describes the Remote Access functionality that is new or changed in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], and Windows Server 2012.  
  
**In this topic:**  
  
-   [What’s new in Remote Access in Windows Server 2012 R2](../Topic/What-s-New-in-Remote-Access.md#BKMK_RA2012R2)  
  
-   [What’s new in Remote Access in Windows 8.1](../Topic/What-s-New-in-Remote-Access.md#BKMK_RAClient8.1)  
  
-   [What’s new in Remote Access in Windows Server 2012](../Topic/What-s-New-in-Remote-Access.md#BKMK_RA2012)  
  
-   [Remote Access Features Deprecated for Future Releases](#bkmk_deprecated)  
  
## <a name="BKMK_RA2012R2"></a>What’s new in Remote Access in Windows Server 2012 R2  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Remote Access offers enhanced support in the following areas:  
  
-   [Multi\-tenant site\-to\-site VPN Gateway](../Topic/What-s-New-in-Remote-Access.md#BKMK_SiteToSite)  
  
-   [Multi\-tenant Remote Access VPN Gateway](../Topic/What-s-New-in-Remote-Access.md#BKMK_Gateway)  
  
-   [Border Gateway Protocol](../Topic/What-s-New-in-Remote-Access.md#BKMK_Border)  
  
-   [Web Application Proxy](../Topic/What-s-New-in-Remote-Access.md#BKMK_WAP)  
  
### <a name="BKMK_SiteToSite"></a>Multi\-tenant site\-to\-site VPN Gateway  
With [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], hosts can deploy multi\-tenant site\-to\-site \(S2S\) gateways to provide cross\-premises connectivity from networks at the tenant sites to virtual networks that are dedicated per tenant in the host’s network. The virtual network of the tenant could be built on top of Hyper\-V Network Virtualization or VLAN at the hoster. A single gateway instance is capable of serving multiple tenants with overlapping IP address spaces, maximizing efficiency for the host as compared to deploying separate gateway instance per tenant. The Routing and Remote Access \(RRAS\) gateway is a software\-only solution that can be deployed in multiple instances of multi\-tenant RRAS servers to balance the load.  
  
### <a name="BKMK_Gateway"></a>Multi\-tenant Remote Access VPN Gateway  
With [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], hosts can allow transparent VPN access to virtual machines that are replicated in the cloud even after a failure when the entire site of the tenant goes down. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] reduces the CAPEX and OPEX for hosts with a single RRAS gateway that can service multiple tenants with overlapping IP address spaces. The RRAS gateway is a software\-only solution that can be deployed in multiple instances of multi\-tenant RRAS servers to balance the load.  
  
### <a name="BKMK_Border"></a>Border Gateway Protocol  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Border Gateway Protocol \(BGP\) enables dynamic distribution and learning of routes by using site\-to\-site \(S2S\) RRAS interfaces. This feature enables hosts \(primarily infrastructure\-as\-a\-service \(IaaS\) providers\) to deploy BGP on a multi\-tenant RRAS S2S gateway, so that the gateway can learn what packets need to be routed to the Internet, tenant premises, and tenant virtual network at the host, and then route them accordingly. A RRAS gateway with BGP enabled can also be deployed by enterprises at their premises edge to distribute internal routes to other edge gateways \(of the same enterprise in physical or virtual networks\) over secure tunnels.  
  
### <a name="BKMK_WAP"></a>Web Application Proxy  
**[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]** is a new Remote Access role service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. Organizations can provide selective or conditional access to these web applications, according to organizational requirements. Web Application Proxy also provides built\-in Active Directory Federation Services \(AD FS\) proxy capabilities. For more information, see [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md).  
  
## <a name="BKMK_RAClient8.1"></a>What’s new in Remote Access in Windows 8.1  
In [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], Remote Access offers enhanced support in the following areas:  
  
-   [Auto\-triggered VPN](../Topic/What-s-New-in-Remote-Access.md#BKMK_AutoTrigger)  
  
-   [SSL VPN plug\-in from non\-Microsoft vendors](../Topic/What-s-New-in-Remote-Access.md#BKMK_VPNPlug)  
  
-   [VPN client Windows PowerShell configuration](../Topic/What-s-New-in-Remote-Access.md#BKMK_ClientPowerShell)  
  
-   [VPN IPsec](../Topic/What-s-New-in-Remote-Access.md#BKMK_IPsec)  
  
-   [VPN profiles](../Topic/What-s-New-in-Remote-Access.md#BKMK_Profiles)  
  
### <a name="BKMK_AutoTrigger"></a>Auto\-triggered VPN  
Auto\-triggered VPN, or application\-triggered VPN, in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] allows predefined applications to automatically connect to corporate networks by opening a VPN connection when the application is started. You can define the applications you want to make available for auto\-triggering and restrict remote access based on the user identity and the computer identity from which the user is accessing the resource. This provides a secure and reliable way of accessing corporate resources from various devices. For more information, see [Windows Server 2012 R2 Test Lab Guide: Demonstrate VPN Auto trigger](../Topic/Windows-Server-2012-R2-Test-Lab-Guide--Demonstrate-VPN-Auto-trigger.md).  
  
### <a name="BKMK_VPNPlug"></a>SSL VPN plug\-in from non\-Microsoft vendors  
[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] for x86, amd64 \(and ARM in [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)]\) support the SSL VPN plug\-in from the following non\-Microsoft VPN vendors:  
  
-   Dell SonicWall, Inc.  
  
-   Juniper Networks, Inc.  
  
-   F5 Networks, Inc.  
  
-   Checkpoint Software Technologies, Ltd.  
  
The non\-Microsoft VPN plug\-in also supports a similar Windows PowerShell cmdlet to configure auto\-triggered VPN. The VPN connection profiles can be configured to auto\-trigger, based on a DNS name. Or for an application, the profiles can be configured by using Windows PowerShell or Microsoft mobile device management.  
  
Support for non\-Microsoft VPN plug\-ins is provided by the respective non\-Microsoft VPN partners. The following table provides links to documents from these partners.  
  
|||  
|-|-|  
|**VPN Plug\-in Provider**|**Support Document**|  
|**SonicWall**|[SonicWall Mobile Connect for Windows 8.1 User Guide](http://www.sonicwall.com/app/projects/file_downloader/document_lib.php?t=PG&id=605)|  
|**Juniper**|-   [Windows In\-Box Junos Pulse Client Quick Start Guide](http://www.juniper.net/techpubs/software/pulse/guides/j-pulse-windows-inbox-client-qsg.pdf)<br />-   [Junos Pulse documentation](http://www.juniper.net/techpubs/en_US/release-independent/junos-pulse/information-products/pathway-pages/junos-pulse/product/index.html)|  
|**F5 Networks**|-   [BIG\-IP APM Client Compatibility Matrix](http://support.f5.com/kb/products/big-ip_apm/manuals/product/apm-clientcompatmatrix-11-4-0.html)<br />-   [Configuration Notes: Inbox F5 VPN Client for Microsoft Windows 8.1](http://support.f5.com/kb/products/big-ip_apm/releasenotes/related/config-note-f5-inbox-vpn-client-windows8.html)|  
|**CheckPoint**|-   [Check Point Mobile VPN for Release Notes for iOS, Android, and Windows 8.1](http://supportcontent.checkpoint.com/documentation_download?ID=20341)<br />-   [Check Point Mobile VPN for Administration Guide for iOS, Android, and Windows 8.1](http://supportcontent.checkpoint.com/documentation_download?ID=20361)|  
  
### <a name="BKMK_ClientPowerShell"></a>VPN client Windows PowerShell configuration  
Advanced VPN configuration support in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] enables use of a single set of VPN configuration Windows PowerShell cmdlets to configure the VPN connections instead of using multiple scripts. This feature also improves Microsoft mobile device management by allowing all the required settings to be automatically configured on mobile devices without the need to run any additional scripts.  
  
### <a name="BKMK_IPsec"></a>VPN IPsec  
Enhanced IPsec in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] allows Suite\-B cryptography standards or other custom cryptography configurations for IPsec\-based tunnels. VPN clients can be configured to use these standards and configurations with easy\-to\-use Windows PowerShell cmdlets. It also allows you to decide which client certificate is selected for any particular VPN connection.  
  
### <a name="BKMK_Profiles"></a>VPN profiles  
In Windows 8, creating or editing VPN profiles had to be done in the **Desktop** view. In [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], you can create and edit VPN connection profiles in **PC Settings** rather than going to the **Desktop** and navigating through a number of menus. This new VPN profile editing experience is optimized and simplified for touch screens. Advanced properties can still be accessed through the desktop when they are needed.  
  
## <a name="BKMK_RA2012"></a>What’s new in Remote Access in Windows Server 2012  
In Windows Server 2012, Remote Access offers enhanced support in the following areas:  
  
-   [Server Core](../Topic/What-s-New-in-Remote-Access.md#bkmk_ike)  
  
-   [Windows PowerShell](../Topic/What-s-New-in-Remote-Access.md#bkmk_ps)  
  
-   [User monitoring](../Topic/What-s-New-in-Remote-Access.md#bkmk_user)  
  
-   [Server operational status](../Topic/What-s-New-in-Remote-Access.md#bkmk_ops)  
  
-   [Diagnostics](../Topic/What-s-New-in-Remote-Access.md#bkmk_diag)  
  
-   [Accounting and reporting](../Topic/What-s-New-in-Remote-Access.md#bkmk_account)  
  
-   [Site\-to\-site IKEv2 IPsec tunnel mode VPN](../Topic/What-s-New-in-Remote-Access.md#bkmk_ike)  
  
### <a name="bkmk_core"></a>Server Core  
Server Core is a minimal server installation option designed to reduce disk space, servicing, and management requirements, and decrease the operating system attack surface. The Server Core system does not support a Graphical User Interface, and administrators must use command line or remote management tools to accomplish all necessary configuration tasks.  
  
A [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Server Core installation includes support for the Remote Access server role for both DirectAccess and RRAS.  
  
The new Remote Access server role has complete Windows PowerShell support in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that you can use for installation, configuration and monitoring. The Remote Access server role can also be configured through remote server management.  
  
### <a name="bkmk_ps"></a>Windows PowerShell  
DirectAccess in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] lacks a complete scripting and command\-line interface for configuration options. [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provide full Windows PowerShell support for the setup, configuration, management, monitoring, and troubleshooting of the Remote Access server role, including the DirectAccess, RRAS, and Web Application Proxy role services.  
  
### <a name="bkmk_user"></a>User monitoring  
Monitoring and diagnostics capabilities for both RRAS server and DirectAccess are limited in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. For DirectAccess, the monitoring capabilities only include basic health monitoring of DirectAccess and its components. The monitoring data and statistics available are of little significance or relevance to administrators.  
  
User and server health monitoring introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] allows the administrator to understand the behavior of the DirectAccess clients and connections.  The monitoring console is used to keep track of the load on the DirectAccess server, user activity, and current resource usage. The administrator uses this information to identify potentially undesirable or inappropriate usage activities. Diagnostic tracing can be enabled from the monitoring console as well.  
  
Administrators of remote access solutions require the ability to monitor not only which users are connected, but also which resources they are accessing. If users complain that a particular server or file share is inaccessible while remote, the administrator currently has no way to determine if other users are successfully accessing the resource from the remote access console. Multiple tools and applications are typically needed to troubleshoot issues such as particular users consuming excessive bandwidth.  
  
The Dashboard is accessed from the new Remote Access server management console by selecting the Dashboard tab in the navigation pane. The dashboard displays overall operational status and remote client activity and status. The administrator can also view quick reports directly from the dashboard.  
  
The Monitoring Dashboard shows a summary of remote client connectivity status for the following items. The information is generated from the relevant Performance Monitor counters and accounting data.  
  
-   Total number of active remote clients connected \(includes both DirectAccess and VPN remote clients\)  
  
-   Total number of active DirectAccess clients connected \(only the total number of clients that are connected using DirectAccess\)  
  
-   Total number of active VPN clients connected \(only the total number of clients that are connected using VPN\)  
  
-   Total unique users connected \(includes both DirectAccess and VPN users, based on the active connections\)  
  
-   Total number of cumulative connections \(the total number of connections serviced by the Remote Access server since the last server restart\)  
  
-   Maximum number of remote clients connected \(the maximum concurrent remote users connected to the Remote Access server since the last server restart\)  
  
-   Total data transferred \(the total inbound and outbound traffic from the Remote Access server for both DirectAccess and VPN since the last server restart\)  
  
    1.  Inbound traffic \(total bytes\/traffic into the Remote Access server\/gateway\)  
  
    2.  Outbound traffic \(total bytes\/traffic out of the Remote Access server\/gateway\)  
  
In a cluster deployment, the Remote Client Activity and Status summary on the Remote Access Dashboard displays total values for all of the cluster nodes.  
  
Administrators can see a list of all remote users currently connected, and they can display a list of all resources being accessed by clicking the name of a particular remote user. Administrators can display remote user statistics by selecting the **Remote Client Status** link in the Remote Access Management Console. The user statistics can be filtered based on criteria selections by using the following fields:  
  
|||  
|-|-|  
|**Field Name**|**Value**|  
|Username|The user name or alias of the remote user. Wildcard characters can be used to select a group of users, such as contoso\\\* or \*\\administrator. If no domain is specified, then \*\\username is assumed.|  
|Hostname|The computer account name of the remote user. An IPv4 or IPv6 address can also be specified.|  
|Type|Either DirectAccess or VPN. If DirectAccess is selected, all remote users that are connecting by using DirectAccess are listed. If VPN is selected, all remote users that are connecting by using VPN are listed.|  
|ISP address|The IPv4 or IPv6 address of the remote user.|  
|IPv4 address|The inner IPv4 address of the tunnel that connects the remote user to the corporate network.|  
|IPv6 address|The inner IPv6 address of the tunnel that connects the remote user to the corporate network.|  
|Protocol\/tunnel|The transitioning technology used by the remote client. This is Teredo, 6to4, or IP\-HTTPS for DirectAccess users, and PPTP, L2TP, SSTP, or IKEv2 for VPN users.|  
|Resource accessed|All users who are accessing a particular corporate resource or an endpoint. The value corresponding to this field is the hostname\/IP address of the server\/endpoint.|  
|Server|The Remote Access server to which clients are connected. This is relevant only for cluster and multisite deployments.|  
  
### <a name="bkmk_ops"></a>Server operational status  
This feature allows administrators to manage and monitor the status of remote access deployments from a centralized monitoring console. The feature shows alerts to administrators whenever an issue requiring attention is detected. The interface displays detailed diagnostic information with steps to provide resolution.  
  
The **Dashboard** node of the console tree shows the status of the Remote Access server, including the status of remote access infrastructure and related components, as well as whether the configuration is properly distributed across entry points.  
  
The server **Operations Status** node of the console tree shows the status of the Remote Access server, including the status of remote access infrastructure and related components. By clicking a particular component, administrators can see the state, change history, and monitoring details for that component.  
  
If Remote Access servers are deployed in a cluster or multisite deployment, all servers in the cluster or multisite deployment are evaluated asynchronously, and are listed with their overall status. Administrators can scroll through the list of servers and expand or collapse the view to display DirectAccess and VPN server components.  
  
The Remote Access components with status monitors that are displayed in the Server Operations Status pane include:  
  
-   6to4  
  
-   DNS  
  
-   DNS64  
  
-   Domain controller  
  
-   IP\-HTTPS  
  
-   IPsec  
  
-   ISATAP  
  
-   Kerberos  
  
-   Management servers  
  
-   NAT64  
  
-   Network adapters  
  
-   Network location server  
  
-   Network security \(IPsec DoSP\)  
  
-   Services  
  
-   Teredo  
  
-   Load balancing  
  
-   VPN addressing  
  
-   VPN connectivity  
  
### <a name="bkmk_diag"></a>Diagnostics  
Troubleshooting remote access connectivity failures for both RRAS and DirectAccess can be very complex due to the limited logging capabilities currently provided. Administrators typically require network monitor captures and RRAS tracing for troubleshooting because Event Viewer logs are not very useful or prescriptive.  
  
[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provide the following diagnostic feature improvements for remote access troubleshooting:  
  
-   **Detailed event logging for DirectAccess**  
  
    Administrators can use improved event logging to identify problems and perform capacity and performance analysis. The event logs are standardized to ensure a consistent experience with other networking components.  
  
-   **Tracing and packet capture**  
  
    Integrated tracing makes it easy for administrators to gather trace logs and network packet captures with a single click. Both tracing with packet capture and log correlation are done as part of a single process when the administrator clicks the **Start tracing** task in the Tasks pane.  
  
-   **Log correlation**  
  
    This feature provides automated collection and correlation of logs for different DirectAccess components with a single click, leveraging the Unified Tracing feature in Windows. The events gathered from different components are consolidated into a single file through correlation of Activity IDs. Activity IDs are GUIDs that identify a particular task or action. When a component logs an event, it associates an Activity ID with the event. The component then passes this ID or a transfer event that is mapped to the ID to the component that performs the next task in the scenario. This associates its activity ID to log events. When analyzing the resulting trace file, the relationship between the various components relevant to a scenario can be reconstructed.  
  
-   **Enabling and viewing logs**  
  
    Tracing can be enabled from the Tasks pane of the Monitoring Dashboard, or from the command line, which also controls logging levels, keywords, and filters. The resultant Unified Tracing ETL files generated can be read and viewed by using Network Monitor.  
  
### <a name="bkmk_account"></a>Accounting and reporting  
Remote Access servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] can leverage an existing RADIUS server deployment or Windows Internal Database \(WID\) for accounting purposes. Information and historical data for load and server status are available through system Performance Monitor counters, and are stored in the WID accounting store. Whenever any connection is received or disconnected on the Remote Access server, all the remote user statistics \(including the endpoints accessed\) are saved in the accounting store as one session. This allows session details to later be accessed for reporting and auditing purposes.  
  
The accounting and reporting functionality provided in the Remote Access server role includes the ability to measure specific metrics. Available metrics include the number of users connected to a particular DirectAccess server, and total bytes transferred. Administrators can create custom reports to identify traffic and usage patterns, including a history of these patterns.  
  
DirectAccess and RRAS reporting capabilities enable administrators to generate rich usage reports on various statistics such as remote user statistics, server availability and load. The inbox accounting store is leveraged to generate the usage report. Inbox accounting to a local WID database must be enabled to generate usage reports. NPS\/RADIUS accounting cannot be used for generating reports.  
  
The usage report provides a display of usage history including which users established remote connections, what resources they accessed, the total number of unique users, and maximum server load generated. The administrator can select a specific time frame from which to generate the data.  
  
### <a name="bkmk_ike"></a>Site\-to\-site IKEv2 IPsec tunnel mode VPN  
Cross\-premise connectivity is a feature in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that provides the network connectivity to enable service hosting providers to migrate their applications and infrastructure to the cloud. This feature includes a site\-to site Internet Key Exchange version 2 \(IKEv2\) tunnel\-mode VPN connectivity solution and management interface. [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] introduced IKEv2 support in RRAS for VPN connections. An IKEv2 VPN provides resilience to the VPN client when the client moves from one network to another or when it switches from a wireless to a wired connection. The use of IKEv2 and IPsec allows support for strong authentication and encryption methods. RRAS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides added feature enhancements to enable IKEv2 for site\-to\-site VPN connections.  
  
## <a name="bkmk_deprecated"></a>Remote Access Features Deprecated for Future Releases  
Some Routing and Remote Access Service \(RRAS\) features are deprecated starting with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Eventually, these features will be completely removed from RRAS, however they are still available in this operating system. With this information, you can begin planning to employ alternate methods for any application, code, or usage that depends on these features.  
  
The following RRAS features are present in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and are deprecated for subsequent versions of the operating system.  
  
-   **RAS\/ICS NAT Driver**. The Remote Access Service Internet Connection Sharing \(RAS\/ICS\) driver will be replaced by Windows Network Address Translation \(WINNAT\).  
  
-   **RQC\/RQS**. The Network Access Quarantine Control feature is deprecated. For more information about Network Access Quarantine Control in Network Policy Server \(NPS\), see [Network Access Quarantine Control](http://technet.microsoft.com/library/cc733149(v=WS.10).aspx).  
  
-   **Tunnel device types that are unsupported**. This includes every tunnel device type except Dial\-up, Broadband, and Point\-to\-Point Over Ethernet \(PPPOE\).  
  
-   **RIP\/MIB Support**. Routing Information Protocol \(RIP\) and Management Information Base \(MIB\) are deprecated.  
  
## See also  
  
-   [Remote Access Overview](../Topic/Remote-Access-Overview.md)  
  
-   [What's New in RRAS in Windows Server 2008 R2](http://technet.microsoft.com/library/dd469840(v=ws.10).aspx)  
  
-   [What's New in Routing and Remote Access in Windows Server 2008](http://technet.microsoft.com/library/cc730711(v=ws.10).aspx)  
  
-   [DirectAccess in Windows Server](../Topic/DirectAccess-in-Windows-Server.md)  
  
