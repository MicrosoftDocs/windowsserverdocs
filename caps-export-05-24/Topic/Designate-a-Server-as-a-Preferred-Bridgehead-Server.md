---
title: Designate a Server as a Preferred Bridgehead Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 80b4bc15-41a3-4915-af5c-53f3fec14a61
author: Femila
---
# Designate a Server as a Preferred Bridgehead Server
  You can use this procedure to designate a server as a preferred bridgehead server. If you want to manually select the domain controllers that can replicate between sites, use the server object properties to designate a preferred bridgehead server on the IP transport. If you use preferred bridgehead servers, make sure to designate more than one preferred bridgehead server in the site and designate at least one preferred bridgehead server for each domain that is replicated to another site.  
  
 Before you perform this procedure, review the information about the effects of selecting bridgehead servers in [Linking Sites for Replication](../Topic/Linking-Sites-for-Replication.md).  
  
 Membership in **Enterprise Admins** or **Domain Admins** in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To designate a preferred bridgehead server  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then expand the site of the preferred bridgehead server.  
  
3.  Expand **Servers** to display the list of domain controllers that are currently configured for that site.  
  
4.  Right\-click the server that you want to designate as a preferred bridgehead server, and then click **Properties**.  
  
5.  In **Transports available for inter\-site data transfer**, click **IP**.  
  
6.  Click **Add**, and then click **OK**.  
  
  