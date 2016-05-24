---
title: Verify DNS Client Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1a70674d-00d6-4053-bf8b-53544c5952b4
author: Femila
---
# Verify DNS Client Settings
  After you install an additional domain controller, verify the DNS Client service settings on the new domain controller. If you use the Active Directory Domain Services Installation Wizard to install a domain controller, the wizard configures the DNS Client service settings, as follows:  
  
-   The preferred Domain Name System \(DNS\) server is added to the DNS servers list of the DNS client settings.  
  
-   The alternate DNS server is unchanged, but 127.0.0.1 is added.  
  
> [!NOTE]  
>  If IP version 6 \(IPv6\) is enabled, IPv6 addresses are used instead of IP version 4 \(IPv4\) addresses.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify the DNS client settings  
  
1.  In Server Manager, click **View  Network Connections**.  
  
2.  Right\-click the connection that represents the connection that the domain controller uses to attach to the network, and then click **Properties**.  
  
3.  In **Connection Properties**, double\-click **Internet Protocol Version 4 \(TCP\/IPv4\)** or **Internet Protocol Version 6 \(TCP\/IPv6\)**.  
  
4.  In **Internet Protocol \(TCP\/IP\) Properties**, verify that **Use the following DNS server addresses** is selected.  
  
5.  Verify that the **Preferred DNS server** IP address is the IP address of the new domain controller \(so that it is referencing itself\). Verify that the **Alternate DNS server** address is that of another DNS server in the same domain.  
  
6.  Click **OK** twice.  
  
## See Also  
 [Verify DNS Server Configuration for a Domain Controller](../Topic/Verify-DNS-Server-Configuration-for-a-Domain-Controller.md)  
  
  