---
title: Determine When Intersite Replication Is Scheduled to Begin
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b7316784-ad2e-4b00-9c74-33a2bf148c26
author: Femila
---
# Determine When Intersite Replication Is Scheduled to Begin
  Before you restart a domain controller that has been disconnected and shipped to a branch site, if the domain controller is the only domain controller for the domain in the site, the domain controller must be updated from the hub site. You can minimize the time that the domain controller is out of synchronization with domain controllers in the hub site by timing the restart to coincide with intersite replication. You can use this procedure to determine when intersite replication between sites is scheduled to begin.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine when intersite replication is scheduled to begin  
  
1.  Open Active Directory Sites and Services: Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, double\-click the **Sites** container, double\-click the **Inter\-Site Transports** container, and then click the **IP** container.  
  
3.  In the details pane, right\-click the site link object for which you want to view the schedule, and then click **Properties**.  
  
4.  In the *SiteLinkName***Properties** dialog box, click **Change Schedule**. Note the block of days and hours during which replication is allowed \(**Replication Available**\), and then click **OK** or **Cancel**.  
  
5.  In **Replicate every \_\_\_\_\_ minutes**, note the number of minutes for the intervals at which replication polling takes place during an open schedule window, and then click **OK**.  
  
  