---
title: Manage Multiple, remote Servers with Server Manager
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3a17e686-e7f2-47e2-b7af-733777c38b5f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Manage Multiple, remote Servers with Server Manager

>Applies To: Windows Server 2016

Server Manager is a management console in Windows Server 2012 R2 and Windows Server 2012 that helps IT professionals provision and manage both local and remote Windows-based servers from their desktops, without requiring either physical access to servers, or the need to enable Remote Desktop protocol (rdP) connections to each server. Although Server Manager is available in  Windows Server 2008 R2 and Windows Server 2008, Server Manager was updated in  Windows Server 2012, to support remote, multi-server management, and help increase the number of servers an administrator can manage.

In our tests, Server Manager in  Windows Server 2012 R2  and  Windows Server 2012 can be used to manage up to 100 servers that are configured with a typical workload. The number of servers that you can manage by using a single Server Manager console can vary depending on the amount of data that you request from managed servers, and hardware and network resources available to the computer running Server Manager. As the amount of data you want to display approaches that computer's resource capacity, you can experience slow responses from Server Manager, and delays in the completion of refreshes. To help increase the number of servers that you can manage by using Server Manager, we recommend limiting the event data that Server Manager gets from your managed servers, by using settings in the **Configure Event Data** dialog box. Configure Event Data can be opened from the **Tasks** menu in the **Events** tile. If you need to manage an enterprise-level number of servers in your organization, we recommend evaluating products in the [Microsoft System Center suite](https://go.microsoft.com/fwlink/p/?LinkId=239437).

This topic and its subtopics provide information about how to use features in the Server Manager console. This topic contains the following sections.

