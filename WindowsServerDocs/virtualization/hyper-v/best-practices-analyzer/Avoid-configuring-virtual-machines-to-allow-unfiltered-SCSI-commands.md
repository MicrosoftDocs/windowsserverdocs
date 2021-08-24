---
title: Avoid configuring virtual machines to allow unfiltered SCSI commands
description: Learn what to do when a virtual machine is configured to allow unfiltered SCSI commands.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: dd4a3d78-a77f-451e-a383-d5cf45ea17cf
ms.date: 8/16/2016
---
# Avoid configuring virtual machines to allow unfiltered SCSI commands

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016



*For more information about best practices and scans, see* [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*A virtual machine is configured to allow unfiltered SCSI commands.*

## Impact

*Bypassing SCSI command filtering poses a security risk. This configuration should be enabled only if it is required for compatibility with storage applications running in the guest operating system. The following virtual machines are configured to allow unfiltered SCSI commands:*

\<list of virtual machine names>

## Resolution

*Contact your storage vendor to determine if this configuration is required. Also, if the management operating system or other guest operating systems are compromised or exhibit unusual behavior, reconfigure the virtual machine to block the commands.*
