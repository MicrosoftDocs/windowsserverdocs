---
title: More than one network adapter should be available
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 59940e56-e06a-490f-90ea-cf30d9f80b09
author: KBDAzure
---
# More than one network adapter should be available
\[This information is preliminary and subject to change.\]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../../../includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
## Issue  
  
*This server is configured with one network adapter, which must be shared by the management operating system and all virtual machines that require access to a physical network.*  
  
## Impact  
  
*Networking performance may be degraded in the management operating system.*  
  
## Resolution  
  
*Add more network adapters to this computer. To reserve one network adapter for exclusive use by the management operating system, do not configure it for use with an external virtual network.*  
  
For information about adding a network adapter to the computer, consult the documentation for the computer or the network adapter. Then, to reserve it exclusively for the management operating system, don't connect it to a virtual switch.   
  

