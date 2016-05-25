---
title: Understanding AppLocker Rule Exceptions
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 938bf0e5-18a0-431a-95c6-8387198d2061
---
# Understanding AppLocker Rule Exceptions
This topic describes the result of applying AppLocker rule exceptions to rule collections.  
  
You can apply AppLocker rules to individual users or a group of users. If you apply a rule to a group of users, all users in that group are affected by that rule. If you need to allow a subset of a user group to use an application, you can create a special rule for that subset.  
  
For example, the rule "Allow Everyone to run Windows except Registry Editor" allows everyone in the organization to run Windows but does not allow anyone to run Registry Editor. The effect of this rule would prevent users such as help desk personnel from running a program that is necessary for their support tasks. To resolve this problem, create a second rule that applies to the Helpdesk user group: "Allow Helpdesk to run Registry Editor." If you create a deny rule that does not allow any users to run Registry Editor, the deny rule will override the second rule that allows the Helpdesk user group to run Registry Editor.  
  
## See Also  
[How AppLocker Works](../Topic/How-AppLocker-Works.md)  
  
