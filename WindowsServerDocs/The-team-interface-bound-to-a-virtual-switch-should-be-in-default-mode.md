---
title: The team interface bound to a virtual switch should be in default mode
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8c118e1e-865f-4cff-acdc-7c35e45d5da9
author: KBDAzure
---
# The team interface bound to a virtual switch should be in default mode
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*Some virtual switches are bound to a team interface but the team interface doesn’t pass traffic on all VLANs to the virtual switches.*  
  
## **Impact**  
*The following virtual switches cannot have access to all VLANs: \\n{0}*  
  
## **Resolution**  
*Use Server Manager or the Windows PowerShell cmdlet Set\-NetLbfoTeamNic to reset the team interface to the default mode.*  
  

