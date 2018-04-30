---
title: Windows Admin Center Known Issues
description: Windows Admin Center Known Issues (Project Honolulu)
ms.technology: manage
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Windows Admin Center Known Issues 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

If you encounter an issue not described on this page, please [let us know](http://aka.ms/WACfeedback).

## **Insider preview** Windows 10 & Window Server 2019 (RS5)

- Windows Admin Center cannot be installed on a Windows 10 or Windows Server 2019 insider build (greater than build number 17134.xxx.) This is caused by a regression that will be fixed in an upcoming Windows Insider build. 

## Signature verification failed

- If you install Windows Admin Center on a machine that has never been online, the application may crash with **Signature verification failed** errors in the event log. Connecting the machine to the internet will resolve the error. After the error is resolved, the connection may be removed and Windows Admin Center will launch successfully offline.

## Installer

- When installing Windows Admin Center using your own certificate, be mindful that if you copy the thumbprint from the certificate manager MMC tool, [it will contain an invalid character at the beginning.](https://support.microsoft.com/help/2023835/certificate-thumbprint-displayed-in-mmc-certificate-snap-in-has-extra) As a workaround, type the first character of the thumbprint, and copy/paste the rest.

- Using port 80 is not supported. [16861485]

## General

- If you have Windows Admin Center installed as a gateway, and you are managing localhost from a local browser, some tools may not be fully functional, or may throw a **WMI access denied** error. In this case, you'll need to manage the server from a remote machine. [13759990]

- If you previously had the Project Honolulu technical preview installed as a gateway, you may get a blank entry in the server list. To correct this, perform the following steps:

  1. Uninstall Windows Admin Center
  2. Delete the **Server Management Experience** folder under **C:\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft**
  3. Reinstall Windows Admin Center

- If you leave the tool open and idle for a long period of time, you may get several **Error: The runspace state is not valid for this operation** errors. If this occurs, refresh your browser. If you encounter this, [send us feedback.](http://aka.ms/WACfeedback)

- You may get a **Site cannot be reached** error the first time you load the site when it's installed on a server. [13819870]

- You may encounter a **500 Error** when refreshing pages with very long URLs. [12443710]

- In some tools, your browser's spell checker may mark certain field values as misspelled. [12425477]

- In some tools, command buttons may not reflect state changes immediately after being clicked, and the tool UI may not automatically reflect changes to certain properties. You can click **Refresh** to retrieve the latest state from the target server. [11445790]

- There may be minor variance between version numbers of OS's running in Windows Admin Center modules, and what is listed within the 3rd Party Software Notice.

## Browser Specific Issues

### Microsoft Edge 

- In some cases, you may encounter long loading times when using Microsoft Edge to access a Windows Admin Center gateway over the Internet. This can occur on Azure VMs where the Windows Admin Center gateway is using a self-signed certificate. [13819912]

- When using Azure Active Directory as your identity provider and Windows Admin Center is configured with a self-signed or otherwise untrusted certificate, you cannot complete the AAD authentication in Microsoft Edge.  [15968377]

### Google Chrome

When using Windows Admin Center in a **workgroup** (non-domain) environment, Chrome has the following issues:

-	The websockets protocol does not work due to [this bug](https://bugs.chromium.org/p/chromium/issues/detail?id=423609). This effects the following tools: Events, PowerShell, Remote Desktop.

-	Chrome may pop-up multiple credential prompts, especially during the add connection experience. 

### Mozilla Firefox
Windows Admin Center is not tested with Mozilla Firefox, but most functionality should work. 

- Windows 10 Installation: Mozilla Firefox has it’s own certificate store, so you must import the ```Windows Admin Center Client``` certificate into Firefox to use Windows Admin Center on Windows 10.

## <a id="websockets"></a>WebSocket compatibility when using a proxy service

Remote Desktop, PowerShell, and Events modules in Windows Admin Center utilize the WebSocket protocol, which is often not supported when using a proxy service. Check out [Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/active-directory-application-proxy-get-started) for a proxy solution that supports websockets.

## Support for Windows Server versions before 2016 (2012 & 2012 R2)

> [!NOTE]
> Windows Admin Center requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you will need to install WMF version 5.1 or higher on those servers. 

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.1 or higher. 

If it is not installed, you can [download and install WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## <a id="rbacknownissues"></a>Role Based Access Control (RBAC)

- RBAC deployment will not succeed on machines that are configured to use Windows Defender Application Control (WDAC, formerly known as Code Integrity.) [16568455]

- To use RBAC in a cluster, you must deploy the configuration to each member node individually.

- When RBAC is deployed, you may get unauthorized errors that are incorrectly attributed to the RBAC configuration. [16369238]

## Server Manager solution

### Certificates

* Cannot import .PFX Encrypted Certificate in to current user store. [11818622]

### Devices

* When navigating through the table with your keyboard, the selection will jump to the top of the table group. [16646059]

### Events

* Events is effected by [websocket compatibility when using a proxy service.](#websockets)

* If you have the AD FS role installed, you will see a blank line under the *Applications and Services* heading. Opening this blank line will reveal "D FS" which is the actual event log.   [16861986]

- You may get an error that references “packet size” when exporting large log files. [16630279]

  * To resolve this, use the following command in an elevated command prompt on the gateway machine: ```winrm set winrm/config @{MaxEnvelopeSizekb="8192"}```

### Files

* Uploading or downloading large files not yet supported. (\~100mb limit) [12524234]

### Network Settings

* When you set a network adapter to DHCP, or update to a new IP address, it can take some time for the change to take effect, even if a success notification was shown. If this happens, waiting should fix the problem. There is no harm in sending the request again if there is no change after a long period of time. [13383236]

### PowerShell

* PowerShell is effected by [websocket compatibility when using a proxy service](#websockets)

* Pasting with a single right-click as in the desktop PowerShell console does not work. Instead you will get the browser's context menu, where you can select paste. Ctrl-V works as well.

* Ctrl-C to copy does not work, it will always send the Ctrl-C break command to the console. Copy from the right-click context menu works.

* When you make the Windows Admin Center window smaller, the terminal content will reflow, but when you make it larger again, the content may not return to it's previous state. If things get jumbled, you can try Clear-Host, or disconnect and reconnect using the button above the terminal.

### Registry Editor

* Search functionality not implemented. [13820009]

### Remote Desktop

* Remote Desktop is effected by [websocket compatibility when using a proxy service.](#websockets)

* The Remote Desktop tool does not currently support any text, image, or file copy/paste between the local desktop and the remote session. 

* To do any copy/paste within the remote session, you can copy as normal (right click + copy or Ctrl+C), but paste requires right click + paste (Ctrl+V does NOT work) 

* You cannot send the following key commands to the remote session 
  * Alt+Tab 
  * Function keys 
  * Windows Key 
  * PrtScn 

### Roles and Features

* When selecting roles or features with unavailable sources for install, they are skipped. [12946914]

* If you choose not to automatically reboot after role installation, we won't ask again. [13098852]

* If you do choose to automatically reboot, the reboot will occur before the status gets updated to 100%. [13098852]

### Services

* When working with a service with space in the name, you will get an error [16863359]

### Storage

* Down-level: DVD/CD/Floppy drives do not appear as volumes on down-level.

* Down-level: Some properties in Volumes and Disks are not available down-level so they appear unknown or blank in details panel.

* Down-level: When creating a new volume, ReFS only supports an allocation unit size of 64K on Windows 2012 and 2012 R2 machines. If a ReFS volume is created with a smaller allocation unit size on down-level targets, file system formatting will fail. The new volume will not be usable. The resolution is to delete the volume and use 64K allocation unit size.

### Updates

* After installing updates, install status may be cached and require browser refresh.

### Virtual Machines

* Advanced features available in Hyper-V Manager such as Virtual SAN Manager, Move VM, Export VM, VM Replication are currently not supported.

### Virtual Switches

* Switch Embedded Teaming (SET): When adding NICs to a team, they must be on the same subnet.

## Computer Management Solution

The Computer Management solution contains a subset of the tools from the Server Manager solution, so the same known issues apply, as well as the following Computer Management solution specific issues:

- If you use a Microsoft Account ([MSA](https://account.microsoft.com/account/)) to log on to you Windows 10 machine, you must specify “manage-as” credentials” to manage your local machine [16568455]

* When you try to manage the localhost, you will be prompted to elevate the gateway process. If you click **no** in the User Account Control popup that follows, Windows Admin Center won't be able to display it again. In this case, exit the gateway process by right-clicking the Windows Admin Center icon in the system tray and choosing exit, then relaunch Windows Admin Center from the Start Menu.

* Windows 10 does not have WinRM/PowerShell remoting on by default
  
  * To enable management of the Windows 10 Client, you must issue the command ```Enable-PSRemoting``` from an elevated PowerShell prompt.

  * You may also need to update your firewall to allow connections from outside the local subnet with ```Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any```. For more restrictive networks scenarios, please refer to [this documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-5.1).

## Failover Cluster Manager solution

* When managing a cluster, (either Hyper-Converged or traditional?) you may encounter a **shell was not found** error. If this happens either reload your browser, or navigate away to another tool and back. [13882442]

* An issue can occur when managing a down-level (Windows Server 2012 or 2012 R2) cluster that hasn't been configured completely. The fix for this issue is to ensure that the Windows feature **RSAT-Clustering-PowerShell** has been installed and enabled on **each member node** of the cluster. To do this with PowerShell, enter the command `Install-WindowsFeature -Name RSAT-Windows-PowerShell` on all the cluster nodes. [12524664]

* The Cluster may need to be added with the entire FQDN to be discovered correctly.

* When connecting to a cluster using Windows Admin Center installed as a gateway, and providing explicit username/password to authenticate, you must select **Use these credentials for all connections** so that the credentials are available to query the member nodes.

## Hyper-Converged Cluster Manager solution

* Some commands such as **Drives - Update firmware**, **Servers - Remove** and **Volumes - Open** are disabled and currently not supported.