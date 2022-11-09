---
title: Quota Management
description: This article describes how to create and manage quotas
ms.date: 7/7/2017
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Quota Management

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

On the **Quota Management** node of the File Server Resource Manager Microsoft<sup>®</sup> Management Console (MMC) snap-in, you can perform the following tasks:

-   Create quotas to limit the space allowed for a volume or folder, and generate notifications when the quota limits are approached or exceeded.
-   Generate auto apply quotas that apply to all existing subfolders in a volume or folder and to any subfolders that are created in the future.
-   Define quota templates that can be easily applied to new volumes or folders and then used across an organization.

For example, you can:

-   Place a 200 megabyte (MB) limit on users' personal server folders, with an email notification sent to you and the user when 180 MB of storage has been exceeded.
-   Set a flexible 500 MB quota on a group's shared folder. When this storage limit is reached, all users in the group are notified by e-mail that the storage quota has been temporarily extended to 520 MB so that they can delete unnecessary files and comply with the preset 500 MB quota policy.
-   Receive a notification when a temporary folder reaches 2 gigabytes (GB) of usage, yet not limit that folder's quota because it is necessary for a service running on your server.

This section includes the following topics:

-   [Create a Quota](create-quota.md)
-   [Create an Auto Apply Quota](create-auto-apply-quota.md)
-   [Create a Quota Template](create-quota-template.md)
-   [Edit Quota Template Properties](edit-quota-template-properties.md)
-   [Edit Auto Apply Quota Properties](edit-auto-apply-quota-properties.md)

> [!Note]
> To set e-mail notifications and reporting capabilities, you must first configure the general File Server Resource Manager options. If you're just looking to free up space on a volume, consider using Azure File Sync with cloud tiering enabled. This allows you to cache your most frequently accessed files locally and tier your least frequently accessed files to the cloud, saving local storage space while maintaining performance. For details, see [Planning for an Azure File Sync deployment](/azure/storage/files/storage-sync-files-planning).

## Additional References

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
