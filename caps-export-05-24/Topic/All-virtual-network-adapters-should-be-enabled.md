---
title: All virtual network adapters should be enabled
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b17d647d-a34a-44de-ada6-01a2bf5eeb48
author: KBDAzure
---
# All virtual network adapters should be enabled
\[This information is preliminary and subject to change.\]  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*One or more virtual network adapters associated with a physical network adapter are disabled in the management operating system.*  
  
## Impact  
  
*The configuration of this server is not optimal.*  
  
The management operating system can't connect to a physical \(external\) network using one of the physical network adapters on this computer because it's associated with a disabled virtual network adapter.  
  
## Resolution  
  
*Use Network &  Internet Settings to enable the virtual network adapter. Or, use Virtual Switch Manager to reconfigure the external virtual switch so that it is not shared with the management operating system.*  
  
