---
title: Determine Whether a Server is a Preferred Bridgehead Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5231d259-125c-484d-87da-9e7f28ef8c93
author: Femila
---
# Determine Whether a Server is a Preferred Bridgehead Server
  You can designate preferred bridgehead servers to always perform intersite replication. If you are moving a server to a different site, you must make sure that the server is not a preferred bridgehead server. If it is a preferred bridgehead server, you must configure it to not be a preferred bridgehead server before you move the server object. You can use this procedure to view the server object properties in Active Directory Domain Services \(AD DS\) and determine the bridgehead server status of the server.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine whether a server is a preferred bridgehead server  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  Expand **Sites**, and then expand the site of the server whose bridgehead server status you want determine.  
  
3.  Expand the **Servers** node to display the list of domain controllers that are currently configured for that site.  
  
4.  Right\-click the server whose status you want to check, and then click **Properties**.  
  
5.  If **IP** appears in the list that marks this server as a bridgehead server for the IP transport, the server is a preferred bridgehead server.  
  
## See Also  
 [Configure a Server to Not Be a Preferred Bridgehead Server](../Topic/Configure-a-Server-to-Not-Be-a-Preferred-Bridgehead-Server.md)   
 [View the List of All Preferred Bridgehead Servers](../Topic/View-the-List-of-All-Preferred-Bridgehead-Servers.md)  
  
  