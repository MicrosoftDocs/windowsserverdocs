---
title: Network Shell (Netsh)
description: This topic provides an overview of the Network Shell (netsh) command-line utility in Windows Server.
ms.topic: article
ms.assetid: aedef092-8445-4e53-b9d4-525ecd98b02d
manager: dougkim
ms.author: jgerend
author: JasonGerend
ms.date: 07/16/2021
---

# Network Shell \(Netsh\)

>Applies to: Azure Stack HCI, version 20H2; Windows Server 2019, Windows Server 2016

Network shell (netsh) is a command-line utility that allows you to configure and display the status of various network communications server roles and components after they are installed on computers running Windows Server.

Some client technologies, such as Dynamic Host Configuration Protocol \(DHCP\) client and BranchCache, also provide netsh commands that allow you to configure client computers that are running Windows 10.

In most cases, netsh commands provide the same functionality that is available when you use the Microsoft Management Console \(MMC\) snap\-in for each networking server role or networking feature. For example, you can configure Network Policy Server \(NPS\) by using either the NPS MMC snap-in or the netsh commands in the **netsh nps** context.

In addition, there are netsh commands for network technologies, such as for IPv6, network bridge, and Remote Procedure Call \(RPC\), that are not available in Windows Server as an MMC snap-in.

>[!IMPORTANT]
>It is recommended that you use Windows PowerShell to manage networking technologies in [Windows Server and Windows 10](/powershell/windows/get-started) rather than Network Shell. Network Shell is included for compatibility with your scripts, however, and its use is supported.

## Network Shell (Netsh) Technical Reference

The Netsh Technical Reference provides a comprehensive netsh command reference, including syntax, parameters, and examples for netsh commands. You can use the Netsh Technical Reference to build scripts and batch files by using netsh commands for local or remote management of network technologies on computers running Windows Server and Windows 10.

### Content availability

The Network Shell Technical Reference is available for download in Windows Help \(*.chm\) format from TechNet Gallery: [Netsh Technical Reference](https://gallery.technet.microsoft.com/Netsh-Technical-Reference-c46523dc)

---
