---
title: The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8bd4af5e-9e7d-4710-8950-39435a8bb373
author: KBDAzure
---
# The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*There are not enough virtual functions available for the number of running virtual machines configured for single\-root I\/O virtualization \(SR\-IOV\).*  
  
## Impact  
*Networking performance might not be optimal on the following virtual machines:*  
   
\<list of virtual machines>  
  
## Resolution  
*Consider disabling SR\-IOV on one or more virtual machines that do not require an SR\-IOV virtual function.*  
  

