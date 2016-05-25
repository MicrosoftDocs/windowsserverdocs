---
title: Configure DNS Client Service Settings on the First and Subsequent Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c65565cb-501e-4ef8-ab36-31b7bd786c87
author: Femila
---
# Configure DNS Client Service Settings on the First and Subsequent Domain Controllers
After you deploy additional domain controllers, you modify the Domain Name System \(DNS\) Client service settings on the first forest root domain controller to include these domain controllers. You might also have to modify the **Alternate DNS server** setting that is specified on existing domain controllers to ensure that this setting points to the DNS server that is connected through the minimum number of network segments.  
  
For more information about configuring DNS clients, see Configuring and Managing DNS Clients \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93662](http://go.microsoft.com/fwlink/?LinkId=93662)\).  
  
Membership in the local Administrators group is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure DNS Client service settings on previously installed domain controllers  
  
1.  Click **Start**, **Run**, and type **ncpa.cpl** to open **Network Connections**.  
  
2.  Right\-click **Local Area Connection**, click **Properties**, click **Internet Protocol \(TCP\/IP\)** to highlight it, and then click **Properties.**  
  
3.  For the **Preferred DNS server**, type the IP address of the DNS server that is running locally on the domain controller, which is the local host.  
  
4.  Determine whether a newly installed domain controller is now closer to this domain controller than the domain controller that you originally specified as the **Alternate DNS server**. If it is, for **Alternate DNS server**, type the IP address of the newly installed domain controller.  
  
