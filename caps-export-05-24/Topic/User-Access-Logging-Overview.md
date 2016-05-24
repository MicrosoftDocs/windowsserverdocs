---
title: User Access Logging Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c395b8b-3b35-4042-b9cc-07e438f86d50
author: jaimeo
---
# User Access Logging Overview
This technical overview describes User Access Logging \(UAL\), a feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that aggregates client usage data by role and products on a local server.  
  
**Did you mean…**  
  
-   [Microsoft Assessment and Planning Toolkit](http://www.microsoft.com/download/en/details.aspx?id=7826)  
  
-   [Volume Activation Overview](../Topic/Volume-Activation-Overview.md)  
  
-   [Volume Activation Management Tool](http://blogs.technet.com/b/volume-licensing/)  
  
## <a name="BKMK_OVER"></a>Feature description  
User Access Logging \(UAL\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is a feature to help server administrators quantify requests from client computers for roles and services on a local server.  
  
UAL is installed and enabled by default in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and collects data in nearly real\-time. No administrator configuration is required, although UAL can be disabled or enabled. For more information, see [Manage User Access Logging](../Topic/Manage-User-Access-Logging.md).T he User Access Logging service aggregates client usage data by roles and products into local database files.  IT administrators can later use Windows Management Instrumentation \(WMI\) or Windows PowerShell cmdlets to retrieve quantities and instances by server role \(or software product\), by user, by device, by the local server, and by date.  
  
> [!NOTE]  
> UAL supports the [Microsoft Assessment and Planning Toolkit](http://go.microsoft.com/fwlink/?LinkID=111000).  
  
## <a name="BKMK_APP"></a>Practical applications  
UAL aggregates unique client device and user request events that are logged on a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] into a local database. These records are then made available \(through a query by a server administrator\) to retrieve quantities and instances by server role, by user, by device, by the local server, and by date.  In addition, UAL has been extended to enable non\-Microsoft software developers to instrument their UAL events to be aggregated by [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
This information can be useful to server administrators at all levels. UAL can assist server administrators in performing the following tasks:  
  
-   Quantify client user requests for local physical or virtual servers.  
  
-   Quantify client user requests for installed software products on a local physical or virtual server.  
  
-   Retrieve data on a local server running Hyper\-V to identify periods of high and low demand on a Hyper\-V virtual computer.  
  
-   Retrieve UAL data from multiple remote servers.  
  
In addition, software developers can instrument UAL events that can then be aggregated by [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and retrieved by using WMI and Windows PowerShell interfaces.  
  
The following server roles and services can be supported by UAL:  
  
-   Active Directory Certificate Services \(AD CS\)  
  
-   Active Directory Rights Management Services \(AD RMS\)  
  
-   BranchCache  
  
-   Domain Name System \(DNS\)  
  
    > [!NOTE]  
    > UAL collects DNS data every 24 hours, and there is a separate UAL cmdlet for this scenario.  
  
-   Dynamic Host Configuration Protocol \(DHCP\)  
  
-   Fax Server  
  
-   File Services  
  
-   File Transfer Protocol \(FTP\) Server  
  
-   Hyper\-V  
  
    > [!NOTE]  
    > UAL collects Hyper\-V data every 24 hours, and there is a separate UAL cmdlet for this scenario.  
  
-   Web Server \(IIS\)  
  
    > [!WARNING]  
    > To use UAL with IIS, you must use iisual.exe. For more information, see [Analyzing Client Usage Data with IIS User Access Logging](http://www.iis.net/learn/manage/configuring-security/analyzing-client-usage-data-with-iis-user-access-logging).  
  
-   Microsoft Message Queue \(MSMQ\) Services  
  
-   Network Policy and Access Services  
  
-   Print and Document Services  
  
-   Routing and Remote Access Service \(RRAS\)  
  
-   Windows Deployment Services \(WDS\)  
  
-   Windows Server Update Services \(WSUS\)  
  
> [!IMPORTANT]  
> UAL is not recommended for use on servers that are connected directly to the Internet, such as web servers on an Internet\-accessible address space, or in scenarios where extremely high performance is the primary function of the server \(such as in HPC workload environments\). UAL is primarily intended for small, medium, and enterprise intranet scenarios where high volume is expected, but not as high as many deployments of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that serve Internet\-facing traffic volume on a regular basis.  
  
## <a name="BKMK_NEW"></a>Important functionality  
The following table describes key functions of UAL and their potential value.  
  
|Functionality|Value|  
|-----------------|---------|  
|Collect and aggregate client request event data in near real\-time.|Up to three years of data can be saved. **Important:** Administrators need to enforce compliance of the data collected and data retention periods with the organization’s privacy policy and local regulations.|  
|Query UAL by using WMI or Windows PowerShell interfaces to retrieve client request data on a local or remote server.|UAL enables a single view of ongoing usage data. Server and enterprise administrators can retrieve this data and coordinate with business administrators to optimize use of their volume software licenses.|  
|Enabled by default.|Server administrators do not need to configure or otherwise set up this feature for all core functionality to be available and working.|  
  
## Data logged with UAL  
The following user\-related data is logged with UAL.  
  
|Data|Description|  
|--------|---------------|  
|**UserName**|The user name on the client that accompanies the UAL entries from installed roles and products, if applicable.|  
|**ActivityCount**|The number of times a particular user accessed a role or service.|  
|**FirstSeen**|The date and time when a user first accesses a role or service.|  
|**LastSeen**|The date and time when a user last accessed a role or service.|  
|**ProductName**|The name of the software parent product, such as Windows, that is providing UAL data.|  
|**RoleGUID**|The UAL assigned or registered GUID that represents the server role or installed product.|  
|**RoleName**|The name of the role, component, or subproduct that is providing UAL data. This is also associated with a ProductName and a RoleGUID.|  
|**TenantIdentifier**|A unique GUID for a tenant client of an installed role or product that accompanies the UAL data, if applicable.|  
  
The following device\-related data is logged with UAL.  
  
|Data|Description|  
|--------|---------------|  
|**IPAddress**|The IP address of a client device that is used to access a role or service.|  
|**ActivityCount**|The number of times a particular device accessed the role or service.|  
|**FirstSeen**|The date and time when an IP address was first used to access a role or service.|  
|**LastSeen**|The date and time when an IP address was last used to access a role or service.|  
|**ProductName**|The name of the software parent product, such as Windows, that is providing UAL data.|  
|**RoleGUID**|The UAL\-assigned or registered GUID that represents the server role or installed product.|  
|**RoleName**|The name of the role, component, or subproduct that is providing UAL data. This is also associated with a ProductName and a RoleGUID.|  
|**TenantIdentifier**|A unique GUID for a tenant client of an installed role or product that accompanies the UAL data, if applicable.|  
  
## <a name="BKMK_SOFT"></a>Software requirements  
UAL can be used on any computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## See also  
[User Access Logging](http://msdn.microsoft.com/library/windows/desktop/hh437528(v=vs.85).aspx) on MSDN.  
  
[Manage User Access Logging](../Topic/Manage-User-Access-Logging.md)  
  
