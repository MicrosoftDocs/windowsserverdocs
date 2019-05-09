---
title: Storage Reports Management
description: This article describes how to generate, schedule, and monitor storage reports
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Storage Reports Management

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

On the **Storage Reports Management** node of the File Server Resource Manager Microsoft<sup>®</sup> Management Console (MMC) snap-in, you can perform the following tasks:

-   Schedule periodic storage reports that allow you to identify trends in disk usage.
-   Monitor attempts to save unauthorized files for all users or a selected group of users.
-   Generate storage reports instantly.

For example, you can:

-   Schedule a report that will run every Sunday at midnight, generating a list that includes the most recently accessed files from the previous two days. With this information, you can monitor weekend storage activity and plan server down-time that will have less impact on users who are connecting from home over the weekend.
-   Run a report at any time to identify all duplicate files in a volume on a server so that disk space can be quickly reclaimed without losing any data.
-   Run a Files by File Group report to identify how storage resources are segmented across different file groups 
-   Run a Files by Owner report to analyze how individual users are using shared storage resources.

This section includes the following topics:

-   [Schedule a Set of Reports](schedule-set-of-reports.md)
-   [Generate Reports on Demand](generate-reports-on-demand.md)

> [!Note]
> To set e-mail notifications and certain reporting capabilities, you must first configure the general File Server Resource Manager options.

## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)


