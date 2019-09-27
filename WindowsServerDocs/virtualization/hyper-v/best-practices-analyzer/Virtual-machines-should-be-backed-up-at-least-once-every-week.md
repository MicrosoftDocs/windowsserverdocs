---
title: Virtual machines should be backed up at least once every week
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 7dbd3dfc-c873-4a77-89f7-3166e18d9531
author: KBDAzure
ms.date: 8/16/2016
---
# Virtual machines should be backed up at least once every week

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*One or more virtual machines have not been backed up in the past week.*  
  
## Impact  
*Significant data loss might occur if the virtual machine encounters a problem and a recent backup does not exist. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Schedule a backup of the virtual machines to run at least once a week. You can ignore this rule if this virtual machine is a replica and its primary virtual machine is being backed up, or if this is the primary virtual machine and its replica is being backed up.*  
  


