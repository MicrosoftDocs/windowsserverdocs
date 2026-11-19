---
title: Configure shared connections for all users of the Windows Admin Center gateway
description: Learn how administrators can configure their Windows Admin Center (Project Honolulu) gateway once to let all users share a single list of connections.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 10/18/2021
ai-usage: ai-assisted
---

# Configure shared connections for all users of the Windows Admin Center gateway

By configuring shared connections, gateway administrators can set up the connections list once for all users of a Windows Admin Center gateway. This shared-connections model applies only to Windows Admin Center in Administration Mode. It doesn't apply to Virtualization Mode.

From the **Shared Connections** tab of Windows Admin Center gateway Settings, gateway administrators can add servers, clusters, and PC connections as you would from the all connections page, including the ability to tag connections. Any connections and tags added in the Shared Connections list will appear for all users of this Windows Admin Center gateway, from their all connections page.

:::image type="content" source="../media/shared-cnxns-1.png" alt-text="Screenshot of the Windows Admin Center Shared Connections page showing six servers tagged redmond.":::

When any Windows Admin Center user accesses the "All Connections" page after Shared Connections have been configured, they will see their connections grouped into two sections: Personal and Shared connections. The Personal group is a specific user's connection list and persists across that user's browser sessions. The Shared connections group is the same across all users, and cannot be modified from the All Connections page.

:::image type="content" source="../media/shared-cnxns-2.png" alt-text="Screenshot of the Windows Admin Center All Connections page showing Personal and Shared connection groups.":::

