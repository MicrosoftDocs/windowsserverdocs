---
title: Changing Site Link Properties
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d3468d7d-ae2b-4423-bf12-762642442541
author: Femila
---
# Changing Site Link Properties
  To control which sites replicate directly with each other, and when, you can use the cost, schedule, and interval properties on the site link object in Active Directory Domain Services \(AD DS\). For information about how to design the site topology, see Designing the Site Topology for Windows Server 2008 AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=89026](http://go.microsoft.com/fwlink/?LinkId=89026)\).  
  
 These settings control intersite replication, as follows:  
  
-   **Schedule**: The time during which replication can occur. The default setting allows replication at all times.  
  
-   **Interval**: The number of minutes between replication polling by intersite replication partners within the open schedule window. The default setting is every 180 minutes.  
  
-   **Cost**: The relative priority of the link. The default setting is 100. Lower relative cost increases the priority of the link over other, higher\-cost links.  
  
 Consult your design documentation for information about the values to set for site link properties.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Configure the Site Link Schedule to Identify Times During Which Intersite Replication Can Occur](../Topic/Configure-the-Site-Link-Schedule-to-Identify-Times-During-Which-Intersite-Replication-Can-Occur.md)  
  
2.  [Configure the Site Link Interval to Identify How Often Replication Polling Can Occur During the Schedule Window](../Topic/Configure-the-Site-Link-Interval-to-Identify-How-Often-Replication-Polling-Can-Occur-During-the-Schedule-Window.md)  
  
3.  [Configure the Site Link Cost to Establish a Priority for Replication Routing](../Topic/Configure-the-Site-Link-Cost-to-Establish-a-Priority-for-Replication-Routing.md)  
  
4.  To generate the intersite topology, perform the following procedures:  
  
    1.  [Determine the ISTG Role Owner for a Site](../Topic/Determine-the-ISTG-Role-Owner-for-a-Site.md)  
  
    2.  [Generate the Replication Topology on the ISTG](../Topic/Generate-the-Replication-Topology-on-the-ISTG.md)  
  
  