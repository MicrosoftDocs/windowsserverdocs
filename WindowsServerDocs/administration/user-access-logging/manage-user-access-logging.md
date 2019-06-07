---
title: Manage User Access Logging
description: Describes how to manage User Access Logging
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: manage-user-access-logging
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f039017-4152-47eb-838e-bb6ef730b638
author: brentfor
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Manage User Access Logging

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This document describes how to manage User Access Logging (UAL).  
  
UAL is a feature that can help server administrators quantify the number of unique client requests of roles and services on a local server.  
  
UAL is installed and enabled by default and collects data on a nearly real-time basis. There are only a few configuration options for UAL. This document describes these options and their intended purpose.  
  
To learn more about the benefits of UAL, see the [Get Started with User Access Logging](get-started-with-user-access-logging.md).  
  
**In this document**  
  
The configuration options covered in this document include:  
  
-   Disabling and enabling the UAL service  
  
-   Collecting and removing data  
  
-   Deleting data logged by UAL  
  
-   Managing UAL in high volume environments  
  
-   Recovering from a corrupt state  
  
-   Enable Work Folders usage license tracking   
  
## <a name="BKMK_Step1"></a>Disabling and enabling the UAL service  
UAL is enabled and runs by default when a computer running Windows Server 2012, or later, is installed and started for the first time. Administrators may want to turn off and disable UAL to comply with privacy requirements or other operational needs. You can turn off UAL using the Services console, from the command line, or by using PowerShell cmdlets. However, to ensure that UAL does not run again the next time the computer is started, you also need to disable the service. The following procedures describes how to turn off and disable UAL.  
  
> [!NOTE]  
> You can use the `Get-Service UALSVC` PowerShell cmdlet to retrieve information about the UAL Service including whether it is running or stopped and whether it is enabled or disabled.  
  
#### To stop and disable the UAL service by using the Services console  
  
1.  Sign in to the server with an account that has local administrator privileges.  
  
2.  In Server Manager, point to **Tools**, and then click **Services**.  
  
3.  Scroll down and select **User Access Logging Service**.Click **Stop the service**.  
  
4.  Right\-click the service name and select **Properties**. On the **General** tab, change the **Startup type** to **Disabled**, and then click **OK**.  
  
#### To stop and disable UAL from the command line  
  
1.  Sign in to the server with an account that has local administrator privileges.  
  
2.  Press the Windows logo + R, then type **cmd** to open a Command Prompt window.  
  
    > [!IMPORTANT]  
    > If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
3.  Type **net stop ualsvc**, and then press ENTER.  
  
4.  Type **netsh ualsvc set opmode mode=disable**, and then press ENTER.  
   
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  

You can also stop and disable UAL by using the Stop-service and Disable-Ual Windows PowerShell commands.  
  
```  
Stop-service ualsvc  
```  
  
```  
Disable-ual  
```  
  
If at a later date you want to restart and re-enable UAL you can do so with the following procedures.  
  
#### To start and enable the UAL service by using the Services console  
  
1.  Sign in to the server an account that has local administrator privileges.  
  
2.  In Server Manager, point to **Tools**, and then click **Services**.  
  
3.  Scroll down and select **User Access Logging Service**.Click **Start the service**.  
  
4.  Right-click the service name and select **Properties**. On the **General** tab, change the **Startup type** to **Automatic**, and then click **OK**.  
  
#### To start and enable UAL from the command line  
  
1.  Sign in to the server with local administrator credentials.  
  
2.  Press the Windows logo + R, then type **cmd** to open a Command Prompt window.  
  
    > [!IMPORTANT]  
    > If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
3.  Type **net start ualsvc**, and then press ENTER.  
  
4.  Type **netsh ualsvc set opmode mode=enable**, and then press ENTER.  

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.
  
You can also start and reenable UAL by using the Start-service and Enable-Ual Windows PowerShell commands.  
  
```  
Enable-ual  
```  
  
```  
Start-service ualsvc  
```  
  
## <a name="BKMK_Step2"></a>Collecting UAL data  
In addition to the PowerShell cmdlets described in the previous section, 12 additional cmdlets can be used to collect UAL data:  
  
-   **Get-UalOverview**: Provides UAL related details and history of installed products and roles.  
  
