---
title: Configure the Site Link Cost to Establish a Priority for Replication Routing
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c5bd3a2b-7165-45c1-848a-f94d831f64e4
author: Femila
---
# Configure the Site Link Cost to Establish a Priority for Replication Routing
  The cost setting on a site link object determines the likelihood that replication occurs over a particular route between two site. Relication routes with the lowest cumulative cost are preferred. You can use this procedure to configure replication cost on the site link object in Active Directory Domain Services \(AD DS\). When you create or modify site links, use the site link object properties to configure the relative cost of using the site link.  
  
 To perform this procedure, you must have site topology information that includes the cost values for the sight links that you want to manage. The cost that you set in this procedure must be determined relative to existing or planned costs of other site links. You can use any range of numbers; only their relative values \(higher or lower\) are important.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure the site link cost  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites** and **Inter\-Site Transports**, and then click **IP**.  
  
3.  In the details pane, right\-click the site link object that you want to configure, and then click **Properties**.  
  
4.  In **Cost**, specify the number for the comparative cost of using the site link, and then click **OK**.  
  
  