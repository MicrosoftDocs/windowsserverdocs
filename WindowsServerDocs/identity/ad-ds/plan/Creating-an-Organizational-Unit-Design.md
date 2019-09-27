---
ms.assetid: b8df1828-5ead-4c90-b0fe-95c675116b7c
title: Creating an Organizational Unit Design
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Creating an Organizational Unit Design

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Forest owners are responsible for creating organizational unit (OU) designs for their domains. Creating an OU design involves designing the OU structure, assigning the OU owner role, and creating account and resource OUs.  
  
Initially, design your OU structure to enable delegation of administration. When the OU design is complete, you can create additional OU structures for the application of Group Policy to the users and computers and to limit the visibility of objects. For more information, see Designing a Group Policy Infrastructure ([https://go.microsoft.com/fwlink/?LinkId=106655](https://go.microsoft.com/fwlink/?LinkId=106655)).  
  
## OU owner role  
The forest owner designates an OU owner for each OU that you design for the domain. OU owners are data managers who control a subtree of objects in Active Directory Domain Services (AD DS). OU owners can control how administration is delegated and how policy is applied to objects within their OU. They can also create new subtrees and delegate administration of OUs within those subtrees.  
  
Because OU owners do not own or control the operation of the directory service, you can separate ownership and administration of the directory service from ownership and administration of objects, reducing the number of service administrators who have high levels of access.  
  
OUs provide administrative autonomy and the means to control visibility of objects in the directory. OUs provide isolation from other data administrators, but they do not provide isolation from service administrators. Although OU owners have control over a subtree of objects, the forest owner retains full control over all subtrees. This enables the forest owner to correct mistakes, such as an error in an access control list (ACL), and to reclaim delegated subtrees when data administrators are terminated.  
  
## Account OUs and resource OUs  
Account OUs contain user, group, and computer objects. Forest owners must create an OU structure to manage these objects and then delegate control of the structure to the OU owner. If you are deploying a new AD DS domain, create an account OU for the domain so that you can delegate control of the accounts in the domain.  
  
Resource OUs contain resources and the accounts that are responsible for managing those resources. The forest owner is also responsible for creating an OU structure to manage these resources and for delegating control of that structure to the OU owner. Create resource OUs as needed based on the requirements of each group within your organization for autonomy in the management of data and equipment.  
  
## Documenting the OU design for each domain  
Assemble a team to design the OU structure that you use to delegate control over resources within the forest. The forest owner might be involved in the design process and must approve the OU design. You might also involve at least one service administrator to ensure that the design is valid. Other design team participants might include the data administrators who will work on the OUs and the OU owners who will be responsible for managing them.  
  
It is important to document your OU design. List the names of the OUs that you plan to create. And, for each OU, document the type of OU, the OU owner, the parent OU (if applicable), and the origin of that OU.  
  
For a worksheet to assist you in documenting your OU design, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from Job Aids for Windows Server 2003 Deployment Kit ([https://go.microsoft.com/fwlink/?LinkID=102558](https://go.microsoft.com/fwlink/?LinkID=102558)) and open "Identifying OUs for Each Domain" (DSSLOGI_9.doc).  
  
## In this section  
  
-   [Reviewing OU Design Concepts](../../ad-ds/plan/Reviewing-OU-Design-Concepts.md)  
  
-   [Delegating Administration by Using OU Objects](../../ad-ds/plan/Delegating-Administration-by-Using-OU-Objects.md)  
  


