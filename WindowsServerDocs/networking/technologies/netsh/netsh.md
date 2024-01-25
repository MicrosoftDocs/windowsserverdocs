---
title: Network Shell (Netsh)
description: This topic provides an overview of the Network Shell (netsh) command-line utility in Windows Server.
ms.topic: article
ms.assetid: aedef092-8445-4e53-b9d4-525ecd98b02d
manager: dougkim
ms.author: jgerend
author: JasonGerend
ms.date: 01/25/2023
---

# Network shell \(netsh\)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

Network shell (netsh) is a command-line utility that allows you to configure and display the status of various network communications server roles and components after they are installed on computers running Windows Server.

Some client technologies, such as Dynamic Host Configuration Protocol \(DHCP\) client and BranchCache, also provide netsh commands that allow you to configure client computers that are running Windows 10.

In most cases, netsh commands provide the same functionality that is available when you use the Microsoft Management Console \(MMC\) snap\-in for each networking server role or networking feature. For example, you can configure Network Policy Server \(NPS\) by using either the NPS MMC snap-in or the netsh commands in the **netsh nps** context.

In addition, there are netsh commands for network technologies, such as for IPv6, network bridge, and Remote Procedure Call \(RPC\), that are not available in Windows Server as an MMC snap-in.

>[!IMPORTANT]
>It is recommended that you use Windows PowerShell to manage networking technologies in [Windows Server and Windows 10](/powershell/windows/get-started) rather than Network Shell. Network Shell is included for compatibility with your scripts and its use is supported.

## Netsh technical reference

The [netsh command reference](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754516(v=ws.10)) provides a comprehensive list of netsh commands, including syntax, parameters, and examples. You can use this reference to build scripts and batch files by using netsh commands for local or remote management of network technologies and devices.

---
