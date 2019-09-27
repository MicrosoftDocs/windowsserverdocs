---
title: Avoid using checkpoints on a virtual machine that runs a server workload in a production environment
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 1be75890-d316-495a-b9b7-be75fc1aac10
author: KBDAzure
ms.date: 8/16/2016
---
# Avoid using checkpoints on a virtual machine that runs a server workload in a production environment

>Applies To: Windows Server 2016


  
*For more information about best practices and scans, see* [Best Practices Analyzer](https://go.microsoft.com/fwlink/?LinkId=122786).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

> [!NOTE]  
> In Windows Server 2012 R2, virtual machine snapshots were renamed to virtual machine checkpoints in Hyper-V Manager to match the terminology used in System Center Virtual Machine Management. For details, see [Checkpoints and Snapshots Overview](https://technet.microsoft.com/library/dn818483.aspx).  
  
## Issue  
  
*A virtual machine with one or more checkpoints has been found.*  
  
## Impact  
  
*Available space may run out on the physical disk that stores the checkpoints files. If this occurs, no additional disk operations can be performed on the physical storage. Any virtual machine that relies on the physical storage could be affected.*  
  
If physical disk space runs out, any running virtual machine that has checkpoints or virtual hard disks stored on that disk may be paused automatically. Hyper-V Manager shows the status of these virtual machines as "paused-critical".  
  
## Resolution  
  
*If the virtual machine runs a server workload in a production environment, take the virtual machine offline and then use Hyper-V Manager to apply or delete the checkpoints. To delete checkpoints, you must shut down the virtual machine to complete the process.*  
  
> [!NOTE]  
> Production checkpoints are now available as an alternative to standard checkpoints. For details, see [Choose between standard or production checkpoints](../manage/Choose-between-standard-or-production-checkpoints-in-Hyper-V.md).  
  


