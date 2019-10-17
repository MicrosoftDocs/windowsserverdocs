---
title: Create an Administrative User Account
description: Create an account with administrative privileges in MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ce4c5a9-3dec-412f-910b-54a252f8f209
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Create an Administrative User Account
Create *administrative user accounts* for those individuals who will manage your MultiPoint Services system. To see who has administrative access, in MultiPoint Manager, click the **Users** tab. Administrative user accounts are displayed in the **Account Type** column as **Administrator**. *Administrative users* have access to all MultiPoint Manager tasks that change desktop and system settings, such as:  
  
-   Creating accounts  
  
-   Adding and removing programs  
  
-   Managing *desktops* and hardware  
  
-   Ending other user *sessions*  
  
Administrative users can perform tasks that affect all other users of the MultiPoint Services system, such as install software or change security settings. For this reason, administrative users should have unique user names and passwords that are known only to them.  
  
For more information about issues that you, as an administrative user, should consider as you create and manage user accounts, see the [User Account Considerations](User-Account-Considerations.md) topic.  
  
> [!NOTE]  
> You might want to create a *standard user account* for you to use when you perform tasks on the MultiPoint Services system that are not related to MultiPoint Services system management. You would then only log on to your administrative user account when you need to perform system management tasks.  
  
#### To create an administrative user account  
  
1.  In MultiPoint Manager, click the **Users** tab.  
  
2.  Under **User Tasks**, click **Add user account**. The **Add User Account** wizard opens.  
  
3.  In the **User account** field, type a logon name for the user. Typically, the logon user name is the first and last name written together without spaces, or the first initial and last name written together without a space.  
  
4.  In the **Full Name** field, type the name of the user in whatever format you prefer, such as given name, full name, or a nickname.  
  
5.  In the **Password** field, type a password for the user. The password should only be known to you and the user, and you should store this information in a secure location. The password can only be changed by an administrative user.  
  
6.  In the **Confirm password** field, retype the password, and then click **Next**.  
  
7.  On the level of access page, select **Administrative user**, and then click **Next**.  
  
8.  MultiPoint Services will check all of the information and display a message when the account has been set up. When you see the text, **A new user account was successfully created**, click **Finish**.  
