---
title: Optimize AppLocker Performance
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-applocker
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c41739f-c8a7-43c8-ace5-1fbd2d0ad217
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Optimize AppLocker Performance

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how to optimize AppLocker policy enforcement in Windows Server 2012 and Windows 8.

## Optimization of Group Policy
AppLocker policies can be implemented by organization unit (OU) using Group Policy. If so, your Group Policy infrastructure should be optimized and retested for performance when AppLocker policies are added to existing Group Policy Objects (GPOs) or new GPOs are created, as you do with adding any policies to your GPOs.

For additional information, see the [Optimizing Group Policy Performance](http://go.microsoft.com/fwlink/?LinkId=163238) article in TechNet Magazine (http://go.microsoft.com/fwlink/?LinkId=163238).

### AppLocker rule limitations
The more rules per GPO, the longer AppLocker requires for evaluation. There is no set limitation on the number of rules per GPO, but the number of rules that can fit into a 100 MB GPO varies based on the complexity of the rule, such as the number of file hashes included in a single file hash condition.

### Using the DLL rule collection
When the DLL rule collection is enabled, AppLocker must check each DLL that an application loads. The more DLLs, the longer AppLocker requires to complete the evaluation.




