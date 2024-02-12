---
title: Recovery snapshots should be removed after failover
description: Learn what to do when a failed over virtual machine has one or more recovery snapshots.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 922115fa-e8dd-4055-aaf1-4a4437c5cf28
ms.date: 8/16/2016
---
# Recovery snapshots should be removed after failover

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*A failed over virtual machine has one or more recovery snapshots.*

## **Impact**
*Available space may run out on the physical disk that stores the snapshot files. If this occurs, no additional disk operations can be performed on the physical storage. Any virtual machine that relies on the physical storage could be affected. This impacts the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*For each failed over virtual machine, use the Complete-VMFailover cmdlet in Windows PowerShell to remove the recovery snapshots and indicate failover completion.*
