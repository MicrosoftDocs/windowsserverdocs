---
title: Force Replication Between Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e7a5ca25-29cf-4c9a-a33f-427f04b21675
author: Femila
---
# Force Replication Between Domain Controllers
  You can use this procedure to force Active Directory replication to occur between two domain controllers on a one\-time basis when you want changes to be replicated from the server that received the changes to a server in another site sooner than the site link schedule allows. As an alternative, you can synchronize replication with all replication partners.  
  
 Membership in **Enterprise Admins**, or equivalent, is required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To force replication over a connection  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then expand the site to which you want to force replication from the updated server.  
  
3.  Expand the **Servers** container to display the list of servers that are currently configured for that site.  
  
4.  Expand the server objects and click their **NTDS Settings** objects to display their connection objects in the details pane. Find a server that has a connection object from the server on which you made the updates.  
  
5.  Click **NTDS Settings** below the server object. In the details pane, right\-click the connection object whose **From Server** is the domain controller that has the updates that you want to replicate, and then click **Replicate Now**.  
  
6.  When the **Replicate Now** message box appears, review the information, and then click **OK**.  
  
## See Also  
 [Synchronize Replication with All Partners](../Topic/Synchronize-Replication-with-All-Partners.md)  
  
  