-   **Get-UalServerUser**: Provides client user access data for the local or targeted server.  
  
-   **Get-UalServerDevice**: Provides client device access data for the local or targeted server.  
  
-   **Get-UalUserAccess**: Provides client user access data for each role or product installed on the local or targeted server.  
  
-   **Get-UalDeviceAccess**: Provides client device access data for each role or product installed on the local or targeted server.  
  
-   **Get-UalDailyUserAccess**: Provides client user access data for each day of the year.  
  
-   **Get-UalDailyDeviceAccess**: Provides client device access data for each day of the year.  
  
-   **Get-UalDailyAccess**: Provides both client device and user access data for each day of the year.  
  
-   **Get-UalHyperV**: Provides virtual machine data relevant to the local or targeted server.  
  
-   **Get-UalDns**: Provides DNS client specific data of the local or targeted DNS server.  
  
-   **Get-UalSystemId**: Provides system specific data to uniquely identify the local or targeted server.  
  
`Get-UalSystemId` is meant to provide a unique profile of a server for all other data from that server to be correlated with.  If a server experiences any change in the in one of the parameters of `Get-UalSystemId` a new profile is created.  `Get-UalOverview` is meant to provide the administrator with a list of roles installed and being used on the server.  
  
> [!NOTE]  
> Basic features of Print and Document Services and File Services are installed by default. Therefore administrators can expect to always see information on these displayed as if the full roles are installed. Separate UAL cmdlets are included for Hyper-V and DNS because of the unique data that UAL collects for these server roles.  
  
A typical use case scenario for UAL cmdlets would be for an administrator to query UAL for unique client accesses over the course of a date range. This can be done in a variety of ways. The following is a recommended method to query unique device accesses over a date range.  
  
```  
PS C:\Windows\system32>Gwmi -Namespace "root\AccessLogging" -query "SELECT * FROM MsftUal_DeviceAccess WHERE LastSeen >='1/01/2013' and LastSeen <='3/31/2013'"  
  
```  
  
This will return a verbose listing of all unique client devices, by IP address, that have made requests of the server in that date range.  
  
‘ActivityCount’ for each unique client is limited to 65,535 per day. Also, calling into WMI from PowerShell is only required when you query by date.  All other UAL cmdlet parameters can be used within PS queries as expected, as in the following example:  
  
```  
PS C:\Windows\system32> Get-UalDeviceAccess -IPAddress "10.36.206.112"  
  
ActivityCount    : 1  
FirstSeen        : 6/23/2012 5:06:50 AM  
IPAddress        : 10.36.206.112  
LastSeen         : 6/23/2012 5:06:50 AM  
ProductName      : Windows Server 2012 Datacenter  
RoleGuid         : 10a9226f-50ee-49d8-a393-9a501d47ce04  
RoleName         : File Server  
TenantIdentifier : 00000000-0000-0000-0000-000000000000  
PSComputerName  
  
```  
  
UAL retains up to two years’ worth of history. To allow retrieval of UAL data by an administrator when the service is running, UAL makes a copy of the active database file, current.mdb, to a file named *GUID.mdb* every 24 hours for the WMI provider’s use.  
  
On the first day of the year, UAL will create a new *GUID.mdb*. The old *GUID.mdb* is retained as an archive for the provider’s use.  After two years, the original *GUID.mdb* will be overwritten.  
  
> [!IMPORTANT]  
> The following procedure should be performed only by an advanced user and would commonly be used by a developer testing their own instrumentation of UAL application programming interfaces...  
  
#### To adjust the default 24-hour interval to make data visible to the WMI provider  
  
1.  Sign in to the server with an account that has local administrator privileges.  
  
2.  Press the Windows logo + R, then type **cmd** to open a Command Prompt window.  
  
3.  Add the registry value:  **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\WMI\AutoLogger\Sum\PollingInterval (REG_DWORD)**.  
  
    > [!WARNING]  
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on your computer.  
  
    The following example shows how to add a two-minute interval (not recommended as a long term running state): **REG ADD HKLM\System\CurrentControlSet\Control\WMI\\AutoLogger\Sum /v PollingInterval /t REG\_DWORD /d 120000 /F**  
  
    Time values are in milliseconds. The minimum value is 60 seconds, the maximum is seven days, and the default is 24 hours.  
  
