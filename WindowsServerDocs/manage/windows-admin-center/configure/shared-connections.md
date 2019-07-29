---
title: Configure shared connections for all users of the Windows Admin Center gateway
description: Learn how administrators can configure their Windows Admin Center (Project Honolulu) gateway once to let all users share a single list of connections.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 03/28/2019
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Configure shared connections for all users of the Windows Admin Center gateway

> Applies To: Windows Admin Center Preview, Windows Admin Center

With the ability to configure shared connections, gateway administrators can configure the connections list once for all users of a given Windows Admin Center gateway. 

From the **Shared Connections** tab of Windows Admin Center gateway Settings, gateway administrators can add servers, clusters, and PC connections as you would from the all connections page, including the ability to tag connections. Any connections and tags added in the Shared Connections list will appear for all users of this Windows Admin Center gateway, from their all connections page.
    ![](../media/shared-cnxns-1.png)

When any Windows Admin Center user accesses the "All Connections" page after Shared Connections have been configured, they will see their connections grouped into two sections: Personal and Shared connections. The Personal group is a specific user's connection list and persists across that user's browser sessions. The Shared connections group is the same across all users, and cannot be modified from the All Connections page.
![](../media/shared-cnxns-2.png)