---
title: Change the Static IP Address of a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a90ebfaf-1607-49c7-9235-b1890e3089e7
author: Femila
---
# Change the Static IP Address of a Domain Controller
  If you move a domain controller to a different site, you must change the IP address of the domain controller to an IP address that maps to a subnet that is associated with the site. To change an IP address, you use the TCP\/IP client settings in the properties of the network connection. You can use this procedure to change all appropriate values in the TCP\/IP client settings on a domain controller, including preferred and alternate DNS servers, as well as Windows Internet Name Service \(WINS\) servers \(if appropriate\). Obtain these values from your design team.  
  
 If you change the static IP address of a domain controller, make sure that the IP address is included in the respective Dynamic Host Configuration Protocol \(DHCP\) scope.  
  
 You must also verify that DNS resource records are updated on the DNS server that the domain controller references as the preferred DNS server in TCP\/IP settings. In DNS, verify the values of the following resource records. If they have not updated automatically, update the IP address in these resource records:  
  
-   Host \(A\) or host \(AAAA\) resource records  
  
-   Name Server \(NS\) resource records  
  
 Use the DNS snap\-in to update the following DNS values that apply to this domain controller:  
  
-   On the **Forwarders** tab in the properties of a DNS server, update the IP address on DNS servers for which this domain controller is designated as a forwarder.  
  
-   Use the procedure [Update the IP Address for a DNS Delegation](../Topic/Update-the-IP-Address-for-a-DNS-Delegation.md) for all delegations to this domain controller.  
  
-   On the **Zone Transfers** tab in the properties of a forward lookup zone, update the IP address for any primary or seconday DNS zone transfers to this domain controller.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the static IP address of a domain controller  
  
1.  Log on locally to the domain controller whose IP address you want to change.  
  
2.  Click **Start**, point to **Administrative Tools**, click **Server Manager**, and then click **View Network Connections**.  
  
3.  In the **Network Connections** dialog box, right\-click the appropriate connection, and then click **Properties**.  
  
4.  In the **Connection Properties** dialog box, double\-click **Internet Protocol Version 4 \(TCP\/IPv4\)** or **Internet Protocol Version 6 \(TCP\/IPv6\)**.  
  
5.  In **IP address**, type the new address.  
  
6.  In **Subnet mask**, type the new subnet mask if it has changed.  
  
7.  In **Default gateway**, type the new default gateway.  
  
8.  In **Preferred DNS server**, type the address of the Domain Name System \(DNS\) server that this computer contacts if it has changed.  
  
9. In **Alternate DNS server**, type the address of the DNS server that this computer contacts if the preferred server is unavailable.  
  
10. If this domain controller uses WINS servers, click **Advanced**, and then, in the **Advanced TCP\/IP Settings** dialog box, click the **WINS** tab.  
  
11. If an address in the list is no longer appropriate, click the address, and then click **Edit**.  
  
12. In the **TCP\/IP WINS Server** dialog box, type the new address, and then click **OK**.  
  
13. Repeat steps 11 and 12 for all addresses that have to be changed, and then click **OK** twice to close the **TCP\/IP WINS Server** dialog box and the **Advanced TCP\/IP Settings** dialog box.  
  
14. Click **OK** to close the **Internet Protocol \(TCP\/IP\) Properties** dialog box.  
  
  