4.  Use the Services console to stop and restart the User Access Logging Service.  
  
## Deleting data logged by UAL  
UAL is not intended to be a mission critical component. Its design is intended to impact local system operations as little as possible while maintaining a high level of reliability. This also allows the administrator to manually delete UAL database and supporting files (every file in \Windows\System32\LogFilesSUM\ directory) to meet operational needs.  
  
#### To delete data logged by UAL  
  
1. Stop the User Access Logging Service.  
  
2. Open Windows Explorer.  
  
3. Go to **\Windows\System32\Logfiles\SUM\\**.  
  
4. Delete all files in the folder.  
  
## Managing UAL in high volume environments  
This section describes what an administrator can expect when UAL is used on a server with high client volume:  
  
The maximum number of accesses that can be recorded with UAL is 65,535 per day.  UAL is not recommended for use on servers that are connected directly to the Internet, such as web servers that are connected directly to the Internet, or in scenarios where extremely high performance is the primary function of the server (such as in HPC workload environments). UAL is primarily intended for small, medium, and enterprise intranet scenarios where high volume is expected, but not as high as many deployment that serve Internet-facing traffic volume on a regular basis.  
  
**UAL in Memory**: Because UAL uses the Extensible Storage Engine (ESE), UAL’s memory requirements will increase over time (or by quantity of client requests). But memory will be relinquished as the system requires it to minimize impact on system performance.  
  
**UAL on Disk**: UAL’s hard disk requirements are approximately as shown below:  
  
-   0 unique client records: 22M  
  
-   50,000 unique client records: 80 M  
  
-   500,000 unique client records: 384M  
  
-   1,000,000 unique client records: 729M  
  
## Recovering from a corrupt state  
This section discusses UAL’s use of the Extensible Storage Engine (ESE) at a high level and what an administrator can do if UAL data is corrupted or unrecoverable.  
  
UAL uses ESE to optimize use of system resources and for its resistance to corruption.  For more information about the benefits of ESE, see [Extensible Storage Engine](https://msdn.microsoft.com/library/windows/desktop/gg269259(v=exchg.10).aspx) on MSDN.  
  
Each time the UAL service starts ESE performs a soft recovery. For more information, see [Extensible Storage Engine Files](https://msdn.microsoft.com/library/windows/desktop/gg294069(v=exchg.10).aspx) on MSDN.  
  
If there is a problem with the soft recovery, ESE will perform a crash recovery. For more information, see [JetInit Function](https://msdn.microsoft.com/library/windows/desktop/gg294068(v=exchg.10).aspx) on MSDN.  
  
If UAL is still unable to start with the existing set of ESE files, it will delete all files in the \Windows\System32\LogFiles\SUM\ directory. After these files are deleted, the User Access Logging Service will restart and new files are created. The UAL service will then resume as if on a freshly installed computer.  
  
> [!IMPORTANT]  
> The files in UAL database directory should never be moved or modified. Doing so will initiate the recovery steps, including the cleanup routine described in this section. If backups of the\Windows\System32\LogFiles\SUM\ directory are needed, then every file in this directory must be backed up together in order for a restore operation to function as expected.  
  
## Enable Work Folders usage license tracking  
Work Folders server can use UAL to report client usage. Unlike UAL, Work Folder logging is not turned on by default. You can enable it with the following regkey change:  
  
```  
Reg add HKLM\Software\Microsoft\Windows\CurrentVersion\SyncShareSrv /v EnableWorkFoldersUAL /t REG_DWORD /d 1  
```  
  
After the regkey is added, you must restart the SyncShareSvc service on the server, to enable logging.  
  
After logging is enabled, 2 informational events get logged to the Windows Logs\Application channel each time a client connects to the server. For Work Folders, each user may have one or more client devices that connect to the server and check for data updates every 10 minutes. If the server is experiencing 1000 users, each with 2 devices the application logs will overwrite every 70 minutes, making troubleshooting unrelated issues difficult. To avoid this, you can disable the User Access Logging service temporarily, or increase the size of the server’s Windows Logs\Application channel.  
  
## <a name="BKMK_Links"></a>See also  

- [Get Started with User Access Logging](get-started-with-user-access-logging.md)
  

