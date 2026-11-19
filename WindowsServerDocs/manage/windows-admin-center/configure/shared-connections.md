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

Shared connections in Windows Admin Center are gateway-managed server, cluster, and PC connections that appear for every user of a gateway. Gateway administrators can maintain one consistent list instead of requiring each user to add the same connections and tags individually. Shared connections are available only in Administration Mode, not Virtualization Mode.

This article explains where gateway administrators add shared connections and tags, and how Windows Admin Center shows shared and personal connections to gateway users.

Gateway administrators can add servers, clusters, and PC connections, and assign tags, on the **Shared Connections** tab in the Windows Admin Center gateway settings. The connections and tags appear on the **All Connections** page for all users of the gateway.

:::image type="content" source="../media/shared-cnxns-1.png" alt-text="Screenshot of the Windows Admin Center Shared Connections page showing six servers tagged redmond.":::

When any Windows Admin Center user accesses the "All Connections" page after Shared Connections have been configured, they will see their connections grouped into two sections: Personal and Shared connections. The Personal group is a specific user's connection list and persists across that user's browser sessions. The Shared connections group is the same across all users, and cannot be modified from the All Connections page.

:::image type="content" source="../media/shared-cnxns-2.png" alt-text="Screenshot of the Windows Admin Center All Connections page showing Personal and Shared connection groups.":::

