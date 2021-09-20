---
title: Resynchronization of replication should be scheduled for off-peak hours
description: Learn what to do when resynchronization of replication for the primary virtual machines is not scheduled for off-peak hours.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 093a7bb7-8e0a-486b-b42b-04edd8809710
ms.date: 8/16/2016
---
# Resynchronization of replication should be scheduled for off-peak hours

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*Resynchronization of replication for the primary virtual machines is not scheduled for off-peak hours.*

## Impact
*The longer a virtual machine is in a state requiring resynchronization, the longer the replication log files grow and the more unreplicated changes occur on the primary virtual machines. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Use Hyper-V Manager to modify the replication settings for the virtual machine to perform resynchronization automatically during off-peak hours.*
