---
title: Avoid mapping one storage path to multiple resource pools
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 24992453-762b-4892-9a50-55d237b9b7f2
author: KBDAzure
---
# Avoid mapping one storage path to multiple resource pools
[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
Note: The following sections provide details about the specific issue. Italics indicates UI text that appears in the Best Practices Analyzer tool for the specific issue.  
  
## **Issue**  
*A storage file path is mapped to multiple resource pools.*  
  
## **Impact**  
*For the specified storage pool type, the following parent and child pools share the same storage path:*  
  
\<list of pools>  
  
## **Resolution**  
*Use Windows PowerShell to reconfigure the storage resource pools so that multiple pools do not use the same storage path.*  
  

