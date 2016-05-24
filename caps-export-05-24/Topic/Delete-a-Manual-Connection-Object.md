---
title: Delete a Manual Connection Object
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ede7f8e5-5fdc-4b74-b2c7-56410f349927
author: Femila
---
# Delete a Manual Connection Object
  If you are removing a server object that has a manual connection object, you must remove the corresponding connection object on the destination domain controller. The Knowledge Consistency Checker \(KCC\) does not remove manual connection objects automatically. If the source \(“replicate from”\) server in the connection is being removed and you no longer need a manual connection object on the destination server, delete the connection object from the destination server.  
  
 You can use this procedure to delete a manual connection object.  
  
 Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To delete a manual connection object  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, expand **Sites**, and then expand the site of the server whose manual connection object you want to delete.  
  
3.  Expand **Servers**, and then expand the server object whose manual connection object you want to delete.  
  
4.  Click the **NTDS Settings** object of the server object, and then, in the details pane, view the **Name** column to find a connection object that has a name other than **\<automatically generated\>**.  
  
5.  Usually, a manual connection object is named for the source server. To be sure, right\-click the connection object and then, in **Replicate from**, note the server name in the **Server** box. This is the source server from which this connection transfers replication updates to the destination server whose NTDS Settings object you have selected.  
  
6.  If you no longer want the destination server to explicitly use this server as its replication source, right\-click the manual connection object, and then click **Delete**.  
  
  