---
title: Sync your file server with the cloud by using Azure File Sync
description: Use Azure File Sync to centralize your organization's file shares in Azure, while keeping the flexibility, performance, and compatibility of an on-premises file server. Azure File Sync transforms Windows Server into a quick cache of your Azure file share with the optional cloud tiering feature. 
ms.technology: manage
ms.topic: article
author: fauhse
ms.author: fauhse
ms.date: 04/12/2019
ms.localizationpriority: medium
ms.prod: windows-server
---
# Sync your file server with the cloud by using Azure File Sync

>Applies to: Windows Admin Center, Windows Admin Center Preview

Use Azure File Sync to centralize your organization's file shares in Azure, while keeping the flexibility, performance, and compatibility of an on-premises file server. Azure File Sync transforms Windows Server into a quick cache of your Azure file share with the optional cloud tiering feature. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and FTPS.

Once your files have synced to the cloud, you can connect multiple servers to the same Azure file share to sync and cache the content locally—permissions (ACLs) are always transported as well. Azure Files offers a snapshot capability that can generate differential snapshots of your Azure file share. These snapshots can even be mounted as read-only network drives via SMB for easy browsing and restore. Combined with cloud tiering, running an on-premises file server has never been easier.

For more info, see [Planning for an Azure File Sync deployment](https://aka.ms/afs).