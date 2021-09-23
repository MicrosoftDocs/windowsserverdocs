---
title: Avoid enabling storage Quality of Service when using a differencing virtual hard disk when the parent and child virtual hard disks are on different volumes
description: Learn what to do when a differencing virtual hard disk with the parent and child virtual hard disks on different volumes has storage Quality of Service enabled.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: aa9ed408-65cf-40dc-aad2-118b54c70179
ms.date: 8/16/2016
---
# Avoid enabling storage Quality of Service when using a differencing virtual hard disk when the parent and child virtual hard disks are on different volumes

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*A differencing virtual hard disk with the parent and child virtual hard disks on different volumes has storage Quality of Service enabled.*

## **Impact**
*This configuration may result in unexpected storage Quality of Service behavior for the differencing virtual hard disk, as well as other virtual hard disks on the parent and child volumes. This impacts the following the virtual hard disks:*

\<list of virtual hard disks>

## **Resolution**
*Disable storage Quality of Service on the referenced virtual hard disks, or perform a storage migration to move the parent and the child virtual hard disk to the same volume.*
