---
title: Configure Windows Server Update Services (WSUS) Content Servers
description: Learn how to configure Windows Server Update Services (WSUS) Content Servers to store update files on the local computer.
manager: brianlic
ms.topic: how-to
ms.assetid: 9724aa8d-e4ae-404c-bee6-cef1534cd3ca
ms.author: jgerend
author: JasonGerend
ms.date: 01/05/2021
---
# Configure Windows Server Update Services (WSUS) Content Servers

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

After installing the BranchCache feature and starting the BranchCache service, WSUS servers must be configured to store update files on the local computer.

When you configure WSUS servers to store update files on the local computer, both the update metadata and the update files are downloaded by and stored directly upon the WSUS server. This ensures that BranchCache client computers receive Microsoft product update files from the WSUS server rather than directly from the Microsoft Update Web site.

For more information about WSUS synchronization, see [Setting up Update Synchronizations](../../../administration/windows-server-update-services/manage/setting-up-update-synchronizations.md)
