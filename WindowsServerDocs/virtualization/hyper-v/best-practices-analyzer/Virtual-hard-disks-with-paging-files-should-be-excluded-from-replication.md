---
title: Virtual hard disks with paging files should be excluded from replication
description: Learn what to do when paging files experience a high volume of input/output activity, which will unnecessarily require much greater resources to participate in replication.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: c0be8a5f-64a1-488a-944e-bb913bb90517
ms.date: 8/16/2016
---
# Virtual hard disks with paging files should be excluded from replication

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Information|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*Paging files should be excluded from participating in replication, but no disks have been excluded.*

## Impact
*Paging files experience a high volume of input/output activity, which will unnecessarily require much greater resources to participate in replication. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*If you have not already done so, create a separate virtual hard disk for the Windows paging file. If initial replication has already been completed, use Hyper-V Manager to remove replication. Then, configure replication again and exclude the virtual hard disk with the paging file from replication.*
