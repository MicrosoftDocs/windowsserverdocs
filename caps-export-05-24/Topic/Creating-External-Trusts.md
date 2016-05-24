---
title: Creating External Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b72f618b-a21a-4833-9d89-dda2f07dd33f
author: Femila
---
# Creating External Trusts
  You can create an external trust to form a one\-way or two\-way, nontransitive trust with domains that are outside your forest. External trusts are sometimes necessary when users need access to resources that are located in a Windows NT 4.0 domain or in a domain that is in a separate Active Directory Domain Services \(AD DS\) forest that is not joined by a forest trust.  
  
 For example, if you have a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain whose users want to gain access to resources that are stored in a Windows NT–based domain, you must create a trust relationship in which the Windows NT–based domain trusts the users from the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain. In this case, the Windows NT–based domain is the trusting domain, and the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain is the trusted domain.  
  
-   You can create an external trust between two Windows Server 2003–based or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domains, between a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain and a Windows Server 2003–based domain, or between a Windows Server 2003–based domain or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain and a Windows NT–based domain. External trusts cannot be extended implicitly to a third domain.  
  
-   To create an external trust successfully, you must set up your Domain Name System \(DNS\) environment properly. If there is a root DNS server that you can make the root DNS server for the DNS namespaces of both forests, make that server the root DNS server by ensuring that the root zone contains delegations for each of the DNS namespaces. Also, update the root hints of all DNS servers with the new root DNS server.  
  
-   If there is no shared root DNS server and the root DNS servers for each forest DNS namespace are running Windows Server 2003, configure DNS conditional forwarders in each DNS namespace to route queries for names in the other namespace.  
  
-   If there is no shared root DNS server and the root DNS servers for each forest DNS namespace are not running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 , configure DNS secondary zones in each DNS namespace to route queries for names in the other namespace. For more information about configuring DNS to work with AD DS, see DNS Support for Active Directory Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=106660](http://go.microsoft.com/fwlink/?LinkID=106660)\).  
  
 For more information about external trusts, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111481](http://go.microsoft.com/fwlink/?LinkId=111481)\).  
  
> [!NOTE]  
>  Trusts that are created between Windows NT 4.0 domains and AD DS domains are one way and nontransitive, and they require NetBIOS name resolution.  
  
 **Task requirements**  
  
 You can use either of the following tools to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
-   Netdom.exe  
  
 For more information about how to use the Netdom command\-line tool to create an external trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
> [!NOTE]  
>  If you have the appropriate administrative credentials for each domain, you can create both sides of an external trust at the same time. To create both sides of the trust simultaneously, follow the appropriate procedure below that contains the words “both sides of the trust” in the procedure title. For example, the procedure “Create a one\-way, incoming, external trust for both sides of the trust” provides the steps to follow when you have the administrative credentials for both domains and you want to use the New Trust Wizard to create an incoming, external trust in one operation. For more information about how the “both sides of the trust” option works, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
 To complete the task of creating an external trust, you can perform any of the following procedures, depending on the requirements of your organization and the administrative credentials that you have when you create the trust:  
  
-   [Create a One-Way, Incoming, External Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Incoming,-External-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Incoming, External Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Incoming,-External-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, External Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Outgoing,-External-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, External Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Outgoing,-External-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a Two-Way, External Trust for One Side of the Trust](../Topic/Create-a-Two-Way,-External-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a Two-Way, External Trust for Both Sides of the Trust](../Topic/Create-a-Two-Way,-External-Trust-for-Both-Sides-of-the-Trust.md)  
  
  