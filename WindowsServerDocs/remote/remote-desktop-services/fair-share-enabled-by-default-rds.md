---
title: Fair Share technologies are enabled by default in Remote Desktop Services
description: Describes how an RDSH server uses Fair Share technology to balance CPU, disk, and network bandwidth resources among multiple Remote Desktop sessions. 
ms.date: 04/21/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, davean
ms.custom: sap:administration, csstroubleshoot
ms.technology: windows-server-rds
---
# Fair Share technologies are enabled by default in Remote Desktop Services

This article describes how a Remote Desktop Session Host (RDSH) server, Windows 10 Enterprise multi-session, Windows 11 Enterprise multi-session, and Windows Server use Fair Share technologies to balance CPU, disk, and network bandwidth resources among multiple Remote Desktop sessions.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows 10 Enterprise multi-session, Windows 11 Enterprise multi-session  
_Original KB number:_ &nbsp; 4494631

## Introduction

Fair Share technologies for CPU resources were introduced in Windows Server 2008 R2. Remote Desktop Services (RDS) server, Windows 10 Enterprise multi-session and Windows 11 Enterprise multi-session use Fair Share technology to manage resources. RDS builds on the Fair Share technologies to add features for allocating network bandwidth and disk resources. Fair Share technologies are enabled by default, but you can disable them using Windows PowerShell and WMI.

For more information about the related properties in WMI, see [Win32_TerminalServiceSetting class: Properties](/windows/desktop/termserv/win32-terminalservicesetting#properties).

## Fair Share CPU Scheduling

Fair Share CPU Scheduling dynamically distributes processor time across all RDS and Azure Virtual Desktop (AVD) multi-session sessions on the same Session Host server, based on the number of sessions and the demand for processor time within each session. This process creates a consistent user experience across all of the active sessions, while sessions are being created and deleted dynamically. This feature builds on the Dynamic Fair Share Scheduling technology (DFSS) that was part of Windows Server.

## Dynamic Disk Fair Share

When disk-intensive processes run in one or more sessions, they can starve non-disk intensive processes and prevent them from ever accessing disk resources. To fix this issue, the Dynamic Disk Fair Share feature balances disk access among the different sessions by balancing disk IO and throttling excess disk usage.

## Dynamic Network Fair Share

When bandwidth-intensive applications run in one or more sessions, they can starve applications in other sessions of bandwidth. To equalize network consumption among the sessions, the Network Fair Share feature uses a round-robin approach to allocate bandwidth for each session.

In a centralized computing scenario, the Dynamic Network Fair Share feature tries to fairly distribute network interface bandwidth load among the sessions.