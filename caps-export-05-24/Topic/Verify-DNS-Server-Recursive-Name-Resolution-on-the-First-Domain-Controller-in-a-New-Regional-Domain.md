---
title: Verify DNS Server Recursive Name Resolution on the First Domain Controller in a New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7bd3de20-f03a-4c67-b666-817f7b8a27dd
author: Femila
---
# Verify DNS Server Recursive Name Resolution on the First Domain Controller in a New Regional Domain
When you install Active Directory Domain Services \(AD DS\), the installation process configures Domain Name System \(DNS\) server recursive name resolution automatically. If your organization's design specifies a different configuration, you can use DNS Manager or the command\-line tool Dnscmd.exe to modify these settings.  
  
## Recursive name resolution by using root hints  
We recommend that you use root hints for recursive name resolution in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] environment because the installation process configures the root hints automatically. Configuration occurs when you specify that the DNS server is the preferred DNS server.  
  
#### To verify recursive name resolution by using root hints  
  
1.  Log on to the server that hosts the AD DS and DNS server roles.  
  
2.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding Roles in the console tree in Server Manager.  
  
3.  In the console tree, right\-click the domain controller name, and then click **Properties**.  
  
4.  To view the root hints, in the properties  for the domain controller, click the **Root Hints** tab.  
  
## Recursive name resolution by using forwarders  
Although we recommend that you use root hints for recursive name resolution in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] environment, you can use forwarding instead. Only use forwarders if that is what your design specifies. You can configure an internal DNS server to resolve queries for external names by configuring this DNS server to forward unresolved queries to an external server, such as a server in your perimeter network or one that is hosted by an Internet service provider \(ISP\).  
  
#### To verify recursive name resolution by using forwarders  
  
1.  Log on to the server that hosts the AD DS and DNS server roles.  
  
2.  To open DNS Manager, click **Start**, click **Administrative Tools**, and then click **DNS**.  
  
    > [!NOTE]  
    > You can also access DNS Manager by expanding Roles in the console tree in Server Manager.  
  
3.  In the console tree, right\-click the domain controller name, and then click **Properties**.  
  
4.  On the **Forwarders** tab, verify that the IP addresses match the IP addresses that your design specifies.  
  
    > [!NOTE]  
    > Only use forwarders if that is what your design specifies.  
  
    > [!NOTE]  
    > The forwarders are used in the order in which you configure the IP addresses, regardless of the Internet Protocol \(IP\) protocol preferences that you have set. For example, if you configure the IPversion 4 \(IPv4\) IP addresses before you configure the IP version 6 \(IPv6\) IP addresses, forwarders use the IPv4 addresses first, even though dual\-stack computers generally prefer IPv6 addresses.  
  
For more information about DNS forwarders, see Using Forwarders to Manage DNS Servers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93659](http://go.microsoft.com/fwlink/?LinkId=93659)\).  
  
