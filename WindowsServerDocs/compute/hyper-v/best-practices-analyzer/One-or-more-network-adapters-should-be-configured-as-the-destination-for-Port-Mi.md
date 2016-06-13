---
title: One or more network adapters should be configured as the destination for Port Mirroring
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b83c166d-f010-47c4-a4bb-02167f2e3361
author: KBDAzure
---
# One or more network adapters should be configured as the destination for Port Mirroring
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*One or more virtual machines have a network adapter configured as a source for Port Mirroring, but there is no corresponding destination on the virtual switch.*  
  
## **Impact**  
*Port Mirroring will not operate correctly for the following virtual switches and virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Use Windows PowerShell or Hyper\-V Manager to complete or correct the Port Mirroring configuration.*  
  

