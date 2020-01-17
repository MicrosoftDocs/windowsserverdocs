---
title: Limit user access to the server
description: Learn how to grant or deny access to MultiPoint Services for users and groups
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4cabd4f1-a764-4be6-bc6e-0a5f5566390c
author: evaseydl
manager: scottman
ms.author: evas
---
# Limit users' access to the Multipoint server
Whether you join MultiPoint server to an Active Directory domain or you use local user accounts, all users have access to MultiPoint server by default. Before you allow users to log on to stations in your MultiPoint Services environment, you should restrict access to the server.  
  
Any user in the Remote Desktop Users group can log on to MultiPoint server. By default, the user group Everyone is a member of the Remote Desktop Users group, and therefore every local user and domain user can log on to the MultiPoint Server. To restrict access to MultiPoint Server, remove the Everyone user group from the Remote Desktop Users group, and then add specific users or groups to the Remote Desktop Users group.  
  
## Add or remove users or groups to the Remote Desktop Users group  
  
1.  From the **Start** screen, open **Computer Management**.  
  
2.  In the console tree, under **Local Users and Groups**, click **Groups**.  
  
3.  Double click **Remote Desktop Users**, and follow the instructions to add or remove users.  
  
    -   To restrict general access to the server, remove the Everyone group.  
  
    -   To give your MultiPoint server users access to stations, add each local account or each domain user or group account to the Remote Desktop Users group.  