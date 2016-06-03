---
title: Use all virtual functions for networking when they are available
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf895484-6a0d-4aa4-9a42-9fac739e875d
author: KBDAzure
---
# Use all virtual functions for networking when they are available
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../../../includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Some hardware acceleration capabilities are not being utilized*  
  
## Impact  
*This configuration might cause overall CPU utilization to be higher than necessary. Networking performance might not be optimal on the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Consider configuring the virtual network adapter for SR\-IOV if the physical hardware supports SR\-IOV and if this configuration does not conflict with the networking features required by the virtual machine.*  
  

