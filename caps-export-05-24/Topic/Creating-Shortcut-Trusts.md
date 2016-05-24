---
title: Creating Shortcut Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: de05b594-011a-468d-bfd6-17edb4d590a1
author: Femila
---
# Creating Shortcut Trusts
  A shortcut trust is a manually created trust that shortens the trust path to improve the speed at which authentications, which occur between domain trees, are processed. This can result in faster logon times and faster access to resources. A trust path is a chain of multiple trusts that enables trust between domains that are not adjacent in the domain namespace. For example, if users in domain A need to gain access to resources in domain C, you can create a direct link from domain A to domain C through a shortcut trust relationship, bypassing domain B in the trust path.  
  
 For more information about shortcut trusts, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
 **Task requirements**  
  
 You can use either of the following tools to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
-   Netdom.exe  
  
 For more information about how to use the Netdom command\-line tool to create a shortcut trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
> [!NOTE]  
>  If you have the appropriate administrative credentials for each domain, you can create both sides of a shortcut trust at the same time. To create both sides of the trust, follow the appropriate procedure below that contains the words “for both sides of the trust” in the title. For example, the procedure “Create a one\-way, incoming, shortcut trust for both sides of the trust” explains how to configure both sides of a shortcut trust. For more information about how the “both sides of the trust” option works, see the section "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
 To complete the task of creating a shortcut trust, perform any of the following procedures, depending on the requirements of your organization and the administrative credentials that you have when you create the trust:  
  
-   [Create a One-Way, Incoming, Shortcut Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Incoming,-Shortcut-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Incoming, Shortcut Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Incoming,-Shortcut-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, Shortcut Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Shortcut-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a One-Way, Outgoing, Shortcut Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Shortcut-Trust-for-Both-Sides-of-the-Trust.md)  
  
-   [Create a Two-Way, Shortcut Trust for One Side of the Trust](../Topic/Create-a-Two-Way,-Shortcut-Trust-for-One-Side-of-the-Trust.md)  
  
-   [Create a Two-Way, Shortcut Trust for Both Sides of the Trust](../Topic/Create-a-Two-Way,-Shortcut-Trust-for-Both-Sides-of-the-Trust.md)  
  
  