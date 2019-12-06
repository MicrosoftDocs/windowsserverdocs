---
title: Use all virtual functions for networking when they are available
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: bf895484-6a0d-4aa4-9a42-9fac739e875d
author: KBDAzure
ms.date: 8/16/2016
---
# Use all virtual functions for networking when they are available

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
*Some hardware acceleration capabilities are not being utilized*  
  
## Impact  
*This configuration might cause overall CPU utilization to be higher than necessary. Networking performance might not be optimal on the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Consider configuring the virtual network adapter for SR-IOV if the physical hardware supports SR-IOV and if this configuration does not conflict with the networking features required by the virtual machine.*  
  


