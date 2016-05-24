---
title: Configure DNS Server Forwarders
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: eeb4f54a-10d4-4248-9222-77d5f978e430
author: Femila
---
# Configure DNS Server Forwarders
  You can use this procedure to configure Domain Name System \(DNS\) server forwarders.  
  
 When you add a new domain controller that is a DNS server, if your network uses forwarding for recursive name resolution, configure DNS server forwarders based on the forwarding method that is established on your network. When forwarders are configured, a DNS server that receives a DNS query for a name for which it is not authoritative forwards the request to the DNS forwarder instead of using root hints. If your network uses forwarding, use the DNS snap\-in to add the appropriate forwarders on the new domain controller. If you want the DNS Server service on the new domain controller to forward queries to different servers depending on the DNS suffix that is specified in the query, configure conditional forwarding appropriately. For information about using forwarding and conditional forwarding for DNS name resolution, see Using Forwarding \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=26353](http://go.microsoft.com/fwlink/?LinkId=26353)\).  
  
> [!NOTE]  
>  Root hints is the recommended method of recursive name resolution for Active Directory–integrated DNS in Windows Server 2008 forests. For more information about configuring DNS for Windows Server 2008 forests, see the AD DS Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116283](http://go.microsoft.com/fwlink/?LinkId=116283)\).  
  
 Membership in **Domain Admins**, or equivalent, is required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To configure DNS server forwarders  
  
1.  If your network uses root hints as the DNS forwarding method, you do not have to perform any additional options. Root hints are configured automatically during installation. Do not continue to step 2.  
  
2.  If you have to configure forwarders, open the DNS snap\-in, and continue to step 3.  
  
3.  In the console tree, right\-click *ComputerName* \(where *ComputerName* is the computer name of the domain controller\), and then click **Properties**.  
  
4.  In the *ComputerName* properties sheet \(where *ComputerName* is the name of the domain controller\), on the **Forwarders** tab, click **Edit**.  
  
5.  Click the text entry area where indicated, type an IP address or DNS name for a DNS server that will receive forwarded DNS queries, and then click **OK**.  
  
6.  When the IP address resolves to the server’s fully qualified domain name \(FQDN\) on the **Forwarders** tab, click **OK**.  
  
  