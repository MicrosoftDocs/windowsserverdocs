---
title: User Account Considerations
description: PRovides user account, user name, and password considerations for MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e225900b-cee9-48c9-b21c-394dc5e72b78
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# User Account Considerations
This topic describes issues that you, as an administrative user, should consider as you create and manage user accounts. You manage user accounts in the Users tab in MultiPoint Manager. For more information, see the [Manage User Accounts](Manage-User-Accounts.md) topic.  
  
## User account types  
A user account is a collection of information that tells MultiPoint Services which files and folders a user can access, what changes they can make to the MultiPoint Services system, and each user's preferences, such as desktop background. Each person accesses their own user account by using a unique user name and password. MultiPoint Services supports three types of user accounts:  
  
-   **Administrative user accounts** are for individuals who will use MultiPoint Manager to use and manage the MultiPoint Services system. For more information, see [Create an Administrative User Account](Create-an-Administrative-User-Account.md).  
  
-   **Standard user accounts** are for individuals who will regularly access stations, but will not manage the system. Typically, you should create standard user accounts for most MultiPoint Services system users. For more information, see [Create a Standard User Account](Create-a-Standard-User-Account.md).  
  
-   **MultiPoint Dashboard user accounts** are for individuals who use the MultiPoint Dashboard to manage standard user sessions and can log on from any station. For more information, see [Create a MultiPoint Dashboard User Account](Create-a-MultiPoint-Dashboard-User-Account.md).  
  
## User name and password considerations  
Administrative users can perform tasks that affect all other users of the MultiPoint Services system, such as install software or change security settings. For this reason, administrative users should have unique user names and passwords that are known only to them.  
  
One important consideration of user accounts is that each user account is allocated a unique **Documents** library in Windows Explorer that includes the **My Documents** folder. If the standard users on your MultiPoint Services system will store private documents in their **Documents** library in Windows Explorer, they too should log on to the MultiPoint Services system using a unique user name and password known only to them. For more information about storing documents in Windows Explorer, see the [Manage User Files](Manage-User-Files.md) topic.  
  
> [!TIP]  
> For stronger system security, all users' passwords should be strong passwords. A strong password is one that cannot be easily guessed or cracked, is at least eight characters long, does not contain all or part of the user's account name, and contains at least three of the four following categories of characters: uppercase characters, lowercase characters, numbers, and symbols found on a keyboard (such as !, @, #).  
  
## See Also  
[Create an Administrative User Account](Create-an-Administrative-User-Account.md)  
[Create a Standard User Account](Create-a-Standard-User-Account.md)  
[Manage User Files](Manage-User-Files.md)
[Manage User Accounts](Manage-User-Accounts.md)