---
title: Removing the Global Catalog
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0baf8eb2-2d30-47aa-adf0-37ac0e3d92c5
author: Femila
---
# Removing the Global Catalog
  Removing the global catalog from a domain controller simply requires clearing the **Global Catalog** check box on the NTDS Settings object properties page in Active Directory Sites and Services. As soon as this operation is complete, the domain controller stops advertising itself as a global catalog server \(that is, Net Logon deregisters the global\-catalog\-related records in Domain Name System \(DNS\)\), and the domain controller immediately stops accepting Lightweight Directory Access Protocol \(LDAP\) requests over ports 3268 and 3269. Global catalog directory partitions are removed gradually in the background.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Clear the Global Catalog Setting](../Topic/Clear-the-Global-Catalog-Setting.md)  
  
2.  [Monitor Global Catalog Removal in Event Viewer](../Topic/Monitor-Global-Catalog-Removal-in-Event-Viewer.md)  
  
  