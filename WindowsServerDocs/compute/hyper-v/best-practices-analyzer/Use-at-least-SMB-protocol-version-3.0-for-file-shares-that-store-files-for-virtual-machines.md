---
title: Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.author: kathydav
ms.topic: article
ms.assetid: 4bb832b8-f1aa-4c1f-a0f2-324dd53553ea
author: KBDAzure
---
# Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
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
  


