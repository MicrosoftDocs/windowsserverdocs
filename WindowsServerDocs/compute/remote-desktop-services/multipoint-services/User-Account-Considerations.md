---
title: User Account Considerations
ms.custom: na
ms.date: 07/15/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e225900b-cee9-48c9-b21c-394dc5e72b78
manager: jeffgilb
translation.priority.ht: 
  - cs-cz
  - de-de
  - es-es
  - fr-fr
  - hu-hu
  - it-it
  - ja-jp
  - ko-kr
  - nl-nl
  - pl-pl
  - pt-br
  - pt-pt
  - ru-ru
  - sv-se
  - tr-tr
  - zh-cn
  - zh-tw
---
# User Account Considerations
This topic describes issues that you, as an *administrative user*, should consider as you create and manage user accounts. You manage user accounts in the *Users tab* in [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)]. For more information, see the [Manage User Accounts](../../../compute/remote-desktop-services/multipoint-2/Manage-User-Accounts.md) topic.  
  
## User account types  
A user account is a collection of information that tells MultiPoint Services which files and folders a user can access, what changes they can make to the MultiPoint Services system, and each user’s preferences, such as desktop background. Each person accesses their own user account by using a unique user name and password. [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] supports three types of user accounts:  
  
-   *Administrative user accounts* are for individuals who will use [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)] to use and manage the MultiPoint Services system. For more information, see [Create an Administrative User Account](../../../compute/remote-desktop-services/multipoint-2/Create-an-Administrative-User-Account.md).  
  
-   *Standard user accounts* are for individuals who will regularly access stations, but will not manage the system. Typically, you should create standard user accounts for most MultiPoint Services system users. For more information, see [Create a Standard User Account](../../../compute/remote-desktop-services/multipoint-2/Create-a-Standard-User-Account.md).  
  
-   *MultiPoint Dashboard user accounts* are for individuals who use the MultiPoint Dashboard to manage standard user sessions and can log on from any station. For more information, see [Create a MultiPoint Dashboard User Account](../../../compute/remote-desktop-services/multipoint-2/Create-a-MultiPoint-Dashboard-User-Account.md).  
  
## User name and password considerations  
Administrative users can perform tasks that affect all other users of the MultiPoint Services system, such as install software or change security settings. For this reason, administrative users should have unique user names and passwords that are known only to them.  
  
One important consideration of user accounts is that each user account is allocated a unique **Documents** library in Windows Explorer that includes the **My Documents** folder. If the standard users on your MultiPoint Services system will store private documents in their **Documents** library in Windows Explorer, they too should log on to the MultiPoint Services system using a unique user name and password known only to them. For more information about storing documents in Windows Explorer, see the [Manage User Files](../../../compute/remote-desktop-services/multipoint-2/Manage-User-Files.md) topic.  
  
> [!TIP]  
> For stronger system security, all users’ passwords should be strong passwords. A strong password is one that cannot be easily guessed or cracked, is at least eight characters long, does not contain all or part of the user’s account name, and contains at least three of the four following categories of characters: uppercase characters, lowercase characters, numbers, and symbols found on a keyboard \(such as \!, @, \#\). For more information about how to create strong passwords in Windows, search for **strong passwords** in Windows Help and Support. For more information about how to use Windows Help and Support, see the [Use Windows Server Help](../../../compute/remote-desktop-services/multipoint-2/Use-Windows-Server-Help.md) topic.  
  
## See Also  
[Create an Administrative User Account](../../../compute/remote-desktop-services/multipoint-2/Create-an-Administrative-User-Account.md)  
[Create a Standard User Account](../../../compute/remote-desktop-services/multipoint-2/Create-a-Standard-User-Account.md)  
[Manage User Files](../../../compute/remote-desktop-services/multipoint-2/Manage-User-Files.md)  
[Use Windows Server Help](../../../compute/remote-desktop-services/multipoint-2/Use-Windows-Server-Help.md)  
[Manage User Accounts](../../../compute/remote-desktop-services/multipoint-2/Manage-User-Accounts.md)  
[Glossary](../../../compute/remote-desktop-services/multipoint-1/Glossary.md)  
  
