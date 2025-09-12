---
title: Enable volume encryption and deduplication - Azure Local and Windows Server
description: This topic covers how to use volume encryption and deduplication in Azure Local and Windows Server using Windows Admin Center.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 08/17/2023
appliesto: [
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
            "✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
           ]
---

# Enable volume encryption and deduplication in Azure Local and Windows Server

This topic covers how to enable encryption with BitLocker on volumes in Azure Local or Windows Server using Windows Admin Center. It also covers how to enable deduplication on volumes. To learn how to create volumes, see [Create volumes](create-volumes.md).

## Encrypt volumes with BitLocker

To turn on BitLocker in Windows Admin Center:

1. Connect to an Azure Local system or Storage Spaces Direct cluster running Windows Server, and then on the **Tools** pane, select **Volumes**.

    >[!NOTE]
    > To use a new feature that provides an additional locally held BitLocker key without relying on Active Directory, you must use Windows PowerShell. The new feature is only available in Windows Server 2022 and Azure Local, version 21H2 and newer. For more information, see [Use BitLocker with Cluster Shared Volumes (CSV)](/windows-server/failover-clustering/bitlocker-on-csv-in-ws-2022).

1. On the **Volumes** page, select the **Inventory** tab, select the appropriate volume, and then select **Settings**.
1. Under **More features**, select **Use encryption**.
1. Select any optional settings, such as backing up the recovery password to Active Directory Domain Services, and then select **Save**.

   If the **Install BitLocker feature first** pop-up displays, follow its instructions to install the feature on each server in the cluster, and then restart your servers.

## Turn on deduplication

Deduplication uses a post-processing model, which means that you won't see savings until it runs. When it does, it deduplicates all existing files.

To turn on deduplication on a volume in Windows Admin Center:

1. Connect to an Azure Local system or Storage Spaces Direct cluster running Windows Server, and then on the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, select the appropriate volume, and then select **Settings**.
1. Under **More features**, select  **Use deduplication**, and then select the deduplication mode. If you're not sure, use the default setting.

1. Select **Save**.

## Next steps

- [Manage volumes](manage-volumes.md)
