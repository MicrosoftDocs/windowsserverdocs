---
title: Best Practices for Administering Domain and Forest Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ed7a370a-8384-422f-8e8a-8c5ac6109fa5
author: Femila
---
# Best Practices for Administering Domain and Forest Trusts
  The following best practices increase availability, ensure trouble\-free operations, or ease administration when you use them to administer domain and forest trusts:  
  
-   **Optimize authentication speed in multidomain forests.**  
  
     When your forest contains domain trees with many child domains and you observe noticeable user authentication delays between the child domains, you can optimize the user authentication process between the child domains by creating shortcut trusts to mid\-level domains in the domain tree hierarchy.  
  
     For more information, see "When to create a shortcut trust" in Understanding When to Create a Shortcut Trust \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=107061](http://go.microsoft.com/fwlink/?LinkID=107061)\).  
  
-   **Keep a current list of trust relationships for future reference.**  
  
     You can use the Nltest.exe tool to display and record a list of these trusts. For more information, see Nltest Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93567](http://go.microsoft.com/fwlink/?LinkID=93567)\).  
  
-   **Back up domain controllers.**  
  
     Perform regular backups of domain controllers to preserve all trust relationships within a particular domain.  
  
  