---
title: Avoid storing Smart Paging files on a system disk
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b57c9b8-76c5-43c7-bfa6-2c95b3cb6510
author: KBDAzure
---
# Avoid storing Smart Paging files on a system disk
[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
In the following sections, italics indicates text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*The memory configuration for one or more virtual machines might require the use of Smart Paging if the virtual machine is rebooted, and the specified location for the Smart Paging file is the system disk of the server running Hyper\-V.*  
  
## Impact  
*Use of the system disk for Smart Paging might cause the server running Hyper\-V to experience problems. This affects the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Reconfigure the virtual machines to store the Smart Paging files on a non\-system disk.*  
  
