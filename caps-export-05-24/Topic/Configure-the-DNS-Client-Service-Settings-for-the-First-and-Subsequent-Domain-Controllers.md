---
title: Configure the DNS Client Service Settings for the First and Subsequent Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 10291531-4540-4a40-9131-8f53a95df12e
author: Femila
---
# Configure the DNS Client Service Settings for the First and Subsequent Domain Controllers
After you deploy an additional domain controller, you must modify the Domain Name System \(DNS\) Client service settings on the first domain controller that you deployed. Because no other domain controllers were running when you deployed the first domain controller, you must modify the DNS Client service settings on the first domain controller to include the additional domain controller.  
  
When you deploy more domain controllers, you might also want to modify the **Alternate DNS server** policy setting that you specified on existing domain controllers to ensure that this policy setting points to the DNS server that is connected through the minimum number of network segments.  
  
### To configure the DNS Client service settings on previously installed domain controllers  
  
1.  Click **Start**, **Run**, and then type **ncpa.cpl** to open Network Connections.  
  
2.  Right\-click your **Local Area Connection**, click **Properties**, click **Internet Protocol \(TCP\/IP\)** to highlight it, and then click **Properties.**  
  
3.  In **Preferred DNS server**, type the IP address of the DNS server that is running locally on the domain controller. \(That server is the local host.\)  
  
4.  Determine whether a newly installed domain controller is now closer to this domain controller than the domain controller that you originally specified to be the alternate DNS server. If a newly installed domain controller is closer, in **Alternate DNS server**, type the IP address of that domain controller.  
  
