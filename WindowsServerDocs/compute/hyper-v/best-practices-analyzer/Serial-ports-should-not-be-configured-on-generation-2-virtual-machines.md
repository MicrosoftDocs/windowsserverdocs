---
title: Serial ports should not be configured on generation 2 virtual machines
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.author: kathydav
ms.topic: article
ms.assetid: 87061193-dd3f-4398-aa5d-4cee83cadfa3
author: KBDAzure
ms.date: 8/16/2016
---
# Serial ports should not be configured on generation 2 virtual machines

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
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
  


