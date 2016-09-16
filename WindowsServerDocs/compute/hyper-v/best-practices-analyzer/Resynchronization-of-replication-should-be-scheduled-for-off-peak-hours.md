---
title: Resynchronization of replication should be scheduled for off-peak hours
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 093a7bb7-8e0a-486b-b42b-04edd8809710
author: KBDAzure
ms.date: 8/16/2016
---
# Resynchronization of replication should be scheduled for off-peak hours

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Resynchronization of replication for the primary virtual machines is not scheduled for off-peak hours.*  
  
## Impact  
*The longer a virtual machine is in a state requiring resynchronization, the longer the replication log files grow and the more unreplicated changes occur on the primary virtual machines. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use Hyper-V Manager to modify the replication settings for the virtual machine to perform resynchronization automatically during off-peak hours.*  
  


