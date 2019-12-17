---
title: The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 8bd4af5e-9e7d-4710-8950-39435a8bb373
author: KBDAzure
ms.date: 8/16/2016
---
# The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*There are not enough virtual functions available for the number of running virtual machines configured for single-root I/O virtualization (SR-IOV).*  
  
## Impact  
*Networking performance might not be optimal on the following virtual machines:*  
   
\<list of virtual machines>  
  
## Resolution  
*Consider disabling SR-IOV on one or more virtual machines that do not require an SR-IOV virtual function.*  
  


