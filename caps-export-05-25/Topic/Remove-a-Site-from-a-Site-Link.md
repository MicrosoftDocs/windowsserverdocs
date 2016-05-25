---
title: Remove a Site from a Site Link
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b2bad3d4-e97c-4a60-b11e-2055a3ec1213
author: Femila
---
# Remove a Site from a Site Link
  If you change the site topology and want to remove a site from a site link, or if you are removing a site from the enterprise, you can use this procedure to remove a site from a site link in Active Directory Domain Services \(AD DS\). If you are adding a site to a different site link, you must first remove the site from its current site link.  
  
 Membership in **Enterprise Admins** in the forest or **Domain Admins** in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To remove a site from a site link  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand the **Sites** container and then the **Inter\-Site Transports** container.  
  
3.  Click **IP**. In the details pane, right\-click the site link from which you want to remove a site, and then click **Properties**.  
  
4.  In **Sites in this site link**, click the site that you want to remove from the site link.  
  
5.  Click **Remove**, and then click **OK**.  
  
  