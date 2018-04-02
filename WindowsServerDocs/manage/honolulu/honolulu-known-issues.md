---
title: Project Honolulu known issues
description: "Project Honolulu is under development in Preview and there are some known issues that may have to be worked around"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: Honolulu
ms.tgt_pltfrm: na
ms.topic:
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 12/01/2017
---

# Project Honolulu known issues

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012 and Windows 10

Project Honolulu is under development and currently in Technical Preview, so there are some known issues that you may have to work around.

If you encounter an issue not described on this page, please [let us know](http://aka.ms/honolulufeedback).

## Installer

- When installing Honolulu using your own certificate, be mindful that if you copy the thumbprint from the certificate manager MMC tool, [it will contain an invalid character at the beginning.](https://support.microsoft.com/help/2023835/certificate-thumbprint-displayed-in-mmc-certificate-snap-in-has-extra) As a workaround, type the first character of the thumbprint, and copy/paste the rest.

## General

 - When disconnected from the internet, the Honolulu gateway may display errors trying to reach aka.ms (looking for available update) or myget.org (looking for available extentions.) [1709-14483239] [1709-14483301]

- If you are specifying credentials while adding a new server connection, make sure to click **Retry with credentials** before submitting the form. You may have to scroll down to reveal the button. [1709-13706997]

- If you have Honolulu installed as a server service, and you are managing localhost from a local browser, some tools may not be fully functional, or may throw a **WMI access denied** error. In this case, you'll need to manage the server from a remote machine. [1709-13759990]

- If you previously had Honolulu installed as a server service, you may get a blank entry in the server list. To correct this, perform the following steps:

  1. Uninstall Project Honolulu.
  2. Delete the **Server Management Experience** folder under **C:\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft**
  3. Reinstall Project Honolulu

- If you leave the tool open and idle for a long period of time, you may get several **Error: The runspace state is not valid for this operation** errors. If this occurs, refresh your browser. If you encounter this, [send feedback.](http://aka.ms/honolulufeedback)

- In some cases, you may encounter long loading times when using Edge to access a Honolulu gateway over the Internet. This can occur on Azure VMs where the Honolulu gateway is using a self-signed certificate. [1709-13819912]

- If you have installed or uninstalled extensions, you may get an error when trying to uninstall Honolulu. Performing the uninstall again should clear the error. [1709-13502848]

- You may get a **Site cannot be reached** error the first time you load the site when it’s installed on a server. [1709- 13819870]

- You may encounter a **500 Error** when refreshing pages with very long URLs. [1709-12443710]

- In some tools, your browser’s spell checker may mark certain field values as misspelled. [1709-12425477]

- In some tools, command buttons may not reflect state changes immediately after being clicked, and the tool UI may not automatically reflect changes to certain properties. You can click **Refresh** to retrieve the latest state from the target server. [1709-11445790]

- When adding servers to manage, using the FQDN as server name is highly recommended. You may encounter connection errors if a computer name or IP address is used. [1709-11551175]

- There may be minor variance between version numbers of OS's running in Honolulu modules, and what is listed within the 3rd Party Software Notice.

## WebSocket compatibility when using a proxy service

Remote Desktop, PowerShell, and Events modules in Honolulu utilize the WebSocket protocol, which is often not supported when using a proxy service. Check out [Azure AD Application Proxy](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-application-proxy-get-started) for a proxy solution that supports websockets.

## Support for Windows Server versions before 2016 (2012 & 2012R2)

Please [submit feedback](http://aka.ms/honolulufeedback) on any issues you encounter, so that we can prioritize the tool optimization.

> [!NOTE]
> Project Honolulu requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Honolulu, you will need to install WMF version 5.0 or higher on those servers. 

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

If it is not installed, you can [download and install WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## Server Manager solution

### Certificates

* Cannot import .PFX Encrypted Certificate in to current user store. [1709-11818622]

### Devices

* Device Manager is read-only. Driver update/rollback are not yet implemented.

### Events

* Please [report bugs!](http://aka.ms/honolulufeedback)

### Files

* Uploading or downloading large files not yet supported. (\~100mb limit) [1709-12524234]

### Firewall

* Please [report bugs!](http://aka.ms/honolulufeedback)

### Local Users and Groups

* Please [report bugs!](http://aka.ms/honolulufeedback)

### Network Settings

* When you set a network adapter to DHCP, or update to a new IP address, it can take some time for the change to take effect, even if a success notification was shown. If this happens, waiting should fix the problem. There is no harm in sending the request again if there is no change after a long period of time. [1709-13383236]

### PowerShell

* Pasting with a single right-click as in the desktop PowerShell console does not work. Instead you will get the browser’s context menu, where you can select paste. Ctrl-V works as well.

* Ctrl-C to copy does not work, it will always send the Ctrl-C break command to the console. Copy from the right-click context menu works.

* When you make the Honolulu window smaller, the terminal content will reflow, but when you make it larger again, the content may not return to it’s previous state. If things get jumbled, you can try Clear-Host, or disconnect and reconnect using the button above the terminal.

### Processes

* Starting a new process not yet implemented. [1709-11804107]

### Registry Editor

* Search functionality not implemented. [1709-13820009]

* Export may fail in the case of a very long key name [1709-13760106]

### Remote Desktop

* Remote Desktop tool fails to connect, showing “Session disconnected” popup dialog and the following error:
Unexpected error in RDP Client: disconnect code=UnknownError(46), extended code=<null>, reason=X509_NAME_print_ex failed, (OSSL error: ERR_error_string returned "error:00000000:lib(0):func(0):reason(0)") Thrown in thread 0 at: certificateutils.cpp(152)

   This is due to a bug in the Remote Desktop web control when the certificate on the gateway does not have a subject field. We are        planning to fix this in a future update, and for now, use a certificate that has a subject when installing Honolulu.


* The Remote Desktop tool does not currently support any text, image, or file copy/paste between the local desktop and the remote session.

* To do any copy/paste within the remote session, you can copy as normal (right click + copy or Ctrl+C), but paste requires right click + paste (Ctrl+V does NOT work)

* Opening the web browser’s debugger while a Remote Desktop session is active may cause your computer to crash. Don’t do it.

* You cannot send the following key commands to the remote session

  * Ctrl+Alt+End / Ctrl+Alt+Del
  
  * Alt+Tab
  
  * Function keys
  
  * Windows Key
  
  * PrtScn

### Roles and Features

* When selecting roles or features with unavailable sources for install, they are skipped. [1709-12946914]

* If you choose not to automatically reboot after role installation, we won’t ask again. [1709-13098852]

* If you do choose to automatically reboot, the reboot will occur before the status gets updated to 100%. [1709- 13098852]

### Services

* Deeplinking to some services may not work. If you encounter this please [create a bug](http://aka.ms/honolulufeedback)

### Storage

* Down-level: DVD/CD/ Floppy drives do not appear as volumes on down-level.

* Down-level: Some properties in Volumes and Disks are not available down-level so they appear unknown or blank in details panel.

* Down-level: When creating a new volume, ReFS only supports an allocation unit size of 64K on Windows 2012 and 2012 R2 machines. If a ReFS volume is created with a smaller allocation unit size on down-level targets, file system formatting will fail. The new volume will not be usable. The resolution is to delete the volume and use 64K allocation unit size.

### Virtual Machines

* Advanced features available in Hyper-V Manager such as Virtual SAN Manager, Move VM, Export VM, VM Replication are currently not supported.

### Virtual Switches

* Switch Embedded Teaming (SET): When adding NICs to a team, they must be on the same subnet.

### Windows Update

* After installing updates, install status may be cached and require browser refresh.

## Computer Management Solution

The Computer Management solution contains a subset of the tools from the Server Manager solution, so the same known issues apply, as well as the following Computer Management solution specific issues:

* If you try to add a Windows PC connection, but the add connection dialog tries to add it as a server, refresh your browser. If the problem persists, clear your browser cache.

* When you try to manage the localhost, you will be prompted to elevate the gateway process. If you click **no** in the User Account Control popup that follows, Honolulu won’t be able to display it again. In this case, exit the gateway process by right-clicking the Project Honolulu icon in the system tray and choosing exit, then relaunch Project Honolulu from the Start Menu.

* If you have the RSAT tools installed, the Virtual Machine tool will throw a cluster service error [1711-14598645]

* Windows 10 does not have WinRM/PowerShell remoting on by default
  
  * To enable management of the Windows 10 Client, you must issue the command ```Enable-PSRemoting``` from an elevated PowerShell prompt.

  * You may also need to update your firewall to allow connections from outside the local subnet with ```Set-NetFirewallRule -Name WINRM-HTTP-In-TCP –RemoteAddress Any``` For more restrictive networks scenarios, please refer to [this documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-5.1).

## Failover Cluster Manager solution

* When managing a cluster, (either Hyper-Converged or traditional?) you may encounter a **shell was not found** error. If this happens either reload your browser, or navigate away to another tool and back. [1709-13882442]

* An issue can occur when managing a down-level (Windows Server 2012 or 2012 R2) cluster that hasn’t been configured completely. The fix for this issue is to ensure that the Windows feature **RSAT-Clustering-PowerShell** has been installed and enabled on **each member node** of the cluster. To do this with PowerShell, enter the command `Install-WindowsFeature -Name RSAT-Windows-PowerShell` on all the cluster nodes. [1709-12524664]

* The Cluster may need to be added with the entire FQDN to be discovered correctly.

* When connecting to a cluster using Honolulu installed as a server service, and providing explicit username/password to authenticate, you must select **Use these credentials for all connections** so that the credentials are available to query the member nodes.

## Hyper-Converged Cluster Manager solution

* Some commands such as **Drives – Update firmware**, **Servers – Remove** and **Volumes – Open** are disabled and currently not supported.
