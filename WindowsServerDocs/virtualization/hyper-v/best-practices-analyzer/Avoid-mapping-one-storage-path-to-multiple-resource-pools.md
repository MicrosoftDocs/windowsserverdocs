---
title: Avoid mapping one storage path to multiple resource pools
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 24992453-762b-4892-9a50-55d237b9b7f2
author: KBDAzure
ms.date: 8/16/2016
---
# Avoid mapping one storage path to multiple resource pools

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.
  
## **Issue**  
*A storage file path is mapped to multiple resource pools.*  
  
## **Impact**  
*For the specified storage pool type, the following parent and child pools share the same storage path:*  
  
\<list of pools>  
  
## **Resolution**  
*Use Windows PowerShell to reconfigure the storage resource pools so that multiple pools do not use the same storage path.*  
  


