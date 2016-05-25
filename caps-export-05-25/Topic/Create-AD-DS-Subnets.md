---
title: Create AD DS Subnets
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 96e281d8-ffaf-495b-a11b-9ddb2ec59b02
author: Femila
---
# Create AD DS Subnets
Create the Active Directory Domain Services \(AD DS\) subnets that are specified in the site topology design that is provided by your design team.  
  
Membership in Enterprise Admins group in the forest or the Domain Admins group in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create an AD DS subnet  
  
1.  To open the Active Directory Sites and Services snap\-in, click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In Active Directory Sites and Services, in the console tree, right\-click **Subnets**, and then click **New Subnet**.  
  
3.  In **Prefix**, type the Internet Protocol version 4 \(IPv4\) or Internet Protocol version 6 \(IPv6\) subnet prefix.  
  
4.  In **Select a site object for this prefix**, click the site to associate with this subnet, and then click **OK**.  
  
