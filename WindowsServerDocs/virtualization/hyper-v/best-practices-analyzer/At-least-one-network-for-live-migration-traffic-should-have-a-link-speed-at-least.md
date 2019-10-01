---
title: At least one network for live migration traffic should have a link speed of at least 1 Gbps
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 5714df3f-f810-4618-8c93-e24881651100
author: KBDAzure
ms.date: 8/16/2016
---
# At least one network for live migration traffic should have a link speed of at least 1 Gbps

>Applies To: Windows Server 2016


  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*None of the networks for live migration traffic have a link speed of at least 1 Gbps.*  
  
## Impact  
*Live migrations might occur slowly, which could disrupt the network connection due to a TCP connection timeout.*  
  
## Resolution  
*Configure at least one live migration network with a speed of 1 Gbps or faster.*  
  
See the documentation from your network hardware vendor to find out if any of your existing network adapters can support a link speed of at least 1 Gbps.  
  


