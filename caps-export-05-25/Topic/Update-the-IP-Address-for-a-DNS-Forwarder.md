---
title: Update the IP Address for a DNS Forwarder
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 58584cc9-60de-43d9-a2d3-d62011075599
author: Femila
---
# Update the IP Address for a DNS Forwarder
  If you change the IP address of a domain controller that is a Domain Name System \(DNS\) server, if the server is designated as a forwarder for another DNS server you must update the IP address in the forwarder name server \(NS\) record. You can use this procedure to update the IP address of a forwarder for a domain controller that is also a DNS server.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To update the IP address for a DNS forwarder  
  
1.  Open the DNS snap\-in: On the **Start** menu, point to **Administrative Tools**, and then click **DNS**.  
  
2.  In the console tree, if you are connected to the DNS server that uses the forwarder whose IP address you want to change, go to step 4. If you are not connected to the DNS server that uses the forwarder, right\-click **DNS** and then click **Connect to DNS Server**.  
  
3.  Click **The following computer**, type the name of the DNS server that uses the forwarder, and then click **OK**.  
  
4.  In the console tree, click the node for the DNS server that uses the forwarder whose IP address has changed.  
  
5.  In the details pane, double\-click **Forwarders**.  
  
6.  In the **IP Address** list, click the address that you want to change, and then click **Edit**.  
  
7.  In the **IP Address** list, click the address, and then type changes as necessary.  
  
8.  Click **OK** twice.  
  
  