---
title: Verify DNS Server Recursive Name Resolution on the First Forest Root Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6d14309b-b692-4932-9f93-77cab5a1f903
author: Femila
---
# Verify DNS Server Recursive Name Resolution on the First Forest Root Domain Controller
If you install both the Domain Name System \(DNS\) server role and the Active Directory Domain Services \(AD DS\) role when you install AD DS, AD DS configures DNS server recursive name resolution automatically. However, if your DNS design specifies a different configuration, you can use the DNS snap\-in, Dnscmd.exe, to modify the default configuration settings.  
  
If your environment has no existing DNS infrastructure, you do not have to do additional configuration when you install AD DS and the two server roles. However, if you want to configure an internal DNS server to resolve queries for external names, then you must configure this server to forward unresolved queries to an external server, such as one in your perimeter network or one that is hosted by an Internet service provider \(ISP\). \(A perimeter network is also known as a demilitarized zone and a screened subnet.\)  
  
### To verify recursive name resolution by using forwarders  
  
1.  Log on to the server that hosts the AD DS and DNS server roles.  
  
2.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding the **Roles** node in Server Manager.  
  
3.  In the console tree, right\-click the domain controller name, and then click **Properties**.  
  
4.  On the **Forwarders** tab, verify that the IP addresses match those specified by your design.  
  
    > [!NOTE]  
    > Use DNS forwarders only if that is what your organization’s design specifies.  
  
    > [!NOTE]  
    > The Forwarders are used in the order in which you configure the IP addresses, regardless of the Internet Protocol \(IP\) preferences that you have set. For example, if you configure the Internet Protocol version 4 \(IPv4\) IP addresses before you configure the Internet Protocol version 6 \(IPv6\) addresses, forwarders use the IPv4 addresses first, even though dual\-stack computers generally prefer IPv6 addresses.  
  
For more information about DNS server forwarders, see Using Forwarders to Manage DNS Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93659](http://go.microsoft.com/fwlink/?LinkId=93659)\).  
  
### To verify iterative name resolution by using root hints  
  
1.  Log on to the server that hosts the AD DS and DNS server roles.  
  
2.  To open the DNS snap\-in, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding the **Roles** node in Server Manager.  
  
3.  In the console tree, right\-click the domain controller name, and then click **Properties**.  
  
4.  In the **Properties** for the domain controller, click the **Root Hints** tab to view root hints.  
  
