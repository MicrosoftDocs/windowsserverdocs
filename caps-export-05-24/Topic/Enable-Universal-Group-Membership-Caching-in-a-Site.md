---
title: Enable Universal Group Membership Caching in a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e7f1a3ed-8338-4fe2-b329-ccfa3c91133c
author: Femila
---
# Enable Universal Group Membership Caching in a Site
  In a branch site that has no global catalog server and in a forest that has multiple domains, you can use this procedure to enable Universal Group Membership Caching on a domain controller in the site so that a global catalog server does not have to be contacted across a wide area network \(WAN\) link for every initial user logon. You enable this setting on the NTDS Site Settings object for the site in Active Directory Domain Services \(AD DS\), and you can specify the site of a global catalog server to contact when the cache must be updated. In most cases, the closest global catalog server is located in the hub site.  
  
 You can use this procedure to enable Universal Group Membership Caching in a site.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable Universal Group Membership Caching in a site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then click the site in which you want to enable Universal Group Membership Caching.  
  
3.  In the details pane, right\-click the **NTDS Site Settings** object, and then click **Properties**.  
  
4.  Under **Universal Group Membership Caching**, select **Enable Universal Group Membership Caching**.  
  
5.  In the **Refresh cache from** list, click the site that you want the domain controller to contact when the Universal Group membership cache must be updated, and then click **OK**.  
  
  