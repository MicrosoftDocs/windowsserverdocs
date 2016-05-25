---
title: Create a Connection Object on the Operations Master and Standby
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 03ef3e0c-355a-49b2-9263-371b34bf284c
author: Femila
---
# Create a Connection Object on the Operations Master and Standby
  To ensure that the current operations master role holder and the standby operations master are replication partners, you can manually create connection objects between the two domain controllers. Even if a connection object is generated automatically, we recommend that you manually create a connection object on both the operations master and the standby operations master. The replication system can alter automatically created connection objects anytime. Manually created connections remain the same until an administrator changes them.  
  
 You can use this procedure to create the following:  
  
-   A manual connection object that designates the standby server as the From Server on the NTDS Settings object of the operations master  
  
-   A manual connection object that designates the operations master server as the From Server on the NTDS Settings object of the standby server  
  
 **Administrative credentials**  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a connection object on the operations master and standby  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  Expand the site name in which the current operations master role holder is located to display the **Servers** folder.  
  
3.  Expand the **Servers** folder to see a list of the servers in that site.  
  
4.  To create a connection object from the standby server on the current operations master, expand the name of the operations master server on which you want to create the connection object to display its NTDS Settings object.  
  
5.  Right\-click **NTDS Settings**, click **New**, and then click **Connection**.  
  
6.  In the **Find Active Directory Domain Controllers** dialog box, select the name of the standby server from which you want to create the connection object, and then click **OK**.  
  
7.  In the **New Object\-Connection** dialog box, enter an appropriate name for the connection object or accept the default name, and then click **OK**.  
  
8.  To create a connection object from the current operations master to the standby server, repeat steps 4 through 7, but in step 4, expand the name of the standby server. In step 6, select the name of the current operations master.  
  
  