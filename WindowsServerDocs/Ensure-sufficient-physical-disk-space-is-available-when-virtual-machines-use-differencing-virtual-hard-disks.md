---
title: Ensure sufficient physical disk space is available when virtual machines use differencing virtual hard disks
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71f99aab-f994-4022-9da0-d661965b95ac
---
# Ensure sufficient physical disk space is available when virtual machines use differencing virtual hard disks
\[This information is preliminary and subject to change.\]

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).

|||
|-|-|
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|
|**Product\/Feature**|Hyper\-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*One or more virtual machines are using differencing virtual hard disks.*

## Impact
*Differencing virtual hard disks require available space on the hosting volume so that space can be allocated when writes to the virtual hard disks occur. If available space is exhausted, any virtual machine that relies on the physical storage could be affected. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Monitor available disk space to ensure sufficient space is available for virtual hard disk expansion. Consider merging differencing virtual hard disks into their parent. In Hyper\-V Manager, inspect the differencing disk to determine the parent virtual hard disk. If you merge a differencing disk to a parent disk that is shared by other differencing disks, that action will corrupt the relationship between the other differencing disks and the parent disk, making them unusable. After verifying that the parent virtual hard disk is not shared, you can use the Edit Disk Wizard to merge the differencing disk to the parent virtual hard disk.*


