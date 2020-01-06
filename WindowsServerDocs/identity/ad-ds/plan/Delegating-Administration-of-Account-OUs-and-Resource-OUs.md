---
ms.assetid: 19feca0e-a6d0-4d27-93b0-cb44f8c26484
title: Delegating Administration of Account OUs and Resource OUs
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Delegating Administration of Account OUs and Resource OUs

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Account organizational units (OUs) contain user, group, and computer objects. Resource OUs contain resources and the accounts that are responsible for managing those resources. The forest owner is responsible for creating an OU structure to manage these objects and resources and for delegating control of that structure to the OU owner.  
  
## Delegating administration of account OUs  
Delegate an account OU structure to data administrators if they need to create and modify user, group, and computer objects. The account OU structure is a subtree of OUs for each account type that must be independently controlled. For example, the OU owner can delegate specific control to various data administrators over child OUs in an account OU for users, computers, groups, and service accounts.  
  
The following illustration shows one example of an account OU structure.  
  
![delegating administration](media/Delegating-Administration-of-Account-OUs-and-Resource-OUs/66d38fbe-e8eb-42d7-abab-9526243bf6d9.gif)  
  
The following table lists and describes the possible child OUs that you can create in an account OU structure.  
  
|OU|Purpose|  
|------|-----------|  
|Users|Contains user accounts for nonadministrative personnel.|  
|Service Accounts|Some services that require access to network resources run as user accounts. This OU is created to separate service user accounts from the user accounts contained in the users OU. Also, placing the different types of user accounts in separate OUs enables you to manage them according to their specific administrative requirements.|  
|Computers|Contains accounts for computers other than domain controllers.|  
|Groups|Contains groups of all types except for administrative groups, which are managed separately.|  
|Admins|Contains user and group accounts for data administrators in the account OU structure to allow them to be managed separately from regular users. Enable auditing for this OU so that you can track changes to administrative users and groups.|  
  
The following illustration shows one example of an administrative group design for an account OU structure.  
  
![delegating administration](media/Delegating-Administration-of-Account-OUs-and-Resource-OUs/be2cd2d2-6956-429c-a53a-369e6fe40b2b.gif)  
  
Groups that manage the child OUs are granted full control only over the specific class of objects that they are responsible for managing.  
  
The types of groups that you use to delegate control within an OU structure are based on where the accounts are located relative to the OU structure that is to be managed. If the admin user accounts and the OU structure all exist within a single domain, the groups that you create to use for delegation must be global groups. If your organization has a department that manages its own user accounts and exists in more than one geographical region, you might have a group of data administrators who are responsible for managing account OUs in more than one domain. If the accounts of the data administrators all exist in a single domain and you have OU structures in multiple domains to which you need to delegate control, make those administrative accounts members of global groups and delegate control of the OU structures in each domain to those global groups. If the data administrators accounts to which you delegate control of an OU structure come from multiple domains, you must use a universal group. Universal groups can contain users from different domains, and therefore, they can be used to delegate control in multiple domains.  
  
## Delegating administration of resource OUs  
Resource OUs are used to manage access to resources. The resource OU owner creates computer accounts for servers that are joined to the domain that include resources such as file shares, databases, and printers. The resource OU owner also creates groups to control access to those resources.  
  
The following illustration shows the two possible locations for the resource OU.  
  
![delegating administration](media/Delegating-Administration-of-Account-OUs-and-Resource-OUs/6667a5ce-34d6-48a9-9974-b823ba70e2af.gif)  
  
The resource OU can be located under the domain root or as a child OU of the corresponding account OU in the OU administrative hierarchy. Resource OUs do not have any standard child OUs. Computers and groups are placed directly in the resource OU.  
  
The resource OU owner owns the objects within the OU but does not own the OU container itself. Resource OU owners manage only computer and group objects; they cannot create other classes of objects within the OU, and they cannot create child OUs.  
  
> [!NOTE]  
> The creator or owner of an object has the ability to set the access control list (ACL) on the object regardless of the permissions that are inherited from the parent container. If a resource OU owner can reset the ACL on an OU, that owner can create any class of object in the OU, including users. For this reason, resource OU owners are not permitted to create OUs.  
  
For each resource OU in the domain, create a global group to represent the data administrators who are responsible for managing the content of the OU. This group has full control over the group and computer objects in the OU but not over the OU container itself.  
  
The following illustration shows the administrative group design for a resource OU.  
  
![delegating administration](media/Delegating-Administration-of-Account-OUs-and-Resource-OUs/8a3f7714-a3bf-43f7-b999-6070543248b0.gif)  
  
Placing the computer accounts into a resource OU gives the OU owner control over the account objects but does not make the OU owner an administrator of the computers. In an Active Directory domain, the Domain Admins group is, by default, placed in the local Administrators group on all computers. That is, service administrators have control over those computers. If resource OU owners require administrative control over the computers in their OUs, the forest owner can apply a Restricted Groups Group Policy to make the resource OU owner a member of the Administrators group on the computers in that OU.  
  


