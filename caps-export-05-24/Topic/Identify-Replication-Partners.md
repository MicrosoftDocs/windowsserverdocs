---
title: Identify Replication Partners
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4c636e87-6604-4650-a9e9-a9fce9e8f7c2
author: Femila
---
# Identify Replication Partners
  You can use this procedure to examine the connection objects for a domain controller and identify its replication partners.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To identify replication partners  
  
1.  Open Active Directory Sites and Services: On the **Start** menu, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.  
  
2.  In the console tree, double\-click the **Sites** container to display the list of sites.  
  
3.  Double\-click the site that contains the domain controller for which you want to determine connection objects.  
  
    > [!NOTE]  
    >  If you do not know the site in which the domain controller is located, open a command prompt and type **ipconfig** to get the IP address of the domain controller. Use the IP address to verify that an IP address maps to a subnet, and then determine the site association.  
  
4.  Double\-click the **Servers** folder to display the list of servers in that site.  
  
5.  Double\-click the server object for the domain controller whose replication partners you want to identify to display its NTDS Settings object.  
  
6.  Click the **NTDS Settings** object to display the list of connection objects in the details pane. \(These objects represent inbound connections that are used for replication to the server.\) The **From Server** column displays the names of the domain controllers that are source replication partners for the selected server object.  
  
  