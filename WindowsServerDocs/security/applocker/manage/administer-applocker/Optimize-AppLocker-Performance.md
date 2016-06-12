---
title: Optimize applocker Performance
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c41739f-c8a7-43c8-ace5-1fbd2d0ad217
---
# Optimize applocker Performance
This topic describes how to optimize applocker policy enforcement in  Windows Server 2012  and Windows 8.

## Optimization of Group Policy
applocker policies can be implemented by organization unit \(OU\) using Group Policy. If so, your Group Policy infrastructure should be optimized and retested for performance when applocker policies are added to existing Group Policy Objects \(GPOs\) or new GPOs are created, as you do with adding any policies to your GPOs.

For additional information, see the [Optimizing Group Policy Performance](http://go.microsoft.com/fwlink/?LinkId=163238) article in TechNet Magazine \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=163238\).

### applocker rule limitations
The more rules per GPO, the longer applocker requires for evaluation. There is no set limitation on the number of rules per GPO, but the number of rules that can fit into a 100 MB GPO varies based on the complexity of the rule, such as the number of file hashes included in a single file hash condition.

### Using the DLL rule collection
When the DLL rule collection is enabled, applocker must check each DLL that an application loads. The more DLLs, the longer applocker requires to complete the evaluation.

## See Also
[applocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)


