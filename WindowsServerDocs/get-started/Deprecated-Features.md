---
title: Features Removed or Deprecated in Windows Server 2016
description: A list of features and functionalities in Windows Server 2016 that have either been removed from the product in the current release or are planned for potential removal in subsequent releases (deprecated). It is intended for IT professionals who are updating operating systems in a commercial environment.
ms.prod: windows-server
ms.technology: server-general
ms.topic: article
ms.date: 08/22/2019
ms.assetid: 5d10c5f9-ebac-49a0-b808-c0b1702e0437
author: jasongerend
ms.author: jgerend
manager: dougkim
ms.localizationpriority: medium
---
# Features Removed or Deprecated in  Windows Server 2016

>Applies to: Windows Server 2016

The following is a list of features and functionalities in Windows Server 2016 that have either been removed from the product in the current release or are planned for potential removal in subsequent releases (deprecated). It is intended for IT professionals who are updating operating systems in a commercial environment. This list is subject to change in subsequent releases and may not include every deprecated feature or functionality. For more details about a particular feature or functionality and its replacement, see the documentation for that feature.

> [!TIP]
> For info on what's been removed or deprecated in newer versions, see [Features removed or planned for replacement in Windows Server](../get-started-19/removed-features.md).

## Features removed from Windows Server 2016

The following features and functionalities have been removed from this release of Windows Server 2016. Applications, code, or usage that depend on these features will not function in this release unless you employ an alternate method.  

> [!NOTE]  
> If you are moving to Windows Server 2016 from a server release prior to Windows Server 2012 R2 or Windows Server 2012, you should also review [Features Removed or Deprecated in Windows Server 2012 R2](https://technet.microsoft.com/library/dn303411.aspx) and [Features Removed or Deprecated in Windows Server 2012](https://technet.microsoft.com/library/hh831568.aspx).  

### Share and Storage Management

The Share and Storage Management snap-in for Microsoft Management Console has been removed. Instead, do any of the following:  

-   If the computer you want to manage is running an operating system older than Windows Server 2016, connect to it with Remote Desktop and use the local version of the Share and Storage Management snap-in.  

-   On a computer running Windows 8.1 or earlier, use the Share and Storage Management snap-in from RSAT to view the computer you want to manage.  

-   Use Hyper-V on a client computer to run a virtual machine running Windows 7, Windows 8, or Windows 8.1 that has the Share and Storage Management snap-in in RSAT.  

### Journal.dll

The Journal.dll is removed from Windows Server 2016. There is no replacement.  

### Security Configuration Wizard

The Security Configuration Wizard is removed. Instead, features are secured by default. If you need to control specific security settings, you can use either Group Policy or [Microsoft Security Compliance Manager](https://technet.microsoft.com/solutionaccelerators/cc835245.aspx).  

### SQM

The opt-in components that manage participation in the Customer Experience Improvement Program have been removed. 

### Windows Update

The **wuauclt.exe /detectnow** command has been removed and is no longer supported. To trigger a scan for updates, do either of the following:

- Run these PowerShell commands:
    ````powershell
    $AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"
    $AutoUpdates.DetectNow()
    ````

- Alternately, use this VBScript:
    ````vb
    Set automaticUpdates = CreateObject("Microsoft.Update.AutoUpdate")
    automaticUpdates.DetectNow()
    ````

## Features deprecated starting with Windows Server 2016

The following features and functionalities are deprecated starting with this release. Eventually, they will be completely removed from the product, but they are still available in this release, sometimes with certain functionality removed. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features.  

### Configuration tools  

-   **Scregedit.exe** is deprecated. If you have scripts that depend on Scregedit.exe, adjust them to use Reg.exe or Windows PowerShell methods.  

-   **Sconfig.exe** is deprecated. Use [Sconfig.cmd](https://docs.microsoft.com/windows-server/get-started/sconfig-on-ws2016) instead. 

### NetCfg custom APIs

Installation of PrintProvider, NetClient, and ISDN using NetCfg custom APIs is deprecated.  

### Remote management  

WinRM.vbs is deprecated. Instead, use functionality in the WinRM provider of Windows PowerShell.  

### SMB

SMB 2+ over NetBT is deprecated. Instead, implement SMB over TCP or RDMA. 
