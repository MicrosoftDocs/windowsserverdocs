---
title: Features removed or no longer developed starting with Windows Server 2016
description: Learn about the features and functionalities removed or no longer developed starting with Windows Server 2016.
ms.topic: conceptual
author: jasongerend
ms.author: jgerend
manager: femila
ms.date: 8/16/2021
ms.prod: windows-server
ms.assetid: 5d10c5f9-ebac-49a0-b808-c0b1702e0437
---

# Features Removed or Deprecated in  Windows Server 2016

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server 2016.

> [!TIP]
>
> - You can get early access to Windows Server builds by joining the [Windows Insider Program for Business](https://insider.windows.com/for-business) - this is a great way to test feature changes.

**The list is subject to change and might not include every affected feature or functionality.**

## Features we've removed in this release

We're removing the following features and functionalities from the installed product image in Windows Server 2016. Applications or code that depend on these features won't function in this release unless you use an alternate method.

> [!NOTE]
> If you are moving to Windows Server 2016 from a server release prior to Windows Server 2012 R2 or Windows Server 2012, you should also review [Features Removed or Deprecated in Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn303411(v=ws.11)) and [Features Removed or Deprecated in Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831568(v=ws.11)).

| Feature | Explanation |
|--|--|
| Share and Storage Management snap-in for Microsoft Management Console | If the computer you want to manage is running an operating system older than Windows Server 2016, connect to it with Remote Desktop and use the local version of the Share and Storage Management snap-in. On a computer running Windows 8.1 or earlier, use the Share and Storage Management snap-in from RSAT to view the computer you want to manage. Use Hyper-V on a client computer to run a virtual machine running Windows 7, Windows 8, or Windows 8.1 that has the Share and Storage Management snap-in in RSAT. |
| Journal.dll | The file `Journal.dll` is removed from Windows Server 2016. There is no replacement. |
| Security Configuration Wizard | The Security Configuration Wizard is removed. Instead, features are secured by default. If you need to control specific security settings, you can use either Group Policy or Microsoft Security Compliance Manager. |
| SQM | The opt-in components that manage participation in the Customer Experience Improvement Program have been removed. |
| Windows Update | The **wuauclt.exe /detectnow** command has been removed and is no longer supported. To trigger a scan for updates, run these PowerShell commands:<br/><br/>`$AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"`<br/>`$AutoUpdates.DetectNow()` |

## Features we're no longer developing

We're no longer actively developing these features and may remove them from a future update. Some features have been replaced with other features or functionality, while others are now available from different sources.

| Feature | Explanation |
|--|--|
| Configuration tools | `scregedit.exe` is deprecated. If you have scripts that depend on scregedit.exe, adjust them to use reg.exe or PowerShell methods.|
| Sconfig.exe | Use [Sconfig.cmd](./sconfig-on-ws2016.md) instead. |
| NetCfg custom APIs | Installation of PrintProvider, NetClient, and ISDN using NetCfg custom APIs is deprecated. |
| Remote management | WinRM.vbs is deprecated. Instead, use functionality in the WinRM provider of PowerShell. |
| SMB 2+ over NetBT | SMB 2+ over NetBT is deprecated. Instead, implement SMB over TCP or RDMA.|
