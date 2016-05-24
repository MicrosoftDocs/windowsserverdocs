---
title: Optimize AppLocker Performance
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
# Optimize AppLocker Performance
This topic describes how to optimize AppLocker policy enforcement in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
## Optimization of Group Policy  
AppLocker policies can be implemented by organization unit \(OU\) using Group Policy. If so, your Group Policy infrastructure should be optimized and retested for performance when AppLocker policies are added to existing Group Policy Objects \(GPOs\) or new GPOs are created, as you do with adding any policies to your GPOs.  
  
For additional information, see the [Optimizing Group Policy Performance](http://go.microsoft.com/fwlink/?LinkId=163238) article in TechNet Magazine \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=163238\).  
  
### AppLocker rule limitations  
The more rules per GPO, the longer AppLocker requires for evaluation. There is no set limitation on the number of rules per GPO, but the number of rules that can fit into a 100 MB GPO varies based on the complexity of the rule, such as the number of file hashes included in a single file hash condition.  
  
### Using the DLL rule collection  
When the DLL rule collection is enabled, AppLocker must check each DLL that an application loads. The more DLLs, the longer AppLocker requires to complete the evaluation.  
  
## See Also  
[AppLocker Overview \[Client\]](assetId:///1637ae87-5059-4d95-8c68-96f35cbc88c7)  
  
