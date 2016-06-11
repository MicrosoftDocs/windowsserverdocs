---
title: Service Administrator Scope of Authority
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: eb65d55c-c647-4aeb-b369-137bd5e455e2
author: Femila
---
# Service Administrator Scope of Authority
If you choose to participate in an Active Directory forest, you must trust the forest owner and the service administrators. The forest owners are responsible for selecting and managing the service administrators; therefore, when you trust a forest owner, you also trust the service administrators that the forest owner manages. These service administrators have access to all of the resources in the forest. Before making the decision to participate in a forest, it is important to understand that the forest owner and the service administrators will have full access to your data. You cannot prevent this access.  
  
All service administrators in a forest have full control over all data and services on all computers in the forest. Service administrators have the capability to do the following:  
  
-   Correct errors on access control lists \(ACLs\) of objects. This enables the service administrator to read, modify, or delete objects regardless of the ACLs that are set on those objects.  
  
-   Modify the system software on a domain controller to bypass normal security checks. This enables the service administrator to view or manipulate any object in the domain, regardless of the ACL on the object.  
  
-   Use the Restricted Groups security policy to grant to any user or group administrative access to any computer joined to the domain. In this way, service administrators can obtain control of any computer joined to the domain regardless of the intentions of the computer owner.  
  
-   Reset passwords or change group memberships for users.  
  
-   Gain access to other domains in the forest by modifying the system software on a domain controller. Service administrators can affect the operation of any domain in the forest, view or manipulate forest configuration data, view or manipulate data stored in any domain, and view or manipulate data stored on any computer joined to the forest.  
  
For this reason, groups that store data in organizational units \(OUs\) in the forest and that join computers to a forest must trust the service administrators. For a group to join a forest, it must choose to trust all service administrators in the forest. This involves ensuring that:  
  
-   The forest owner can be trusted to act in the interests of the group and does not have reason to act maliciously against the group.  
  
-   The forest owner appropriately restricts physical access to domain controllers. Domain controllers within a forest cannot be isolated from one another. It is possible for an attacker who has physical access to a single domain controller to make offline changes to the directory database and, by doing so, interfere with the operation of any domain in the forest, view or manipulate data stored anywhere in the forest, and view or manipulate data stored on any computer joined to the forest. For this reason, physical access to domain controllers must be restricted to trusted personnel.  
  
-   You understand and accept the potential risk that trusted service administrators can be coerced into compromising the security of the system.  
  
Some groups might determine that the collaborative and cost\-saving benefits of participating in a shared infrastructure outweigh the risks that service administrators will misuse or will be coerced into misusing their authority. These groups can share a forest and use OUs to delegate authority. However, other groups might not accept this risk because the consequences of a compromise in security are too severe. These groups require separate forests.  
  

