---
title: Create a Site Link Object and Add the Appropriate Sites
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a56763ca-2a81-45e9-8d33-2cdbddc42b98
author: Femila
---
# Create a Site Link Object and Add the Appropriate Sites
  You can use this procedure to create a site link object and add the appropriate sites to it. When your network grows, you might add a site or sites in Active Directory Domain Services \(AD DS\) that you want to link to another site or sites for replication. If there is no existing site link to connect a site to the site with which its domain controllers replicate, use this procedure to create a site link object in the IP container in AD DS, and add the appropriate sites to the link. To link sites for replication, create a site link object in the container for the intersite transport that will replicate the site, and then add the sites to it.  
  
 Membership in the **Enterprise Admins** group in the forest or the **Domain Admins** group in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a site link object  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  Expand **Sites**, and then expand **Inter\-Site Transports**.  
  
3.  Right\-click **IP**, and then click **New Site Link**.  
  
4.  In **Name**, type a name for the site link.  
  
5.  In **Sites not in this site link**, click a site that you want to add to the site link. Hold down the SHIFT key to click a second site that is adjacent in the list, or hold down the CTRL key to click a second site that is not adjacent in the list.  
  
6.  After you select all the sites that you want to add to the site link, click **Add**, and then click **OK**.  
  
  