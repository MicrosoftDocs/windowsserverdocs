---
title: Serial ports should not be configured on generation 2 virtual machines
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 87061193-dd3f-4398-aa5d-4cee83cadfa3
author: KBDAzure
ms.date: 8/16/2016
---
# Serial ports should not be configured on generation 2 virtual machines

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
*One or more generation 2 virtual machines have a serial port configured.*  
  
## **Impact**  
*Performance might be affected for the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*If this is intentional, no further action is required. Otherwise, consider using Hyper-V Manager or Windows PowerShell to remove the connection string from the serial ports on the virtual machine.*  
  


