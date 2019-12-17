---
title: Ensure sufficient physical disk space is available when virtual machines use differencing virtual hard disks
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 71f99aab-f994-4022-9da0-d661965b95ac
author: KBDAzure
ms.date: 8/16/2016
---
# Ensure sufficient physical disk space is available when virtual machines use differencing virtual hard disks

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*One or more virtual machines are using differencing virtual hard disks.*  
  
## Impact  
*Differencing virtual hard disks require available space on the hosting volume so that space can be allocated when writes to the virtual hard disks occur. If available space is exhausted, any virtual machine that relies on the physical storage could be affected. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Monitor available disk space to ensure sufficient space is available for virtual hard disk expansion. Consider merging differencing virtual hard disks into their parent. In Hyper-V Manager, inspect the differencing disk to determine the parent virtual hard disk. If you merge a differencing disk to a parent disk that is shared by other differencing disks, that action will corrupt the relationship between the other differencing disks and the parent disk, making them unusable. After verifying that the parent virtual hard disk is not shared, you can use the Edit Disk Wizard to merge the differencing disk to the parent virtual hard disk.*  
  


