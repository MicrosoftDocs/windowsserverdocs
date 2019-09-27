---
title: Avoid alignment inconsistencies between virtual blocks and physical disk sectors on dynamic virtual hard disks or differencing disks
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: a17c8fd2-af81-485b-bfea-bd1ef3e43923
author: KBDAzure
ms.date: 8/16/2016
---
# Avoid alignment inconsistencies between virtual blocks and physical disk sectors on dynamic virtual hard disks or differencing disks

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
*Alignment inconsistencies were detected for one or more virtual hard disks.*  
  
### Impact  
*If the virtual hard disks are stored on physical disk that has a sector size of 4K, the virtual machine or applications that use the virtual hard disk might experience performance problems. This affects the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use the Create Virtual Hard Disk Wizard to create a new VHD-format or VHDX-format virtual hard disk and specify the existing virtual hard disk as the source disk. The new virtual hard disk will be created with alignment between the virtual blocks and physical disk.*  
  


