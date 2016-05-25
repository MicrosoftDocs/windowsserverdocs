---
title: Update the DNS Delegation Records
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1f5eb63c-10cf-40cd-b9ec-97880f7385c5
author: Femila
---
# Update the DNS Delegation Records
  
> [!IMPORTANT]  
> We strongly recommend that you install Domain Name System \(DNS\) when you run the Active Directory Domain Services Installation Wizard. If you do this, the wizard creates the DNS zone delegation automatically. The procedure below describes the manual method of delegating the DNS zone for the forest root domain.  
  
After you install the DNS Server service on new domain controllers, update the DNS delegation for the forest root domain on a DNS server that is authoritative for the parent zone.  
  
-   For more information about installing and configuring a DNS server, see Deploying Domain Name System \(DNS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93656](http://go.microsoft.com/fwlink/?LinkId=93656)\).  
  
-   For more information about DNS resource records, see Resource records reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93657](http://go.microsoft.com/fwlink/?LinkId=93657)\).  
  
### To update the DNS delegation records for additional domain controllers  
  
1.  Create a name server \(NS\) resource record in the parent zone.  
  
    Use the leftmost label of the fully qualified DNS name of the forest root domain and the fully qualified DNS name of the domain controller: forest\_root\_domain in NS domain\_controller\_name.  
  
2.  Create a host \(A or AAAA\) resource record in the parent zone.  
  
    Use the fully qualified DNS name of the domain controller and the IP address or addresses of the domain controller: domain\_controller\_name in a domain\_controller\_ip\_address.  
  
