---
title: Create local user accounts
description: Learn abou thte three kinds of user accounts in MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 33321932-4266-4961-9924-2cb4620bfcb4
author: evaseydl
ms.author: evas
manager: scottman
---
# Create local user accounts
Three levels of local user accounts can be created in using the MultiPoint Manager: Standard User accounts; MultiPoint Dashboard users, who have limited administrative rights; and full Administrative User accounts.  
  
Use the following procedure to create a local user account on a MultiPoint server. If your environment includes multiple MultiPoint servers, and you want the user to be able to log on to any station on any server, you need to create a local user account on each of your servers. That setup has some limitations. In a domain environment, you can also let users use their domain accounts. For an overview of your options, see [Plan user accounts for your Windows MultiPoint Services environment](Plan-user-accounts-for-your-MultiPoint-services-environment.md).  
   
1.  Log on to the server as an administrator, and open MultiPoint Manager.  
  
2.  Click the **Users** tab, and then click **Add user account**.  
  
    The Add User Account Wizard opens.  
  
3.  Enter an account name and password for the new user account, and then click **Next**.  
  
4.  Select the type of user account that you want to create:  
  
    -   **Standard User** - Can log on to a station and perform user tasks, but has no access to MultiPoint Manager or the MultiPoint Server Dashboard, and cannot shut down the system.  
  
    -   **MultiPoint Dashboard User** - Has limited administrative rights. A Dashboard user can open the Dashboard and perform tasks such as logging users off the system or shutting down the MultiPoint Server computer, but the user does not have access to MultiPoint Manager.  
  
    -   **Administrative User** Has full administrative rights in MultiPoint Server. For example, an administrative user can run MultiPoint Manager, add and delete users, modify system settings, and update drivers.  
  
5.  Click **Next**, and then click **Finish** to create the user account.