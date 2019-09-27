---
title: MultiPoint Services user accounts 
description: Learn about user accounts in MultiPoint Services, especially which kind to use for different scenarios
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f3c6ce5-9b7c-45a0-83c5-3f9b9f5f48d4
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---

# Example scenarios: MultiPoint Services user accounts
What do you need to do to implement the user account scenario that you chose for your MultiPoint Services environment? The following tables describe each task to perform to configure user accounts and prepare stations for shared or individual user accounts on a stand-alone MultiPoint computer or on networked servers in a workgroup or an Active Directory domain. Choose the scenario that applies to your environment. Then follow the links in the table to complete each required configuration task.  
  
> [!NOTE]  
> If you have not yet decided how to set up your user accounts, see [Plan user accounts for your MultiPoint Services environment](Plan-user-accounts-for-your-MultiPoint-services-environment.md) for more information about how each choice affects users.  
  
## Single MultiPoint Services computer in a stand-alone environment (no network)  
  
|||  
|-|-|  
|**My users do not need to log on.** The stations can be available to anyone who walks up to them. They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a single local user account (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md)<br />3.  [Configure stations for automatic logon](Configure-stations-for-automatic-logon.md)|  
|**My users can all share the same user logon.** They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a single local user account (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md)|  
|**My users must have their own individual Windows desktop experience.**|Create a local user account for each user (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)|  
  
## Multiple MultiPoint Services computers on a network, but with no domain  
  
|||  
|-|-|  
|**My users do not need to log on.** The stations can be available to anyone who walks up to them. They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a single local user account on each server. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md) on each server<br />3.  [Configure stations for automatic logon](Configure-stations-for-automatic-logon.md) on each server|  
|**My users can all share the same user logon.** They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a single local user account on each server. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md) on each server.|  
|**My users must have their own individual Windows desktop experience.**<br /><br />-   **Option A** - My users will always use local stations connected to the same MultiPoint Services computer.<br />-   **Option B** - My users will use local stations on more than one MultiPoint Services computer.<br />-   **Option C** - My users will use remote clients on the LAN.|-   **Option A** - Create a single local user account on each server for the users of that server. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />-   **Option B** - Create local user accounts for every user on every server. **Note:** This means that each user will have a profile on each server. In other words, if they save a file in My Documents while logged onto Server A's station, they will not see the file when logging onto Server B's station. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br />-   **Option C** - Assign each user to a specific MultiPoint Services computer. Create local user accounts for the assigned users on each server. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)|  
  
## One or more MultiPoint Services computers in a domain network environment  
  
|||  
|-|-|  
|**My users do not need to log on.** The stations can be available to anyone who walks up to them. They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a domain account to log onto the servers.<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md) on each server.<br />3.  [Configure stations for automatic logon](Configure-stations-for-automatic-logon.md) on each server.|  
|**My users can all share the same user logon.** They do not need an individual Windows desktop experience that includes private folders for storing data or personalized desktops.|1.  Create a domain account for a group or for each user.<br />2.  [Allow one account to have multiple sessions](Allow-one-account-to-have-multiple-sessions.md) on each server.|  
|**My users must have their own individual Windows desktop experience.**<br /><br />-   **Option A** - Any user with a domain account can use the MultiPoint Services computer.<br />-   **Option B** - I want to limit which domain accounts can access the server.|-   **Option A** - No setup is required. By default, all domain users have access to any MultiPoint Services computer on the network.<br />-   **Option B** - Limit the access of domain user accounts to the MultiPoint Services computer. For instructions, see [Limit users access to the server](limit-users--access-to-the-server-in-multipoint-services.md).|  
|**I want to use local user accounts and manage them separately from my domain accounts.** For example, you want someone to manage MultiPoint Services but not the domain or you do not want to give domain accounts to all MultiPoint Services users.|Create one or more local user accounts on each server. (For instructions, see [Create local user accounts](Create-local-user-accounts.md).)<br /><br />**Note:** This means that each user account will have a profile on each server. In other words, if they save a file in My Documents while logged onto Server A's station, they will not see the file when logging onto Server B's station.|  