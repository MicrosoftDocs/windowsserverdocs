---
ms.assetid: 41b56704-c6f9-4d29-af97-62123e300565
title: Reviewing OU Design Concepts
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Reviewing OU Design Concepts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The organizational unit (OU) structure for a domain includes the following:  
  
-   A diagram of the OU hierarchy  
  
-   A list of OUs  
  
-   For each OU:  
  
    -   The purpose for the OU  
  
    -   A list of users or groups that have control over the OU or the objects in the OU  
  
    -   The type of control that users and groups have over the objects in the OU  
  
The OU hierarchy does not need to reflect the departmental hierarchy of the organization or group. OUs are created for a specific purpose, such as the delegation of administration, the application of Group Policy, or to limit the visibility of objects.  
  
You can design your OU structure to delegate administration to individuals or groups within your organization that require the autonomy to manage their own resources and data. OUs represent administrative boundaries and enable you to control the scope of authority of data administrators.  
  
For example, you can create an OU called ResourceOU and use it to store all the computer accounts that belong to the file and print servers managed by a group. Then, you can configure security on the OU so that only data administrators in the group have access to the OU. This prevents data administrators in other groups from tampering with the file and print server accounts.  
  
You can further refine your OU structure by creating subtrees of OUs for specific purposes, such as the application of Group Policy or to limit the visibility of protected objects so that only certain users can see them. For example, if you need to apply Group Policy to a select group of users or resources, you can add those users or resources to an OU, and then apply Group Policy to that OU. You can also use the OU hierarchy to enable further delegation of administrative control.  
  
While there is no technical limit to the number of levels in your OU structure, for manageability we recommend that you limit your OU structure to a depth of no more than 10 levels. There is no technical limit to the number of OUs on each level. Note that Active Directory Domain Services (AD DS)-enabled applications might have restrictions on the number of characters used in the distinguished name (that is, the full Lightweight Directory Access Protocol (LDAP) path to the object in the directory) or on the OU depth within the hierarchy.  
  
The OU structure in AD DS is not intended to be visible to end users. The OU structure is an administrative tool for service administrators and for data administrators, and it is easy to change. Continue to review and update your OU structure design to reflect changes in your administrative structure and to support policy-based administration.  
  


