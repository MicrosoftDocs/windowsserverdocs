---
title: Replication is paused for one or more virtual machines on this server
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: e1119a40-eda3-4058-8648-7df81cbc6c29
author: KBDAzure
ms.date: 8/16/2016
---
# Replication is paused for one or more virtual machines on this server

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Replication is paused for one or more of the virtual machines. While the primary virtual machine is paused, any changes that occur will be accumulated and will be sent to the Replica virtual machine once replication is resumed.*  
  
## Impact  
*As long as replication is paused, accumulated changes occurring in the primary virtual machine will consume available disk space on the primary server. After replication is resumed, there might be a large burst of network traffic to the Replica server. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Confirm that pausing replication was intended. If replication was paused to address low disk space or network connectivity, resume replication as soon as those issues are resolved.*  
  


