---
title: Enable all virtual network adapters configured for a virtual machine
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcd350b7-4240-4359-aadd-93e7ac4d314e
author: KBDAzure
---
# Enable all virtual network adapters configured for a virtual machine
\[This information is preliminary and subject to change.\]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*One or more network adapters may be disabled in a virtual machine.*  
  
## Impact  
  
*The following virtual machines might not have network connectivity:*  
  
\<list of virtual machine names>  
  
## Resolution  
  
*Use Device Manager in the guest operating system to enable all virtual network adapters. If the adapter is not required, use Hyper\-V Manager to remove it from the virtual machine.*  
  

