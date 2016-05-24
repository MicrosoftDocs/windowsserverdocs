---
title: Configure a Server to Not Be a Preferred Bridgehead Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 80efebf5-6c0f-4a69-83ed-e3d0ebe3d3b8
author: Femila
---
# Configure a Server to Not Be a Preferred Bridgehead Server
  Preferred bridgehead servers are distinguished by a property on the server object that adds the server to the preferred bridgehead server list for the IP transport. If you want to remove a server from the list so that it is not a designated preferred bridgehead server, you can use this procedure to open the server object properties and remove the server from the IP transport.  
  
 Membership in the **Enterprise Admins** group in the forest or the **Domain Admins** group in the forest root domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure the server to not be a preferred bridgehead server  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then expand the site of the preferred bridgehead server.  
  
3.  Expand the **Servers** container to display the list of domain controllers that are currently configured for that site.  
  
4.  Right\-click the server that you want to remove, and then click **Properties**.  
  
5.  If **IP** appears in the list that marks this server as a bridgehead server for the IP transport, click **IP**, click **Remove**, and then click **OK**.  
  
## See Also  
 [View the List of All Preferred Bridgehead Servers](../Topic/View-the-List-of-All-Preferred-Bridgehead-Servers.md)  
  
  