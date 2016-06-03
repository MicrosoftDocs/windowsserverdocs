---
title: Virtual hard disks with paging files should be excluded from replication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0be8a5f-64a1-488a-944e-bb913bb90517
author: KBDAzure
---
# Virtual hard disks with paging files should be excluded from replication
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../../../includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Information|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Paging files should be excluded from participating in replication, but no disks have been excluded.*  
  
## Impact  
*Paging files experience a high volume of input\/output activity, which will unnecessarily require much greater resources to participate in replication. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*If you have not already done so, create a separate virtual hard disk for the Windows paging file. If initial replication has already been completed, use Hyper\-V Manager to remove replication. Then, configure replication again and exclude the virtual hard disk with the paging file from replication.*  
  

