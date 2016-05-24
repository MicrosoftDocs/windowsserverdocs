---
title: Creating Forest Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5bae37ef-27b3-4571-bc0f-4cf427560109
author: Femila
---
# Creating Forest Trusts
  You can link two disjoined Active Directory Domain Services \(AD DS\) forests together to form a one\-way or two\-way, transitive trust relationship.  You can use a two\-way, forest trust to form a transitive trust relationship between every domain in both forests.  
  
 For more information about forest trusts, see How Domain and Forest Trusts Work in \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
 **Task requirements**  
  
 The following are required to create forest trusts successfully:  
  
-   You can create a forest trust between two Windows Server 2003 forests, between two [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forests, between two [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forests, between a Windows Server 2003 forest and a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest, between a Windows Server 2003 forest and a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest, or between a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest and a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest. Forest trusts cannot be extended implicitly to a third forest.  
  
-   To create a forest trust, the minimum forest functional level for the forests that are involved in the trust relationship is Windows Server 2003. For more information about functional levels, see the Active Directory Functional Levels Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111466](http://go.microsoft.com/fwlink/?LinkID=111466)\).  
  
-   To create a forest trust successfully, you must set up your Domain Name System \(DNS\) environment properly. If there is a root DNS server that you can make the root DNS server for the DNS namespaces of both forests, make it the root DNS server by ensuring that the root zone contains delegations for each of the DNS namespaces. Also, update the root hints of all DNS servers with the new root DNS server.  
  
-   If there is no shared root DNS server and the root DNS servers for each forest DNS namespace are running Windows Server 2003, configure DNS conditional forwarders in each DNS namespace to route queries for names in the other namespace.  
  
-   If there is no shared root DNS server and the root DNS servers for each forest DNS namespace are not running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003, configure DNS secondary zones in each DNS namespace to route queries for names in the other namespace. For more information about configuring DNS to work with Active Directory Domain Services \(AD DS\), see the DNS Support for Active Directory Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=106660](http://go.microsoft.com/fwlink/?LinkID=106660)\).  
  
 You can use the following tool to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
> [!NOTE]  
>  If you have the appropriate administrative credentials for each forest, you can create both sides of a forest trust at the same time. To create both sides of the forest trust, follow the appropriate procedure below that contains the words “for both sides of the trust” in the title. For example, the procedure “Create a one\-way, incoming, forest trust for both sides of the trust” explains how to configure both sides of the trust. For more information about how the “both sides of the trust” option works, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
 To create a forest trust, perform any one of the following procedures, depending on the requirements of your organization and the administrative credentials that you have when you create the trust:  
  
-   [Create a One-Way, Incoming, Forest Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Incoming,-Forest-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Incoming, Forest Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Incoming,-Forest-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, Forest Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Forest-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, Forest Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Forest-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a Two-Way, Forest Trust for One Side of the Trust](../Topic/Create-a-Two-Way,-Forest-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a Two-Way, Forest Trust for Both Sides of the Trust](../Topic/Create-a-Two-Way,-Forest-Trust-for-Both-Sides-of-the-Trust.md)  
  
  