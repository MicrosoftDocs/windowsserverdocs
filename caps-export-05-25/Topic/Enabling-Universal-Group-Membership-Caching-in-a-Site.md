---
title: Enabling Universal Group Membership Caching in a Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 59ada17c-5e96-4c13-aeb9-b3588c1ab8b0
author: Femila
---
# Enabling Universal Group Membership Caching in a Site
  In a multidomain forest, when a user logs on to a domain, a global catalog server must be contacted to determine the universal group memberships of the user. A universal group can contain users from other domains, and it can be applied to access control lists \(ACLs\) on objects in all domains in the forest. Therefore, universal group memberships must be ascertained at domain logon so that the user has appropriate access in the domain and in other domains during the logon session. Only global catalog servers store the memberships of all universal groups in the forest.  
  
 If a global catalog server is not available in the site when a user logs on to a domain, the domain controller must contact a global catalog server in another site.  
  
 In multidomain forests where remote sites do not have a global catalog server, the need to contact a global catalog server over a potentially slow wide are network \(WAN\) connection can be problematic and a user can potentially be unable to log on to the domain if a global catalog server is not available. You can enable Universal Group Membership Caching on domain controllers that are running Windows Server 2008 so that when the domain controller contacts a global catalog server for the user’s initial domain logon, the domain controller retrieves universal group memberships for the user. On subsequent logon requests by the same user, the domain controller uses cached universal group memberships and does not have to contact a global catalog server.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedure:  
  
-   [Enable Universal Group Membership Caching in a Site](../Topic/Enable-Universal-Group-Membership-Caching-in-a-Site.md)  
  
  