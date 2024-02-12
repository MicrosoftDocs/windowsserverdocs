---
title: Avoid storing Smart Paging files on a system disk
description: Learn what to do when the memory configuration for one or more virtual machines might require the use of Smart Paging if the virtual machine is rebooted, and the specified location for the Smart Paging file is the system disk of the server running Hyper-V.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 9b57c9b8-76c5-43c7-bfa6-2c95b3cb6510
ms.date: 8/16/2016
---
# Avoid storing Smart Paging files on a system disk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*The memory configuration for one or more virtual machines might require the use of Smart Paging if the virtual machine is rebooted, and the specified location for the Smart Paging file is the system disk of the server running Hyper-V.*

## Impact
*Use of the system disk for Smart Paging might cause the server running Hyper-V to experience problems. This affects the following virtual machines:*

\<list of virtual machines>

## Resolution
*Reconfigure the virtual machines to store the Smart Paging files on a non-system disk.*
