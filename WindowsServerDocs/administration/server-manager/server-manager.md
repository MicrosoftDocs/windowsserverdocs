---
title: Server Manager
description: Server Manager centralizes Windows Server management. Discover how to provision, monitor, and manage servers without Remote Desktop.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 06/16/2025
---
# Server Manager

Server Manager is a centralized management console in Windows Server that enables IT professionals to provision and manage both local and remote Windows-based servers from their desktops. With Server Manager, you can efficiently administer multiple servers without needing physical access or enabling Remote Desktop Protocol (RDP) connections. Server Manager supports remote, multi-server management, and help increase the number of servers an administrator can manage.

This article provides an overview of Server Manager features, supported tasks, and guidance for managing servers in your environment. This article contains the following sections:

- [Tasks that you can perform in Server Manager](#tasks-that-you-can-perform-in-server-manager)

- [Start Server Manager](#start-server-manager)

- [Restart remote servers](#restart-remote-servers)

- [Export Server Manager settings to other computers](#export-server-manager-settings-to-other-computers)

## Manage remote computers from a client computer

The Server Manager console is included with [Remote Server Administration Tools](https://go.microsoft.com/fwlink/?LinkID=404281) for Windows 10 and Windows 11. When Remote Server Administration Tools is installed on a client computer, you can't manage the local computer by using Server Manager; Server Manager can't be used to manage computers or devices that are running a Windows client operating system. You can only use Server Manager to manage Windows-based servers.

### Start Server Manager on a client computer

1. Follow instructions in [Remote Server Administration Tools](../../remote/remote-server-administration-tools.md) to install Remote Server Administration Tools for Windows.

2. On the **start** screen, click **Server Manager**. The **Server Manager** tile is available after you install Remote Server Administration Tools.

3. If neither the **Administrative Tools** nor the **Server Manager** tiles are displayed on the **start** screen after installing Remote Server Administration Tools, and searching for Server Manager on the **start** screen doesn't display results, verify that the **Show administrative tools** setting is turned on. To view this setting, hover the mouse cursor over the upper right corner of the **start** screen, and then click **Settings**. If **Show administrative tools** is turned off, turn the setting on to display tools that you have installed as part of Remote Server Administration Tools.

For more information about running Remote Server Administration Tools for Windows 10 to manage remote servers, see [Remote Server Administration Tools](/troubleshoot/windows-server/system-management-components/remote-server-administration-tools) on the TechNet Wiki.

### Configure remote management on servers that you want to manage

To perform management tasks on remote servers by using Server Manager, remote servers that you want to manage must be configured to allow remote management by using Server Manager and Windows PowerShell. If remote management has been disabled on  Windows Server, and you want to enable it again, perform the following steps.

#### Configure Server Manager remote management

1. Do one of the following to open Server Manager if it isn't already open.

    - On the Windows taskbar, click the Server Manager button.

    - On the **start** screen, click **Server Manager**.

2. In the **Properties** area of the **Local Servers** page, click the hyperlinked value for the **remote management** property.

3. Do one of the following, and then click **OK**.

    - To prevent this computer from being managed remotely by using Server Manager, or Windows PowerShell if it's installed, clear the **Enable remote management of this server from other computers** check box.

    - To let this computer be managed remotely by using Server Manager or Windows PowerShell, select **Enable remote management of this server from other computers**.

#### Enable Server Manager remote management on Windows Server by using Windows PowerShell

1. Do one of the following.

    - To run Windows PowerShell as an administrator from the **start** screen, right-click the **Windows PowerShell** tile, and then click **Run as Administrator**.

    - To run Windows PowerShell as an administrator from the desktop, right-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.

2. Type the following, and then press **Enter** to enable all required firewall rule exceptions.

    **Configure-SMremoting.exe -Enable**

    > [!NOTE]
    > This command also works in a command prompt that has been opened with elevated user rights (Run as Administrator).

    if enabling remote management fails, see [about_remote_Troubleshooting](/powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting) on Microsoft TechNet for troubleshooting tips and best practices.

## Tasks that you can perform in Server Manager

Server Manager makes server administration more efficient by allowing administrators to do tasks in the following table by using a single tool. Both standard users of a server and members of the Administrators group can perform management tasks in Server Manager, but by default, standard users are prevented from performing some tasks, as shown in the following table.

Administrators can use two Windows PowerShell cmdlets in the Server Manager cmdlet module, [Enable-ServerManagerStandardUserremoting](/powershell/module/servermanager/enable-servermanagerstandarduserremoting) and [Disable-ServerManagerStandardUserremoting](/powershell/module/servermanager/disable-servermanagerstandarduserremoting), to further control standard user access to some more data. The **Enable-ServerManagerStandardUserremoting** cmdlet can provide one or more standard, non-Administrator users access to event, service, performance counter, and role and feature inventory data.

|Task Description|Administrators (including the built-in Administrator account)|Standard Server Users|
|----------|----------------------------------|-------------|
|Add remote servers to a pool of servers that Server Manager can be used to manage.|Yes|No|
|Create and edit custom groups of servers, such as servers that are in a specific geographic location or serve a specific purpose.|Yes|Yes|
|Install or uninstall roles, role services, and features on the local or on remote servers that are running  Windows Server. Learn more about how to [Add or remove roles and features in Windows Server](/windows-server/administration/server-manager/add-remove-roles-features).|Yes|No|
|View and make changes to server roles and features that are installed on either local or remote servers. In Server Manager, role and feature data is displayed in the base language of the system, also called the system default GUI language, or the language selected during installation of the operating system.|Yes|Standard users can view and manage roles and features, and perform tasks such as viewing role events, but can't add or remove role services.|
|start management tools such as Windows PowerShell or mmc snap-ins. You can start a Windows PowerShell session targeted at a remote server by right-clicking the server in the **Servers** tile, and then clicking **Windows PowerShell**. You can start mmc snap-ins from the **Tools** menu of the Server Manager console, and then point the mmc toward a remote computer after the snap-in is open.|Yes|Yes|
|Manage remote servers with different credentials by right-clicking a server in the **Servers** tile, and then clicking **Manage As**. You can use **Manage As** for general server and File and Storage Services management tasks.|Yes|No|
|Perform management tasks associated with the operational lifecycle of servers, such as starting or stopping services; and start other tools that allow you to configure a server's network settings, users and groups, and Remote Desktop connections.|Yes|Standard users can't start or stop services. They can change the local server's name, workgroup, or domain membership and Remote Desktop settings, but are prompted by User Account Control to provide Administrator credentials before they can complete these tasks. They can't change remote management settings.|
|Perform management tasks associated with the operational lifecycle of roles that are installed on servers, including scanning roles for compliance with best practices.|Yes|Standard users can't run Best Practices Analyzer scans.|
|Determine server status, identify critical events, and analyze and troubleshoot configuration issues or failures.|Yes|Yes|
|Customize the events, performance data, services, and Best Practices Analyzer results about which you want to be alerted on the Server Manager dashboard.|Yes|Yes|
|Restart servers.|Yes|No|
|Refresh data that is displayed in the Server Manager console about managed servers.|Yes|No|

## Start Server Manager

Server Manager starts automatically by default on Windows Server when a member of the Administrators group logs on to a server. If you close Server Manager, restart it in one of the following ways. This section also contains steps for changing the default behavior, and preventing Server Manager from starting automatically.

### Start Server Manager from the start screen

- On the Windows **start** screen, click the **Server Manager** tile.

### Start Server Manager from the Windows desktop

- On the Windows taskbar, click **Server Manager**.

### Prevent Server Manager from starting automatically

1. In the Server Manager console, on the **Manage** menu, click **Server Manager Properties**.

2. In the **Server Manager Properties** dialog box, fill the check box for **Do not start Server Manager automatically at logon**. Click **OK**.

3. Alternatively, you can prevent Server Manager from starting automatically by enabling the Group Policy setting, **Do not start Server Manager automatically at logon**. The path to this policy setting, in the Local Group Policy editor console, is computer Configuration\Administrative Templates\System\Server Manager.

## Restart remote servers

You can restart a remote server from the **Servers** tile of a role or group page in Server Manager.

Restarting a remote server forces the server to restart, even if users are still logged on to the remote server, and even if programs with unsaved data are still open. This behavior is different from shutting down or restarting the local computer, on which you would be prompted to save unsaved program data, and verify that you wanted to force logged-on users to log off. Be sure that you can force other users to log off of remote servers, and that you can discard unsaved data in programs that are running on the remote servers.

If an automatic refresh occurs in Server Manager while a managed server is shutting down and restarting, refresh and manageability status errors can occur for the managed server, because Server Manager can't connect to the remote server until it is finished restarting.

### Restart remote servers in Server Manager

1. Open a role or server group home page in Server Manager.

1. Select one or more remote servers that you have added to Server Manager. Press and hold **Ctrl** as you click to select multiple servers at one time. For more information about how to add servers to the Server Manager server pool, see [add Servers to Server Manager](add-servers-to-server-manager.md).

1. Right-click selected servers, and then click **Restart Server**.

## Export Server Manager settings to other computers

In Server Manager, your list of managed servers, changes to Server Manager console settings, and custom groups that you have created are stored in the following two files. You can reuse these settings on other computers that are running the same release of Server Manager. Remote Server Administration Tools must be running on Windows client-based computers to export Server Manager settings to those computers.

- %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

- %*appdata*%\Local\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config

> [!NOTE]
> - Manage As (or alternate) credentials for servers in your server pool aren't stored in the roaming profile. Server Manager users must add them on each computer from which they want to manage.
> - The network share roaming profile isn't created until a user logs on to the network, and then logs off for the first time. The **Serverlist.xml** file is created at this time.

You can export Server Manager settings, make Server Manager settings portable, or use them on other computers in one of the following two ways.

- To export settings to another domain-joined computer, configure the Server Manager user to have a roaming profile in active directory Users and computers. You must be a Domain Administrator to change user properties in active directory Users and computers.

- To export settings to another computer in a workgroup, copy the preceding two files to the same location on the computer from which you want to manage by using Server Manager.

### Export Server Manager settings to other domain-joined computers

1. In active directory Users and computers, open the **Properties** dialog box for a Server Manager user.

2. On the **Profile** tab, add a path to a network share to store the user's profile.

3. Do one of the following.

    - On U.S. English (en-us) builds, changes to the **Serverlist.xml** file are automatically saved to the profile. Go on to the next step.

    - On other builds, copy the following two files from the computer that is running Server Manager to the network share that is part of the user's roaming profile.

        - %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

        - %*localappdata*%\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config

4. Click **OK** to save your changes and close the **Properties** dialog box.

### Export Server Manager settings to computers in workgroups

- On a computer from which you want to manage remote servers, overwrite the following two files with the same files from another computer that is running Server Manager, and that has the settings you want.

  - %*appdata*%\Microsoft\Windows\ServerManager\Serverlist.xml

  - %*localappdata*%\Microsoft_Corporation\ServerManager.exe_StrongName_*GUID*\6.2.0.0\user.config

