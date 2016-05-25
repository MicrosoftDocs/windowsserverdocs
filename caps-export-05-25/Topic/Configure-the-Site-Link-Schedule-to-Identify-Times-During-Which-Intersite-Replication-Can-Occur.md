---
title: Configure the Site Link Schedule to Identify Times During Which Intersite Replication Can Occur
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dd9ae7ae-e591-4056-8612-abbd9f3d6fec
author: Femila
---
# Configure the Site Link Schedule to Identify Times During Which Intersite Replication Can Occur
  If you need to change the schedule for Active Directory replication between sites, configure the site link object in Active Directory Domain Services \(AD DS\). Use the properties on the site link object to define when replication is allowed to occur between the bridgehead servers in the sites that are assigned to the site link. You can use this procedure to configure the site link schedule. Obtain the site link schedule from your design team.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure the site link schedule  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites** and **Inter\-Site Transports**, and then click **IP**.  
  
3.  In the details pane, right\-click the site link object that you want to configure, and then click **Properties**.  
  
4.  In the **SiteLinkName Properties** dialog box, click **Change Schedule**.  
  
5.  In the **Schedule for SiteLinkName** dialog box, select the block of days and hours during which you want replication to occur or not occur \(that is, be available or not available\), and then click the appropriate option.  
  
6.  Click **OK** twice.  
  
  