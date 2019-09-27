---
title: Configure SCSI controllers only when supported by the guest operating system
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 861f194f-467e-4b07-a1c5-55b35f6327c4
author: KBDAzure
ms.date: 8/16/2016
---
# Configure SCSI controllers only when supported by the guest operating system

>Applies To: Windows Server 2016


  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*A virtual machine is configured with a SCSI controller that cannot be used because the guest operating system does not support SCSI controllers.*  
  
## Impact  
  
*Virtual machines cannot use storage attached to the SCSI controller. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
  
*Shut down the virtual machine and use Hyper-V Manager to remove the SCSI controller from the virtual machine. Then, restart the virtual machine.*  
  


