---
title: Verify DNS Server Configuration for a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 973a7231-590b-4ca5-a663-7082898a5154
author: Femila
---
# Verify DNS Server Configuration for a Domain Controller
  You can use this procedure to verify DNS Server service configuration on a new additional domain controller that has Domain Name System \(DNS\) installed. Verify that resource records are registered so that clients can locate the DNS server. Verify also that the forest and domain DNS zone application directory partitions have replicated so that the DNS server receives zone updates.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify DNS server configuration for a domain controller  
  
1.  Open the DNS snap\-in: On the **Start** menu, point to **Administrative Tools**, and then click **DNS**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  Double\-click **Forward Lookup Zones**, and verify that the zone \_msdcs.*ForestRootDomain* and the zone for the domain of the new domain controller are present.  
  
3.  Click the domain node, and then, in the details pane, verify that host \(A\) resource records, IPv6 host \(AAAA\) resource records \(if TCP\/IPv6 addresses are in use\), and name server \(NS\) resource records are present for the new domain controller.  
  
4.  To verify that the ForestDnsZones and DomainDnsZones application directory partitions replicated successfully, open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
5.  At the command prompt, type the following command, and then press ENTER:  
  
     `repadmin /showrepl`  
  
6.  Verify that the DC\=DomainDnsZones,DC\=*DomainName*,…,DC\=*ForestRootDomainName*,DC\=com and DC\=ForestDnsZones,DC\=*ForestRootDomainName*,DC\=com application directory partitions replicated successfully.  
  
## See Also  
 [Verify DNS Client Settings](../Topic/Verify-DNS-Client-Settings.md)  
  
  