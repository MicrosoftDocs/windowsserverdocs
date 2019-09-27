---
title: Ensure sufficient physical disk space is available when virtual machines use dynamically expanding virtual hard disks
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 9e3e3e64-4b3a-4b9d-acf1-e4df61a04f1e
author: KBDAzure
ms.date: 8/16/2016
---
# Ensure sufficient physical disk space is available when virtual machines use dynamically expanding virtual hard disks

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
*One or more virtual machines are using dynamically expanding virtual hard disks.*  
  
## Impact  
*Dynamically expanding virtual hard disks require available space on the hosting volume so that space can be allocated when writes to the virtual hard disks occur. If available space is exhausted, any virtual machine that relies on the physical storage could be affected. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Monitor available disk space to ensure sufficient space is available for expansion. Consider shutting down the virtual machine and use the Edit Disk Wizard in Hyper-V Manager to convert each dynamically expanding virtual hard disk for this virtual machine to a fixed sized virtual hard disk.*  
  


