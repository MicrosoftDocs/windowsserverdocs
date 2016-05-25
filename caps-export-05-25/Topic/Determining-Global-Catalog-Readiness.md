---
title: Determining Global Catalog Readiness
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 94e3348a-50c7-455f-af35-7f886f833606
author: Femila
---
# Determining Global Catalog Readiness
  After replication of the partial domain directory partitions is complete, the domain controller advertises itself as a global catalog server and begins accepting queries. Advertising begins when the occupancy level for partial domain directory partition replication has been reached. The default occupancy level requires that all partial domain directory partitions have been replicated.  
  
> [!CAUTION]  
>  If you lower the occupancy level, the domain controller advertises itself as a global catalog server before it has complete information from all domains in the forest. In this case, it might return false information to applications that begin using the server for Address Book lookup and forest\-wide searches.  
  
 You can use the procedures in this task to determine if a domain controller is ready to begin advertising itself as a global catalog server.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Ldp.exe  
  
-   Nltest.exe  
  
-   DNS snap\-in  
  
 To complete this task, perform the following procedures:  
  
1.  [Verify Global Catalog Readiness](../Topic/Verify-Global-Catalog-Readiness.md)  
  
2.  [Verify Global Catalog DNS Registrations](../Topic/Verify-Global-Catalog-DNS-Registrations.md)  
  
  