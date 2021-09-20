---
title: Avoid mapping one storage path to multiple resource pools
description: Learn what to do when a storage file path is mapped to multiple resource pools.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 24992453-762b-4892-9a50-55d237b9b7f2
ms.date: 8/16/2016
---
# Avoid mapping one storage path to multiple resource pools

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
*A storage file path is mapped to multiple resource pools.*

## **Impact**
*For the specified storage pool type, the following parent and child pools share the same storage path:*

\<list of pools>

## **Resolution**
*Use Windows PowerShell to reconfigure the storage resource pools so that multiple pools do not use the same storage path.*
