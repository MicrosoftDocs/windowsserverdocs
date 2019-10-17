---
title: Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 4bb832b8-f1aa-4c1f-a0f2-324dd53553ea
author: KBDAzure
ms.date: 8/16/2016
---
# Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*Virtual machine files or virtual hard disk files are stored on a file share that does not support at least SMB protocol version 3.0.*  
  
## **Impact**  
*Microsoft does not support this configuration. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Move the files to a file share that uses at least SMB protocol version 3.0.*  
  


