---
title: Server Manager
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d996ef40-8bcc-42b0-b6ae-806b828223f6
author: coreyp
---
# Server Manager
[!INCLUDE[sm](../Token/sm_md.md)] is a management console in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] that helps IT professionals provision and manage both local and remote Windows\-based servers from their desktops, without requiring either physical access to servers, or the need to enable Remote Desktop protocol \(RDP\) connections to each server. Although [!INCLUDE[sm](../Token/sm_md.md)] is available in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[sm](../Token/sm_md.md)] was updated in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to support remote, multi\-server management, and help increase the number of servers an administrator can manage.  
  
In our tests, [!INCLUDE[sm](../Token/sm_md.md)] in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can be used to manage up to 100 servers, depending on the workloads that the servers are running. The number of servers that you can manage by using a single [!INCLUDE[sm](../Token/sm_md.md)] console can vary depending on the amount of data that you request from managed servers, and hardware and network resources available to the computer running [!INCLUDE[sm](../Token/sm_md.md)]. As the amount of data you want to display approaches that computer’s resource capacity, you can experience slow responses from [!INCLUDE[sm](../Token/sm_md.md)], and delays in the completion of refreshes. To help increase the number of servers that you can manage by using [!INCLUDE[sm](../Token/sm_md.md)], we recommend limiting the event data that [!INCLUDE[sm](../Token/sm_md.md)] gets from your managed servers, by using settings in the **Configure Event Data** dialog box. Configure Event Data can be opened from the **Tasks** menu in the **Events** tile. If you need to manage an enterprise\-level number of servers in your organization, we recommend evaluating products in the [Microsoft® System Center suite](http://go.microsoft.com/fwlink/p/?LinkId=239437).  
  
This topic and its subtopics provide information about how to use features in the [!INCLUDE[sm](../Token/sm_md.md)] console. This topic contains the following sections.  
  
-   [Review initial considerations and system requirements](#BKMK_1.1)  
  
-   [Tasks that you can perform in Server Manager](#BKMK_tasks)  
  
-   [Start Server Manager](#BKMK_start)  
  
-   [Restart remote servers](#BKMK_restart)  
  
-   [Export Server Manager settings to other computers](#BKMK_export)  
  
## <a name="BKMK_1.1"></a>Review initial considerations and system requirements  
The following sections list some initial considerations that you need to review, as well as hardware and software requirements for [!INCLUDE[sm](../Token/sm_md.md)].  
  
### Hardware requirements  
[!INCLUDE[sm](../Token/sm_md.md)] is installed by default with all editions of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]. No additional hardware requirements exist for [!INCLUDE[sm](../Token/sm_md.md)].  
  
### <a name="BKMK_softconfig"></a>Software and configuration requirements  
[!INCLUDE[sm](../Token/sm_md.md)] is installed by default with all editions of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]. You can use [!INCLUDE[sm](../Token/sm_md.md)] in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] to manage [Server Core installation options](http://go.microsoft.com/fwlink/p/?LinkID=241573) of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] that are running on remote computers. [!INCLUDE[sm](../Token/sm_md.md)] does run on the Server Core installation option of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
[!INCLUDE[sm](../Token/sm_md.md)] runs in the Minimal Server Graphical Interface; that is, when the Server Graphical Shell feature is not installed. The Server Graphical Shell feature is not installed by default on [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]. If you are not running Server Graphical Shell, the [!INCLUDE[sm](../Token/sm_md.md)] console runs, but some applications or tools available from the console are not available. Internet browsers cannot run without Server Graphical Shell, so webpages and applications such as HTML Help \(The MMC F1 Help, for example\) cannot be opened. You cannot open dialog boxes for configuring Windows automatic updating and feedback when Server Graphical Shell is not installed; commands that open these dialog boxes in the [!INCLUDE[sm](../Token/sm_md.md)] console are redirected to run **sconfig.cmd**.  
  
To manage servers that are running Windows Server releases older than [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], install the following software and updates to make the older releases of Windows Server manageable by using [!INCLUDE[sm](../Token/sm_md.md)] in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
|Operating System|Required Software|  
|--------------------|---------------------|  
|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|-   [.NET Framework 4.6](http://www.microsoft.com/download/details.aspx?id=45497)<br />-   [Windows Management Framework 5.0](http://go.microsoft.com/fwlink/?LinkID=395058). The Windows Management Framework 5.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The updated WMI providers let [!INCLUDE[sm](../Token/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) is no longer necessary on servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].|  
|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|-   [.NET Framework 4.5](http://www.microsoft.com/download/details.aspx?id=30653)<br />-   [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881). The Windows Management Framework 4.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. The updated WMI providers let [!INCLUDE[sm](../Token/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets [!INCLUDE[sm](../Token/sm_md.md)] collect performance data from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|-   [.NET Framework 4](http://www.microsoft.com/download/en/details.aspx?id=17718)<br />-   [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/p/?LinkID=229019) The Windows Management Framework 3.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. The updated WMI providers let [!INCLUDE[sm](../Token/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] have a manageability status of **Not accessible – Verify earlier versions run Windows Management Framework 3.0**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets [!INCLUDE[sm](../Token/sm_md.md)] collect performance data from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].|  
  
#### Manage remote computers from a client computer  
The [!INCLUDE[sm](../Token/sm_md.md)] console is included with [Remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=404281) for [!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)]. Note that when Remote Server Administration Tools is installed on a client computer, you cannot manage the local computer by using [!INCLUDE[sm](../Token/sm_md.md)]; [!INCLUDE[sm](../Token/sm_md.md)] cannot be used to manage computers or devices that are running a Windows client operating system. You can only use [!INCLUDE[sm](../Token/sm_md.md)] to manage Windows\-based servers.  
  
|[!INCLUDE[sm](../Token/sm_md.md)] Source Operating System|Targeted at [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|Targeted at [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Targeted at [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|Targeted at [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|Targeted at Windows Server 2003|  
|-------------------------------------------------------------|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|  
|[!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] or [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|Full support|Full support|Full support|After [Software and configuration requirements](#BKMK_softconfig) are satisfied, can perform most management tasks, but no role or feature installation or uninstallation|Not supported|  
|[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Not supported|Full support|Full support|After [Software and configuration requirements](#BKMK_softconfig) are satisfied, can perform most management tasks, but no role or feature installation or uninstallation|Limited support; online and offline status only|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|Not supported|Not supported|Full support|After [Software and configuration requirements](#BKMK_softconfig) are satisfied, can perform most management tasks, but no role or feature installation or uninstallation|Limited support; online and offline status only|  
  
###### To start Server Manager on a client computer  
  
1.  Follow instructions in [Remote Server Administration Tools](../Topic/Remote-Server-Administration-Tools.md) to install Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)].  
  
2.  On the **Start** screen, click **Server Manager**. The **Server Manager** tile is available after you install Remote Server Administration Tools.  
  
3.  If neither the **Administrative Tools** nor the **Server Manager** tiles are displayed on the **Start** screen after installing Remote Server Administration Tools, and searching for [!INCLUDE[sm](../Token/sm_md.md)] on the **Start** screen does not display results, verify that the **Show administrative tools** setting is turned on. To view this setting, hover the mouse cursor over the upper right corner of the **Start** screen, and then click **Settings**. If **Show administrative tools** is turned off, turn the setting on to display tools that you have installed as part of Remote Server Administration Tools.  
  
For more information about running Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] to manage remote servers, see [Remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=221055) on the TechNet Wiki.  
  
#### Configure remote management on servers that you want to manage  
  
> [!IMPORTANT]  
> By default, [!INCLUDE[sm](../Token/sm_md.md)] and [!INCLUDE[wps_2](../Token/wps_2_md.md)] remote management is enabled in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
To perform management tasks on remote servers by using [!INCLUDE[sm](../Token/sm_md.md)], remote servers that you want to manage must be configured to allow remote management by using [!INCLUDE[sm](../Token/sm_md.md)] and [!INCLUDE[wps_2](../Token/wps_2_md.md)]. If remote management has been disabled on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and you want to enable it again, perform the following steps.  
  
##### <a name="BKMK_windows"></a>To configure Server Manager remote management on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using the Windows interface  
  
1.  > [!NOTE]  
    > The settings that are controlled by the **Configure Remote Management** dialog box do not affect parts of [!INCLUDE[sm](../Token/sm_md.md)] that use DCOM for remote communications.  
  
    Do one of the following to open [!INCLUDE[sm](../Token/sm_md.md)] if it is not already open.  
  
    -   On the Windows taskbar, click the [!INCLUDE[sm](../Token/sm_md.md)] button.  
  
    -   On the **Start** screen, click **Server Manager**.  
  
2.  In the **Properties** area of the **Local Servers** page, click the hyperlinked value for the **Remote management** property.  
  
3.  Do one of the following, and then click **OK**.  
  
    -   To prevent this computer from being managed remotely by using [!INCLUDE[sm](../Token/sm_md.md)] \(or [!INCLUDE[wps_2](../Token/wps_2_md.md)] if it is installed\), clear the **Enable remote management of this server from other computers** check box.  
  
    -   To let this computer be managed remotely by using [!INCLUDE[sm](../Token/sm_md.md)] or [!INCLUDE[wps_2](../Token/wps_2_md.md)], select **Enable remote management of this server from other computers**.  
  
##### <a name="BKMK_ps"></a>To enable Server Manager remote management on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using Windows PowerShell  
  
1.  Do one of the following.  
  
    -   To run [!INCLUDE[wps_2](../Token/wps_2_md.md)] as an administrator from the **Start** screen, right\-click the **Windows PowerShell** tile, and then click **Run as Administrator**.  
  
    -   To run [!INCLUDE[wps_2](../Token/wps_2_md.md)] as an administrator from the desktop, right\-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.  
  
2.  Type the following, and then press **Enter** to enable all required firewall rule exceptions.  
  
    **Configure\-SMRemoting.exe \-Enable**  
  
    > [!NOTE]  
    > This command also works in a command prompt that has been opened with elevated user rights \(Run as Administrator\).  
  
    If enabling remote management fails, see [about_Remote_Troubleshooting](http://go.microsoft.com/fwlink/p/?LinkID=135188) on Microsoft TechNet for troubleshooting tips and best practices.  
  
###### To enable Server Manager and Windows PowerShell remote management on older operating systems  
  
-   Do one of the following.  
  
    -   To enable remote management on servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Remote Management with Server Manager](http://go.microsoft.com/fwlink/?LinkID=137378) in the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Help.  
  
    -   To enable remote management on servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see [Enable and Use Remote Commands in Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=242565).  
  
## <a name="BKMK_tasks"></a>Tasks that you can perform in Server Manager  
[!INCLUDE[sm](../Token/sm_md.md)] makes server administration more efficient by allowing administrators to do tasks in the following table by using a single tool. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both standard users of a server and members of the Administrators group can perform management tasks in [!INCLUDE[sm](../Token/sm_md.md)], but by default, standard users are prevented from performing some tasks, as shown in the following table.  
  
Administrators can use two [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets in the [!INCLUDE[sm](../Token/sm_md.md)] cmdlet module, [Enable-ServerManagerStandardUserRemoting](http://technet.microsoft.com/library/jj205470.aspx) and [Disable-ServerManagerStandardUserRemoting](http://technet.microsoft.com/library/jj205468.aspx), to further control standard user access to some additional data. The **Enable\-ServerManagerStandardUserRemoting** cmdlet can provide one or more standard, non\-Administrator users access to event, service, performance counter, and role and feature inventory data.  
  
> [!IMPORTANT]  
> [!INCLUDE[sm](../Token/sm_md.md)] cannot be used to manage a newer release of the Windows Server operating system. [!INCLUDE[sm](../Token/sm_md.md)] running on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] cannot be used to manage servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
|Task Description|Administrators \(including the built\-in Administrator account\)|Standard Server Users|  
|--------------------|--------------------------------------------------------------------|-------------------------|  
|Add remote servers to a pool of servers that [!INCLUDE[sm](../Token/sm_md.md)] can be used to manage.|Yes|No|  
|Create and edit custom groups of servers, such as servers that are in a specific geographic location or serve a specific purpose.|Yes|Yes|  
|Install or uninstall [!INCLUDE[rrsandf_plural](../Token/rrsandf_plural_md.md)] on the local or on remote servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For definitions of [!INCLUDE[rrsandf_plural](../Token/rrsandf_plural_md.md)], see [Roles, Role Services, and Features](http://go.microsoft.com/fwlink/p/?LinkId=239558).|Yes|No|  
|View and make changes to server roles and features that are installed on either local or remote servers. **Note:** In [!INCLUDE[sm](../Token/sm_md.md)], role and feature data is displayed in the base language of the system, also called the system default GUI language, or the language selected during installation of the operating system.|Yes|Standard users can view and manage roles and features, and perform tasks such as viewing role events, but cannot add or remove role services.|  
|Start management tools such as [!INCLUDE[wps_2](../Token/wps_2_md.md)] or MMC snap\-ins. You can start a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session targeted at a remote server by right\-clicking the server in the **Servers** tile, and then clicking **Windows PowerShell**. You can start MMC snap\-ins from the **Tools** menu of the [!INCLUDE[sm](../Token/sm_md.md)] console, and then point the MMC toward a remote computer after the snap\-in is open.|Yes|Yes|  
|Manage remote servers with different credentials by right\-clicking a server in the **Servers** tile, and then clicking **Manage As**. You can use **Manage As** for general server and File and Storage Services management tasks.|Yes|No|  
|Perform management tasks associated with the operational lifecycle of servers, such as starting or stopping services; and start other tools that allow you to configure a server’s network settings, users and groups, and Remote Desktop connections.|Yes|Standard users cannot start or stop services. They can change the local server’s name, workgroup, or domain membership and Remote Desktop settings, but are prompted by User Account Control to provide Administrator credentials before they can complete these tasks. They cannot change remote management settings.|  
|Perform management tasks associated with the operational lifecycle of roles that are installed on servers, including scanning roles for compliance with best practices.|Yes|Standard users cannot run [!INCLUDE[bpa](../Token/bpa_md.md)] scans.|  
|Determine server status, identify critical events, and analyze and troubleshoot configuration issues or failures.|Yes|Yes|  
|Customize the events, performance data, services, and [!INCLUDE[bpa](../Token/bpa_md.md)] results about which you want to be alerted on the [!INCLUDE[sm](../Token/sm_md.md)] dashboard.|Yes|Yes|  
|Restart servers.|Yes|No|  
|Refresh data that is displayed in the [!INCLUDE[sm](../Token/sm_md.md)] console about managed servers.|Yes|No|  
  
> [!NOTE]  
> [!INCLUDE[sm](../Token/sm_md.md)] cannot be used to add roles and features to servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
## <a name="BKMK_start"></a>Start Server Manager  
[!INCLUDE[sm](../Token/sm_md.md)] starts automatically by default on servers that are running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)] when a member of the Administrators group logs on to a server. If you close [!INCLUDE[sm](../Token/sm_md.md)], restart it in one of the following ways. This section also contains steps for changing the default behavior, and preventing [!INCLUDE[sm](../Token/sm_md.md)] from starting automatically.  
  
#### To start Server Manager from the Start screen  
  
-   On the Windows **Start** screen, click the **Server Manager** tile.  
  
#### To start Server Manager from the Windows desktop  
  
-   On the Windows taskbar, click **Server Manager**.  
  
#### To prevent Server Manager from starting automatically  
  
1.  In the [!INCLUDE[sm](../Token/sm_md.md)] console, on the **Manage** menu, click **Server Manager Properties**.  
  
2.  In the **Server Manager Properties** dialog box, fill the check box for **Do not start Server Manager automatically at logon**. Click **OK**.  
  
3.  Alternatively, you can prevent [!INCLUDE[sm](../Token/sm_md.md)] from starting automatically by enabling the Group Policy setting, **Do not start Server Manager automatically at logon**. The path to this policy setting, in the Local Group Policy Editor console, is Computer Configuration\\Administrative Templates\\System\\Server Manager.  
  
## <a name="BKMK_restart"></a>Restart remote servers  
You can restart a remote server from the **Servers** tile of a role or group page in [!INCLUDE[sm](../Token/sm_md.md)].  
  
> [!IMPORTANT]  
> Restarting a remote server forces the server to restart, even if users are still logged on to the remote server, and even if programs with unsaved data are still open. This behavior is different from shutting down or restarting the local computer, on which you would be prompted to save unsaved program data, and verify that you wanted to force logged\-on users to log off. Be sure that you can force other users to log off of remote servers, and that you can discard unsaved data in programs that are running on the remote servers.  
>   
> If an automatic refresh occurs in [!INCLUDE[sm](../Token/sm_md.md)] while a managed server is shutting down and restarting, refresh and manageability status errors can occur for the managed server, because [!INCLUDE[sm](../Token/sm_md.md)] cannot connect to the remote server until it is finished restarting.  
  
#### To restart remote servers in Server Manager  
  
1.  Open a role or server group home page in [!INCLUDE[sm](../Token/sm_md.md)].  
  
2.  Select one or more remote servers that you have added to [!INCLUDE[sm](../Token/sm_md.md)]. Press and hold **Ctrl** as you click to select multiple servers at one time. For more information about how to add servers to the [!INCLUDE[sm](../Token/sm_md.md)] server pool, see [Add Servers to Server Manager](assetId:///3d6065bd-a189-4726-b36b-50892c6f02e2).  
  
3.  Right\-click selected servers, and then click **Restart Server**.  
  
## <a name="BKMK_export"></a>Export Server Manager settings to other computers  
In [!INCLUDE[sm](../Token/sm_md.md)], your list of managed servers, changes to [!INCLUDE[sm](../Token/sm_md.md)] console settings, and custom groups that you have created are stored in the following two files. You can reuse these settings on other computers that are running the same release of [!INCLUDE[sm](../Token/sm_md.md)] \(or [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] with Remote Server Administration Tools installed\). Remote Server Administration Tools must be running on Windows client\-based computers to export [!INCLUDE[sm](../Token/sm_md.md)] settings to those computers.  
  
-   %*appdata*%\\Microsoft\\Windows\\ServerManager\\ServerList.xml  
  
-   %*appdata*%\\Local\\Microsoft\_Corporation\\ServerManager.exe\_StrongName\_*GUID*\\6.2.0.0\\user.config  
  
> [!NOTE]  
> -   Manage As \(or alternate\) credentials for servers in your server pool are not stored in the roaming profile. [!INCLUDE[sm](../Token/sm_md.md)] users must add them on each computer from which they want to manage.  
> -   The network share roaming profile is not created until a user logs on to the network, and then logs off for the first time. The **Serverlist.xml** file is created at this time.  
  
You can export [!INCLUDE[sm](../Token/sm_md.md)] settings, make [!INCLUDE[sm](../Token/sm_md.md)] settings portable, or use them on other computers in one of the following two ways.  
  
-   To export settings to another domain\-joined computer, configure the [!INCLUDE[sm](../Token/sm_md.md)] user to have a roaming profile in Active Directory Users and Computers. You must be a Domain Administrator to change user properties in Active Directory Users and Computers.  
  
-   To export settings to another computer in a workgroup, copy the preceding two files to the same location on the computer from which you want to manage by using [!INCLUDE[sm](../Token/sm_md.md)].  
  
#### To export Server Manager settings to other domain\-joined computers  
  
1.  In Active Directory Users and Computers, open the **Properties** dialog box for a [!INCLUDE[sm](../Token/sm_md.md)] user.  
  
2.  On the **Profile** tab, add a path to a network share to store the user’s profile.  
  
3.  Do one of the following.  
  
    -   On U.S. English \(en\-us\) builds, changes to the **ServerList.xml** file are automatically saved to the profile. Go on to the next step.  
  
    -   On other builds, copy the following two files from the computer that is running [!INCLUDE[sm](../Token/sm_md.md)] to the network share that is part of the user’s roaming profile.  
  
        -   %*appdata*%\\Microsoft\\Windows\\ServerManager\\ServerList.xml  
  
        -   %*localappdata*%\\Microsoft\_Corporation\\ServerManager.exe\_StrongName\_*GUID*\\6.2.0.0\\user.config  
  
4.  Click **OK** to save your changes and close the **Properties** dialog box.  
  
#### To export Server Manager settings to computers in workgroups  
  
-   On a computer from which you want to manage remote servers, overwrite the following two files with the same files from another computer that is running [!INCLUDE[sm](../Token/sm_md.md)], and that has the settings you want.  
  
    -   %*appdata*%\\Microsoft\\Windows\\ServerManager\\ServerList.xml  
  
    -   %*localappdata*%\\Microsoft\_Corporation\\ServerManager.exe\_StrongName\_*GUID*\\6.2.0.0\\user.config  
  
