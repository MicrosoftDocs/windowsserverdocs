---
title: Limit users&#39; access to the server in MultiPoint Server 2012
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4cabd4f1-a764-4be6-bc6e-0a5f5566390c
author: cfreemanwa
---
# Limit users&#39; access to the server in MultiPoint Server 2012
Whether you join the MultiPoint Server computer to an Active Directory domain or you use local user accounts, all users have access to MultiPoint Server by default. Before you allow users to log on to stations in your MultiPoint Server environment, you should restrict access to the server.  
  
Any user in the Remote Desktop Users group can log on to MultiPoint Server. By default, the user group Everyone is a member of the Remote Desktop Users group, and therefore every local user and domain user can log on to the MultiPoint Server. To restrict access to MultiPoint Server, remove the Everyone user group from the Remote Desktop Users group, and then add specific users or groups to the Remote Desktop Users group.  
  
### To add or remove users or groups from the Remote Desktop Users group  
  
1.  From the **Start** screen, open **Computer Management**.  
  
2.  In the console tree, under **Local Users and Groups**, click **Groups**.  
  
3.  Double click **Remote Desktop Users**, and follow the instructions to add or remove users.  
  
    -   To restrict general access to the server, remove the Everyone group.  
  
    -   To give your MultiPoint Server users access to stations, add each local account or each domain user or group account to the Remote Desktop Users group.  
  
