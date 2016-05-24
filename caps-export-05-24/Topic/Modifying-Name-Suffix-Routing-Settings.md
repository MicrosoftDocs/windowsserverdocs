---
title: Modifying Name Suffix Routing Settings
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 114cb9ff-105b-4fd1-9722-8f7a29008723
author: Femila
---
# Modifying Name Suffix Routing Settings
  Name suffix routing is a mechanism for managing how authentication requests are routed across [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forests and Windows Server 2003 forests that are joined by forest trusts. To simplify the administration of authentication requests, when a forest trust is created, all unique name suffixes are routed by default. A unique name suffix is a name suffix within a forest, such as a user principal name \(UPN\) suffix, Service Principal Name \(SPN\) suffix, or Domain Name System \(DNS\) forest or domain tree name, that is not subordinate to any other name suffix. For example, the DNS forest name fabrikam.com is a unique name suffix within the fabrikam.com forest.  
  
 All names that are subordinate to unique name suffixes are routed implicitly. For example, if your forest uses fabrikam.com as a unique name suffix, authentication requests for all child domains of fabrikam.com \(*childDomain*.fabrikam.com\) will be routed because the child domains are part of the fabrikam.com name suffix. Child names are displayed in the Active Directory Domains and Trusts snap\-in. If you want to exclude members of a child domain from authenticating in the specified forest, you can disable name suffix routing for that name. You can also disable routing for the forest name itself, if necessary.  
  
 For more information about name suffix routing, see Routing name suffixes across forests \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111725](http://go.microsoft.com/fwlink/?LinkId=111725)\).  
  
> [!NOTE]  
>  You cannot enable a name suffix that is the same as another name in the routing list. If the conflict is with a local UPN name suffix, you must remove the local UPN name suffix from the list before you can enable the routing name. If the conflict is with a name that is claimed by another trust partner, you must disable the name in the other trust before it can be enabled for this trust.  
  
 **Task requirements**  
  
 You can use either of the following tools to perform the procedures for this task:  
  
-   Active Directory Domains and Trusts  
  
-   Netdom.exe  
  
 For more information about using the Netdom command\-line tool to modify name suffix routing, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 To complete this task, you can perform the following procedures:  
  
-   [Modify Routing for a Forest Name Suffix](../Topic/Modify-Routing-for-a-Forest-Name-Suffix.md)  
  
-   [Modify Routing for a Subordinate Name Suffix](../Topic/Modify-Routing-for-a-Subordinate-Name-Suffix.md)  
  
-   [Exclude Name Suffixes from Routing to a Forest](../Topic/Exclude-Name-Suffixes-from-Routing-to-a-Forest.md)  
  
  