---
title: VMQ should be enabled on VMQ-capable physical network adapters bound to an external virtual switch
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 93d1b155-bf44-46b0-bb69-d34d5b30e574
author: KBDAzure
ms.date: 8/16/2016
---
# VMQ should be enabled on VMQ-capable physical network adapters bound to an external virtual switch

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*The following network adapters are capable of virtual machine queue (VMQ) but the capability is disabled.*  
  
## **Impact**  
*Windows is unable to take full advantage of available hardware offloads on the following network adapters:*  
  
\<list of network adapters>  
  
## **Resolution**  
*Enable VMQ using the Enable-NetAdapterVmq Windows PowerShell cmdlet or using the Advanced Properties user interface for the network adapter.*  
  


