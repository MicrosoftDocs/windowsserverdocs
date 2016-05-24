---
title: Determine the ISTG Role Owner for a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 941d593b-b0e2-4dbb-adff-698cf523c169
author: Femila
---
# Determine the ISTG Role Owner for a Site
  The Intersite Topology Generator \(ISTG\) is the domain controller in each site that is responsible for generating the intersite topology. If you want to regenerate the intersite topology, you must determine the identity of the ISTG role owner in a site. You can use this procedure to view the NTDS Site Settings object properties and determine the ISTG role owner for the site.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the ISTG role owner for a site  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, click the site object whose ISTG role owner you want to determine.  
  
3.  In the details pane, right\-click the **NTDS Site Settings** object, and then click **Properties**. The current role owner appears in the **Server** box under **Inter\-Site Topology Generator**.  
  
  