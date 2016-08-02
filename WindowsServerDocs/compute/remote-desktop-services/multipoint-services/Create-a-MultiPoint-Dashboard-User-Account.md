---
title: Create a MultiPoint Dashboard User Account
ms.custom: na
ms.date: 07/15/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb9d7da1-eb5e-42c0-8d59-bb6d7b007ea9
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
# Create a MultiPoint Dashboard User Account
Create *MultiPoint Dashboard user accounts* for those users who will regularly access stations, but who will not manage your MultiPoint Services system. Users with MultiPoint Dashboard user accounts can run most applications and save files, but cannot run [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)]. To see who has MultiPoint Dashboard user access, in [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)], click the **Users** tab. MultiPoint Dashboard user accounts are displayed in the **Account Type** column as **MultiPoint Dashboard User**.  
  
If your MultiPoint Services users will store private documents in Windows, each user should log on to the MultiPoint Services system using a unique user name and password.  
  
> [!NOTE]  
> For more information about issues you, as an *administrative user*, should consider as you create and manage user accounts, see the [User Account Considerations](../../../compute/remote-desktop-services/multipoint-2/User-Account-Considerations.md) topic.  
  
#### To create a MultiPoint Dashboard user account  
  
1.  In [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)], click the **Users** tab.  
  
2.  Under **User Tasks**, click **Add user account**. The **Add User Account** wizard opens.  
  
3.  In the **User account** field, type a logon name for the user.  
  
4.  In the **Full name** field, type the name of the user in whatever format you prefer, such as given name, full name, or a nickname.  
  
5.  In the **Create password** field, type a password for the user. This password should only be known to you and the user, and you should store this information in a secure location. The password can only be changed by an administrative user.  
  
6.  In the **Confirm password** field, retype the password, and then click **Next**.  
  
7.  On the level of access page, select **MultiPoint Dashboard user**, and then click **Next**.  
  
8.  [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)] will check all of the information and display a message when the account has been set up. When you see the text, **A new user account was successfully created**, click **Finish**.  
  
## See Also  
[User Account Considerations](../../../compute/remote-desktop-services/multipoint-2/User-Account-Considerations.md)  
  
