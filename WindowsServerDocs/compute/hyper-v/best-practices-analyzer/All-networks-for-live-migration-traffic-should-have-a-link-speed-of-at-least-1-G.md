---
title: All networks for live migration traffic should have a link speed of at least 1 Gbps
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 89411b63-bec8-463d-b486-107548ed440e
author: KBDAzure
---
# All networks for live migration traffic should have a link speed of at least 1 Gbps

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*None of the networks for live migration traffic have a link speed of at least 1 Gbps.*  
  
## Impact  
*Live migrations might occur slowly, which could disrupt the network connection due to a TCP connection timeout.*  
  
## Resolution  
*Configure at least one live migration network with a speed of 1 Gbps or faster.*  
  
See the documentation from your network hardware vendor to find out if any of your existing network adapters can support a link speed of at least 1 Gbps.  
  


