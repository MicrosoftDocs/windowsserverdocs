---
title: Associate an Existing Subnet Object with a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0d559ba1-fcde-46ac-82d4-1428562fc04e
author: Femila
---
# Associate an Existing Subnet Object with a Site
  You can use this procedure to associate an existing subnet object with a site. A subnet object identifies a range of IP addresses that map respective computers to the site with which the subnet is associated in Active Directory Domain Services \(AD DS\). Associate an existing subnet with a site under the following conditions:  
  
-   When you are removing the site to which the subnet is currently associated  
  
-   When you have temporarily associated the subnet with a different site and you want to associate the subnet with its permanent site  
  
 Membership in **Enterprise Admins** in the forest or **Domain Admins** in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To associate an existing subnet object with a site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand the **Sites** container, and then click the **Subnets** container.  
  
3.  In the details pane, right\-click the subnet with which you want to associate the site, and then click **Properties**.  
  
4.  In **Site**, click the site to associate the subnet, and then click **OK**.  
  
  