---
title: Configuring a Global Catalog Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3cfda08a-91bf-45ce-be57-62d34e021813
author: Femila
---
# Configuring a Global Catalog Server
  When conditions in a site warrant adding a global catalog server, you can configure a domain controller to be a global catalog server. Selecting the global catalog setting on the NTDS Settings object prompts the Knowledge Consistency Checker \(KCC\) to update the topology. After the topology is updated, read\-only, partial, domain directory partitions are replicated to the designated domain controller. When replication must occur between sites to create the global catalog, the site link schedule determines when replication can occur.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
-   Repadmin.exe  
  
-   Dcdiag.exe  
  
 To complete this task, perform the following procedures.  
  
> [!NOTE]  
>  Some procedures are performed only when you are configuring the first global catalog server in a site.  
  
1.  [Determine Whether a Domain Controller Is a Global Catalog Server](../Topic/Determine-Whether-a-Domain-Controller-Is-a-Global-Catalog-Server.md)  
  
2.  [Designate a Domain Controller to Be a Global Catalog Server](../Topic/Designate-a-Domain-Controller-to-Be-a-Global-Catalog-Server.md)  
  
3.  [Monitor Global Catalog Replication Progress](../Topic/Monitor-Global-Catalog-Replication-Progress.md)  
  
4.  [Verify Successful Replication to a Domain Controller](../Topic/Verify-Successful-Replication-to-a-Domain-Controller.md)  
  
  