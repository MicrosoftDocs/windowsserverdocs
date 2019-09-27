---
title: Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 73127bdd-8086-4268-a93c-2fdf1623e91b
author: KBDAzure
ms.date: 8/16/2016
---
# Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Information|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.
  
## **Issue**  
*One or more virtual machines lack a highly available connection to Fibre Channel-based storage because those virtual machines are configured with a virtual Fibre Channel adapter that is connected to only one host bus adapter (HBA).*  
  
## **Impact**  
*A failure of the host bus adapter might block the Fibre Channel connection between the storage and the virtual machines. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Add another connection from the virtual machine to the host bus adapter and configure multipath I/O (MPIO) in the guest operating system to establish redundant Fibre Channel connections.*  
  