-   [Review initial considerations and system requirements](#BKMK_1.1)

-   [Tasks that you can perform in Server Manager](#BKMK_tasks)

-   [start Server Manager](#BKMK_start)

-   [Restart remote servers](#BKMK_restart)

-   [Export Server Manager settings to other computers](#BKMK_export)

## <a name="BKMK_1.1"></a>Review initial considerations and system requirements
The following sections list some initial considerations that you need to review, as well as hardware and software requirements for Server Manager.

### Hardware requirements
Server Manager is installed by default with all editions of  Windows Server 2012 R2  and  Windows Server 2012 . No additional hardware requirements exist for Server Manager.

### <a name="BKMK_softconfig"></a>Software and configuration requirements
Server Manager is installed by default with all editions of  Windows Server 2012 . Although you can use Server Manager to manage [Server Core installation options](https://go.microsoft.com/fwlink/p/?LinkID=241573) of  Windows Server 2012  and  Windows Server 2008 R2  that are running on remote computers, Server Manager does not run directly on Server Core installation options.

To fully manage remote servers that are running  Windows Server 2008  or  Windows Server 2008 R2 , install the following updates on the servers you want to manage, in the order shown.

To manage servers that are running  Windows Server 2012 ,  Windows Server 2008 R2 , or  Windows Server 2008  by using Server Manager in  Windows Server 2012 R2 , apply the following updates to the older operating systems.

-   [.NET Framework 4.5](https://www.microsoft.com/download/details.aspx?id=30653)

-   [Windows Management Framework 4.0](https://go.microsoft.com/fwlink/?LinkId=293881). The Windows Management Framework 4.0 download package updates Windows Management Instrumentation (WMI) providers on  Windows Server 2012 ,  Windows Server 2008 R2 , and  Windows Server 2008 . The updated WMI providers let Server Manager collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running  Windows Server 2012 ,  Windows Server 2008 R2  or  Windows Server 2008  have a manageability status of **Not accessible**.

-   The performance update associated with [Knowledge Base article 2682011](https://go.microsoft.com/fwlink/p/?LinkID=245487) allows Server Manager to collect performance data from  Windows Server 2008  and  Windows Server 2008 R2 . This performance update is not necessary on servers that are running  Windows Server 2012 .

To manage servers that are running  Windows Server 2008 R2  or  Windows Server 2008 , apply the following updates to the older operating systems.

-   [.NET Framework 4](https://www.microsoft.com/download/en/details.aspx?id=17718)

-   [Windows Management Framework 3.0](https://go.microsoft.com/fwlink/p/?LinkID=229019) The Windows Management Framework 3.0 download package updates Windows Management Instrumentation (WMI) providers on  Windows Server 2008  and  Windows Server 2008 R2 . The updated WMI providers let Server Manager collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running  Windows Server 2008  or  Windows Server 2008 R2  have a manageability status of **Not accessible - verify earlier versions run Windows Management Framework 3.0**.

-   The performance update associated with [Knowledge Base article 2682011](https://go.microsoft.com/fwlink/p/?LinkID=245487) allows Server Manager to collect performance data from  Windows Server 2008 and  Windows Server 2008 R2.

Server Manager runs in the Minimal Server Graphical Interface; that is, when the Server Graphical Shell feature has been uninstalled. The Server Graphical Shell feature is installed by default on  Windows Server 2012 R2  and Windows Server 2012. If you uninstall Server Graphical Shell, the Server Manager console runs, but some applications or tools available from the console are not available. Internet browsers cannot run without Server Graphical Shell, so webpages and applications such as HTML help (The mmc F1 help, for example) cannot be opened. You cannot open dialog boxes for configuring Windows automatic updating and feedback when Server Graphical Shell is not installed; commands that open these dialog boxes in the Server Manager console are redirected to run **sconfig.cmd**.

#### Manage remote computers from a client computer
The Server Manager console is included with [Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=304145) for Windows 8.1 and [Remote Server Administration Tools](https://go.microsoft.com/fwlink/p/?LinkID=238560) for Windows 8. Note that when Remote Server Administration Tools is installed on a client computer, you cannot manage the local computer by using Server Manager; Server Manager cannot be used to manage computers or devices that are running a Windows client operating system. You can use Server Manager to manage only Windows-based servers.

|Server Manager Source Operating System|Targeted at  Windows Server 2012 R2 |Targeted at  Windows Server 2012 |Targeted at  Windows Server 2008 R2  or  Windows Server 2008 |Targeted at Windows Server 2003|
|-------------------------------|---------------------------------------|------------------------------------|-----------------------------------------------------------------------|------------------|
|Windows 8 or  Windows Server 2012 |Not supported|Full support|After [Software and configuration requirements](#BKMK_softconfig) are satisfied, can perform most management tasks, but no role or feature installation or uninstallation|Limited support; online and offline status only|
|Windows 8.1 or  Windows Server 2012 R2 |Full support|Full support|After [Software and configuration requirements](#BKMK_softconfig) are satisfied, can perform most management tasks, but no role or feature installation or uninstallation|Limited support; online and offline status only|

###### To start Server Manager on a client computer

1.  Follow instructions in [Deploy Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=238562) to install Remote Server Administration Tools for Windows 8.1 or Remote Server Administration Tools for Windows 8.

2.  On the **start** screen, click **Server Manager**. The **Server Manager** tile is available after you install Remote Server Administration Tools.

3.  if neither the **Administrative Tools** nor the **Server Manager** tiles are displayed on the **start** screen after installing Remote Server Administration Tools, and searching for Server Manager on the **start** screen does not display results, verify that the **Show administrative tools** setting is turned on. To view this setting, hover the mouse cursor over the upper right corner of the **start** screen, and then click **Settings**. If **Show administrative tools** is turned off, turn the setting on to display tools that you have installed as part of Remote Server Administration Tools.

for more information about running Remote Server Administration Tools for Windows 8 to manage remote servers, see [Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=221055) on the TechNet Wiki.

#### Configure remote management on servers that you want to manage

> [!IMPORTANT]
> By default, Server Manager and Windows PowerShell remote management is enabled in  Windows Server 2012 R2  and  Windows Server 2012 .

To perform management tasks on remote servers by using Server Manager, remote servers that you want to manage must be configured to allow remote management by using Server Manager and Windows PowerShell. If remote management has been disabled on  Windows Server 2012 R2  or  Windows Server 2012 , and you want to enable it again, perform the following steps.

##### <a name="BKMK_windows"></a>To configure Server Manager remote management on  Windows Server 2012 R2  or  Windows Server 2012  by using the Windows interface

1.  > [!NOTE]
    > The settings that are controlled by the **Configure remote Management** dialog box do not affect parts of Server Manager that use DCOM for remote communications.

    Do one of the following to open Server Manager if it is not already open.

    -   On the Windows taskbar, click the Server Manager button.

    -   On the **start** screen, click **Server Manager**.

2.  In the **Properties** area of the **Local Servers** page, click the hyperlinked value for the **remote management** property.

3.  Do one of the following, and then click **OK**.

    -   To prevent this computer from being managed remotely by using Server Manager (or Windows PowerShell if it is installed), clear the **Enable remote management of this server from other computers** check box.

    -   To let this computer be managed remotely by using Server Manager or Windows PowerShell, select **Enable remote management of this server from other computers**.

##### <a name="BKMK_ps"></a>To enable Server Manager remote management on  Windows Server 2012 R2  or  Windows Server 2012  by using Windows PowerShell

1.  Do one of the following.

    -   To run Windows PowerShell as an administrator from the **start** screen, right-click the **Windows PowerShell** tile, and then click **Run as Administrator**.

    -   To run Windows PowerShell as an administrator from the desktop, right-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.

2.  type the following, and then press **Enter** to enable all required firewall rule exceptions.

    **Configure-SMremoting.exe -Enable**

    > [!NOTE]
    > This command also works in a command prompt that has been opened with elevated user rights (Run as Administrator).

    if enabling remote management fails, see [about_remote_Troubleshooting](https://go.microsoft.com/fwlink/p/?LinkID=135188) on Microsoft TechNet for troubleshooting tips and best practices.

###### To enable Server Manager and Windows PowerShell remote management on older operating systems

-   Do one of the following.

    -   To enable remote management on servers that are running  Windows Server 2008 R2 , see [remote Management with Server Manager](https://go.microsoft.com/fwlink/?LinkID=137378) in the  Windows Server 2008 R2  help.

    -   To enable remote management on servers that are running  Windows Server 2008 , see [Enable and Use remote Commands in Windows PowerShell](https://go.microsoft.com/fwlink/p/?LinkId=242565).

    -   To enable remote management on servers that are running Windows Server 2003, enable WMI DCOM exceptions in Windows Firewall. For more information about how to do this on servers that are running Windows Server 2003, see [Connecting Through Windows Firewall](https://msdn.microsoft.com/library/aa389286.aspx) on MSDN.

## <a name="BKMK_tasks"></a>Tasks that you can perform in Server Manager
Server Manager makes server administration more efficient by allowing administrators to do tasks in the following table by using a single tool. In  Windows Server 2012 R2  and  Windows Server 2012 , both standard users of a server and members of the Administrators group can perform management tasks in Server Manager, but by default, standard users are prevented from performing some tasks, as shown in the following table.

Administrators can use two Windows PowerShell cmdlets in the Server Manager cmdlet module, [Enable-ServerManagerStandardUserremoting](https://technet.microsoft.com/library/jj205470.aspx) and [Disable-ServerManagerStandardUserremoting](https://technet.microsoft.com/library/jj205468.aspx), to further control standard user access to some additional data. The **Enable-ServerManagerStandardUserremoting** cmdlet can provide one or more standard, non-Administrator users access to event, service, performance counter, and role and feature inventory data.

> [!IMPORTANT]
> Server Manager cannot be used to manage a newer release of the Windows Server operating system. Server Manager running on  Windows Server 2012  or Windows 8 cannot be used to manage servers that are running  Windows Server 2012 R2 .

|Task Description|Administrators (including the built-in Administrator account)|Standard Server Users|
|----------|----------------------------------|-------------|
|add remote servers to a pool of servers that Server Manager can be used to manage.|Yes|No|
|create and edit custom groups of servers, such as servers that are in a specific geographic location or serve a specific purpose.|Yes|Yes|
|Install or uninstall roles, role services, and features on the local or on remote servers that are running  Windows Server 2012 R2  or  Windows Server 2012 . For definitions of roles, role services, and features, see [Roles, Role Services, and Features](https://go.microsoft.com/fwlink/p/?LinkId=239558).|Yes|No|
|View and make changes to server roles and features that are installed on either local or remote servers. **Note:** In Server Manager, role and feature data is displayed in the base language of the system, also called the system default GUI language, or the language selected during installation of the operating system.|Yes|Standard users can view and manage roles and features, and perform tasks such as viewing role events, but cannot add or remove role services.|
|start management tools such as Windows PowerShell or mmc snap-ins. You can start a Windows PowerShell session targeted at a remote server by right-clicking the server in the **Servers** tile, and then clicking **Windows PowerShell**. You can start mmc snap-ins from the **Tools** menu of the Server Manager console, and then point the mmc toward a remote computer after the snap-in is open.|Yes|Yes|
|Manage remote servers with different credentials by right-clicking a server in the **Servers** tile, and then clicking **Manage As**. You can use **Manage As** for general server and File and Storage Services management tasks.|Yes|No|
|Perform management tasks associated with the operational lifecycle of servers, such as starting or stopping services; and start other tools that allow you to configure a server's network settings, users and groups, and Remote Desktop connections.|Yes|Standard users cannot start or stop services. They can change the local server's name, workgroup, or domain membership and Remote Desktop settings, but are prompted by User Account Control to provide Administrator credentials before they can complete these tasks. They cannot change remote management settings.|
|Perform management tasks associated with the operational lifecycle of roles that are installed on servers, including scanning roles for compliance with best practices.|Yes|Standard users cannot run Best Practices Analyzer scans.|
|Determine server status, identify critical events, and analyze and troubleshoot configuration issues or failures.|Yes|Yes|
|Customize the events, performance data, services, and Best Practices Analyzer results about which you want to be alerted on the Server Manager dashboard.|Yes|Yes|
|Restart servers.|Yes|No|
|Refresh data that is displayed in the Server Manager console about managed servers.|Yes|No|

> [!NOTE]
> Server Manager can receive only online or offline status from servers that are running Windows Server 2003. Server Manager cannot be used to add roles and features to servers that are running  Windows Server 2008 R2 ,  Windows Server 2008 , or Windows Server 2003.

## <a name="BKMK_start"></a>start Server Manager
Server Manager starts automatically by default on servers that are running  Windows Server 2012  when a member of the Administrators group logs on to a server. If you close Server Manager, restart it in one of the following ways. This section also contains steps for changing the default behavior, and preventing Server Manager from starting automatically.

#### To start Server Manager from the start screen

-   On the Windows **start** screen, click the **Server Manager** tile.

#### To start Server Manager from the Windows desktop

-   On the Windows taskbar, click **Server Manager**.

#### To prevent Server Manager from starting automatically

1.  In the Server Manager console, on the **Manage** menu, click **Server Manager Properties**.

2.  In the **Server Manager Properties** dialog box, fill the check box for **Do not start Server Manager automatically at logon**. Click **OK**.

3.  Alternatively, you can prevent Server Manager from starting automatically by enabling the Group Policy setting, **Do not start Server Manager automatically at logon**. The path to this policy setting, in the Local Group Policy editor console, is computer Configuration\Administrative Templates\System\Server Manager.

## <a name="BKMK_restart"></a>Restart remote servers
You can restart a remote server from the **Servers** tile of a role or group page in Server Manager.

> [!IMPORTANT]
> Restarting a remote server forces the server to restart, even if users are still logged on to the remote server, and even if programs with unsaved data are still open. This behavior is different from shutting down or restarting the local computer, on which you would be prompted to save unsaved program data, and verify that you wanted to force logged-on users to log off. Be sure that you can force other users to log off of remote servers, and that you can discard unsaved data in programs that are running on the remote servers.
> 
> if an automatic refresh occurs in Server Manager while a managed server is shutting down and restarting, refresh and manageability status errors can occur for the managed server, because Server Manager cannot connect to the remote server until it is finished restarting.

#### To restart remote servers in Server Manager

1.  Open a role or server group home page in Server Manager.

2.  select one or more remote servers that you have added to Server Manager. Press and hold **Ctrl** as you click to select multiple servers at one time. For more information about how to add servers to the Server Manager server pool, see [add Servers to Server Manager](add-servers-to-server-manager.md).

3.  Right-click selected servers, and then click **Restart Server**.

## <a name="BKMK_export"></a>Export Server Manager settings to other computers
In Server Manager, your list of managed servers, changes to Server Manager console settings, and custom groups that you have created are stored in the following two files. You can reuse these settings on other computers that are running the same release of Server Manager (not computers that are running the Server Core installation option) or Windows 8. Remote Server Administration Tools must be running on Windows client-based computers to export Server Manager settings to those computers.

-   %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

-   %*appdata*%\Local\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config

> [!NOTE]
> -   Manage As (or alternate) credentials for servers in your server pool are not stored in the roaming profile. Server Manager users must add them on each computer from which they want to manage.
> -   The network share roaming profile is not created until a user logs on to the network, and then logs off for the first time. The **Serverlist.xml** file is created at this time.

You can export Server Manager settings, make Server Manager settings portable, or use them on other computers in one of the following two ways.

-   To export settings to another domain-joined computer, configure the Server Manager user to have a roaming profile in active directory Users and computers. You must be a Domain Administrator to change user properties in active directory Users and computers.

-   To export settings to another computer in a workgroup, copy the preceding two files to the same location on the computer from which you want to manage by using Server Manager.

#### To export Server Manager settings to other domain-joined computers

1.  In active directory Users and computers, open the **Properties** dialog box for a Server Manager user.

2.  On the **Profile** tab, add a path to a network share to store the user's profile.

3.  Do one of the following.

    -   On U.S. English (en-us) builds, changes to the **Serverlist.xml** file are automatically saved to the profile. Go on to the next step.

    -   On other builds, copy the following two files from the computer that is running Server Manager to the network share that is part of the user's roaming profile.

        -   %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

        -   %*localappdata*%\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config

4.  Click **OK** to save your changes and close the **Properties** dialog box.

#### To export Server Manager settings to computers in workgroups

-   On a computer from which you want to manage remote servers, overwrite the following two files with the same files from another computer that is running Server Manager, and that has the settings you want.

    -   %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

    -   %*localappdata*%\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config


