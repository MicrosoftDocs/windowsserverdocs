---
title: Update the IP Address for a DNS Delegation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f12713b5-1225-47a4-981a-2edf80b7a3fa
author: Femila
---
# Update the IP Address for a DNS Delegation
  If you change the IP address of a domain controller that is a Domain Name System \(DNS\) server, you must update the IP address in the delegation for the DNS server in the DNS zone for the parent domain. You can use this procedure to update the IP address of a delegation for a domain controller that is also a DNS server.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To update the IP address for a DNS delegation  
  
1.  Open the DNS snap\-in: On the **Start** menu, point to **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, if you are connected to a DNS server that hosts the parent zone, go to step 4. If you are not connected to a DNS server that hosts the parent zone, right\-click **DNS** and then click **Connect to DNS Server**.  
  
3.  Click **The following computer**, type the name of the DNS server that hosts the parent zone, and then click **OK**.  
  
4.  In the console tree, double\-click the server node for a DNS server that hosts the parent zone, double\-click **Forward Lookup Zones**, and then double\-click the parent zone.  
  
5.  In the console tree, right\-click the delegated zone of the DNS server whose IP address has changed, and then click **Properties**.  
  
6.  On the **Name Servers** tab, click the DNS server whose IP address has changed, and then click **Edit**.  
  
7.  In the **IP Address** list, click the address, and then type changes as necessary.  
  
8.  Click **OK** twice.  
  
  