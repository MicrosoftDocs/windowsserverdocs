---
title: Avoid configuring virtual machines to allow unfiltered SCSI commands
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd4a3d78-a77f-451e-a383-d5cf45ea17cf
author: KBDAzure
---
# Avoid configuring virtual machines to allow unfiltered SCSI commands

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Operations|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*A virtual machine is configured to allow unfiltered SCSI commands.*  
  
## Impact  
  
*Bypassing SCSI command filtering poses a security risk. This configuration should be enabled only if it is required for compatibility with storage applications running in the guest operating system. The following virtual machines are configured to allow unfiltered SCSI commands:*  
  
\<list of virtual machine names>  
  
## Resolution  
  
*Contact your storage vendor to determine if this configuration is required. Also, if the management operating system or other guest operating systems are compromised or exhibit unusual behavior, reconfigure the virtual machine to block the commands.*  
  


