---
title: View the List of All Preferred Bridgehead Servers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e8ee4a33-820f-458f-ba0d-4dc42e2b1e1a
author: Femila
---
# View the List of All Preferred Bridgehead Servers
  When you manage preferred bridgehead servers or when you move a server object, you might want to identify the domain controllers that are preferred bridgehead servers. Preferred bridgehead servers are distinguished by a property on the server object that adds the server to the preferred bridgehead server list for the IP transport. A back\-link attribute on the IP transport object shows the entire list. If you want to check all servers for preferred bridgehead server status, rather than a single server, you can use this procedure to view the list of all preferred bridgehead servers.  
  
 Membership in **Domain Users**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To view the list of preferred bridgehead servers  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  Expand the **Sites** container and the **Inter\-Site Transports** container.  
  
3.  Right\-click the **IP** container, and then click **Properties**.  
  
4.  Click **Filter**, and then, under **Show read\-only attributes**, click **Backlinks**.  
  
5.  In **Attributes**, double\-click **bridgeheadServerListBL**.  
  
6.  If any preferred bridgehead servers are selected in any site in the forest, the **Values** box displays the distinguished name for each server object that is currently selected as a preferred bridgehead server.  
  
## See Also  
 [Determine Whether a Server is a Preferred Bridgehead Server](../Topic/Determine-Whether-a-Server-is-a-Preferred-Bridgehead-Server.md)   
 [Configure a Server to Not Be a Preferred Bridgehead Server](../Topic/Configure-a-Server-to-Not-Be-a-Preferred-Bridgehead-Server.md)  
  
  