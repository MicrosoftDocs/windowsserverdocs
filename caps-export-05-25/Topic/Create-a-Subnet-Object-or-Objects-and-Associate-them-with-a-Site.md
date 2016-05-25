---
title: Create a Subnet Object or Objects and Associate them with a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d028a76c-bdd0-4bb0-9805-9ef9f5c7f8b7
author: Femila
---
# Create a Subnet Object or Objects and Associate them with a Site
  If you create a new site or if you enlarge a new site, you can use this procedure to create a subnet object or objects and associate them with the site in Active Directory Domain Services \(AD DS\). You can assign the appropriate network address to the subnet object so that it represents a range of TCP\/IP addresses. To accomplish this procedure, you must have the following information:  
  
-   The site with which the subnet is to be associated.  
  
-   The IP version 4 \(IPv4\) or IP version 6 \(IPv6\) subnet prefix.  
  
 Membership in the **Enterprise Admins** group in the forest or the **Domain Admins** group in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a subnet object or objects and associate them with a site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand the **Sites** container, right\-click **Subnets**, and then click **New Subnet**.  
  
3.  In **New Object \- Subnet**, in **Prefix**, type the IPv4 or IPv6 subnet prefix for the subnet.  
  
4.  In **Select a site object for this prefix**, click the site to be associated with the subnet, and then click **OK**.  
  
  