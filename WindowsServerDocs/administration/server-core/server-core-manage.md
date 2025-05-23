---
title: Manage Server Core
description: Learn how to manage a Server Core installation of Windows Server.
author: xelu86
ms.author: alalve
ms.date: 01/16/2025
ms.topic: how-to
---

# Manage a Server Core server

You can manage a Server Core server in the following ways:

- Using [Windows Admin Center](../../manage/windows-admin-center/overview.md)
- Using [Remote Server Administration Tools](../../remote/remote-server-administration-tools.md) running on Windows 10
- Locally and remotely using Windows PowerShell
- Remotely using [Server Manager](../server-manager/server-manager.md)
- Remotely using an [MMC snap-in](#managing-with-microsoft-management-console)
- Remotely with [Remote Desktop Services](#managing-with-remote-desktop-services)

You can also add hardware and manage drivers locally, as long as you do that from the command line.

There are some important limitations and tips to keep in mind when you work with Server Core:

- If you close all command prompt windows and want to open a new Command Prompt window, you can do that from the Task Manager. Press **CTRL+ALT+DELETE**, select **Start Task Manager**, select **More Details > File > Run**, and then type **cmd.exe**. (Type **Powershell.exe** to open a PowerShell command window.) Alternatively, you can sign out and then sign back in.
- Any command or tool that attempts to start Windows Explorer doesn't work. For example, running **start .** from a command prompt doesn't work.
- There's no support for HTML rendering or HTML help in Server Core.
- Server Core supports Windows Installer in quiet mode so that you can install tools and utilities from Windows Installer files. When installing Windows Installer packages on Server Core, use the **/qb** option to display the basic user interface.
- To change the time zone, run **Set-Date**.
- To change international settings, run **control intl.cpl**.
- **Control.exe** doesn't run on its own. You must run it with either **Timedate.cpl** or **Intl.cpl**.
- **Winver.exe** isn't available in Server Core. Use **Systeminfo.exe** to obtain version information.

## Managing Server Core with Windows Admin Center

[Windows Admin Center](../../manage/windows-admin-center/overview.md) is a browser-based management app that enables on-premises administration of Windows Servers with no Azure or cloud dependency. Windows Admin Center gives you full control over all aspects of your server infrastructure and is useful for management on private networks that aren't connected to the Internet. You can install Windows Admin Center on a Windows 10 machine, a gateway server, or a Windows Server installation with Desktop Experience. Once installed, you can connect to the Server Core system you want to manage.

## Managing Server Core remotely with Server Manager

Server Manager is a management console in Windows Server that helps you provision and manage both local and remote Windows-based servers from your desktops. Server Manager doesn't require either physical access to servers, or the need to enable Remote Desktop protocol (RDP) connections to each server. Server Manager supports remote, multi-server management.

To enable your local server to be managed by Server Manager running on a remote server, run the Windows PowerShell cmdlet **Configure-SMRemoting.exe –Enable**.

## Managing with Microsoft Management Console

You can use many snap-ins for Microsoft Management Console (MMC) remotely to manage your Server Core server.

To use an MMC snap-in to manage a Server Core server that is a domain member:

1. Start an MMC snap-in, such as Computer Management.
1. Right-click the snap-in, then select **Connect to another computer**.
1. Type the computer name of the Server Core server, then select **OK**. You can now use the MMC snap-in to manage the Server Core server as you would any other PC or server.

To use an MMC snap-in to manage a Server Core server that *isn't* a domain member:

1. Establish alternate credentials to use to connect to the Server Core computer by typing the following command at a command prompt on the remote computer:

   ```
   cmdkey /add:<ServerName> /user:<UserName> /pass:<password>
   ```

   If you want to be prompted for a password, omit the **/pass** option.

1. When prompted, type the password for the user name you specified.
   If the firewall on the Server Core server isn't already configured to allow MMC snap-ins to connect, follow these steps to configure Windows Firewall to allow MMC snap-in. Then continue with step 3.
1. On a different computer, start an MMC snap-in, such as **Computer Management**.
1. In the left pane, right-click the snap-in, then select **Connect to another computer**. (For example, in the Computer Management example, you would right-click **Computer Management (Local)**.)
1. In **Another computer**, type the computer name of the Server Core server, then select **OK**. You can now use the MMC snap-in to manage the Server Core server as you would any other computer running a Windows Server operating system.

### To configure Windows Firewall to allow MMC snap-ins to connect

To allow all MMC snap-ins to connect, run the following command:

```PowerShell
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"
```

To allow only specific MMC snap-ins to connect, run the following command:

```PowerShell
Enable-NetFirewallRule -DisplayGroup "<RuleGroup>"
```

Where *\<RuleGroup>* is one of the following, depending on which snap-in you want to connect:

| MMC snap-in                            | Rule group                                            |
| ---------------------------------------- | ------------------------------------------------------- |
| Event Viewer                           | Remote Event Log Management                           |
| Services                               | Remote Service Management                             |
| Shared Folders                         | File and Printer Sharing                              |
| Task Scheduler                         | Performance Logs and Alerts, File and Printer Sharing |
| Disk Management                        | Remote Volume Management                              |
| Windows Defender Firewall with Advanced Security | Windows Defender Firewall Remote Management                    |

> [!NOTE]
> Some MMC snap-ins don't have a corresponding rule group that allows them to connect through the firewall. However, enabling the rule groups for Event Viewer, Services, or Shared Folders allows most other snap-ins to connect.
>
> Additionally, certain snap-ins require further configuration before they can connect through Windows Firewall:
>
> - **Disk Management**: You must first start the Virtual Disk Service (VDS) on the Server Core computer. You must also configure the Disk Management rules appropriately on the computer that is running the MMC snap-in.
> - **IP Security Monitor**: You must first enable remote management of this snap-in. At a command prompt, type `cscript c:\windows\system32\scregedit.wsf /im 1`
> - **Reliability and Performance**: This snap-in doesn't require any further configuration, but when you use it to monitor a Server Core computer, you can only monitor performance data. Reliability data isn't available.

## Managing with Remote Desktop Services

You can use [Remote Desktop](../../remote/remote-desktop-services/remote-desktop-services-overview.md) to manage a Server Core server from remote computers.

Before you can access Server Core, you'll need to run the following command:

```
cscript C:\Windows\System32\Scregedit.wsf /ar 0
```

This command enables the Remote Desktop for Administration mode to accept connections.

## Add hardware and manage drivers locally

To add hardware to a Server Core server, follow the instructions provided by the hardware vendor for installing new hardware.

If the hardware isn't plug and play, you'll need to manually install the driver. To do that, copy the driver files to a temporary location on the server, and then run the following command:

```
pnputil –i –a <driverinf>
```

Where *driverinf* is the file name of the .inf file for the driver.

If prompted, restart the computer.

To see what drivers are installed, run the following command:

```
sc query type= driver
```

> [!NOTE]
> You must include the space after the equal sign for the command to complete successfully.

To disable a device driver, run the following command:

```
sc delete <service_name>
```

Where *service_name* is the name of the service that you got when you ran **sc query type= driver**.
