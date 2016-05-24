---
title: Creating Realm Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f0de6f0d-5035-48e2-bd1c-b286aa725a6a
author: Femila
---
# Creating Realm Trusts
  You can create a realm trust to form a one\-way or two\-way, nontransitive or transitive trust with non\-Windows Kerberos realms in your organization. You can create the trust when you are logged on to the domain, or you can use the **Run as** command to create the trust for a different domain.  
  
 For more information about realm trusts, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
 **Task requirements**  
  
 You can use either of the following tools to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
-   Netdom.exe  
  
 For more information about how to use the Netdom command\-line tool to create a realm trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
> [!NOTE]  
>  The New Trust Wizard in the Active Directory Domains and Trusts snap\-in does not support the creation of both sides of a realm trust at the same time. For more information about how the “both sides of the trust” option works, see the section "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
 To create a realm trust, perform any of the following procedures, depending on the requirements of your organization and the administrative credentials that you have when you create the trust:  
  
-   [Create a One-Way, Incoming, Realm Trust](../Topic/Create-a-One-Way,-Incoming,-Realm-Trust.md)  
  
-   [Create a One-Way, Outgoing, Realm Trust](../Topic/Create-a-One-Way,-Outgoing,-Realm-Trust.md)  
  
-   [Create a Two-Way, Realm Trust](../Topic/Create-a-Two-Way,-Realm-Trust.md)  
  
  