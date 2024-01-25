---
description: Learn about Storage Spaces in Windows and Windows Server and how it can help you take care of your data and the four main ways to use Storage Spaces.
title: Storage Spaces overview
ms.author: jgerend
manager: dougkim
ms.topic: article
author: jasongerend
ms.date: 03/09/2023
---

# Storage Spaces overview

Storage Spaces can help protect your data from drive failures. It's a technology in Windows and Windows Server and is conceptually similar to redundant array of independent disks (RAID), implemented in software. You can use Storage Spaces to group three or more drives into a storage pool and then use capacity from that pool to create Storage Spaces. These drives typically store extra copies of your data, so if one of your drives fails, you still have an intact copy of your data. If you run low on capacity, just add more drives to the storage pool.

There are four main ways to use Storage Spaces:

- **On a Windows PC**. For more information, see [Storage Spaces in Windows 10](https://windows.microsoft.com/windows-10/storage-spaces-windows-10).
- **On a stand-alone server with all storage in a single server**. For more information, see [Deploy Storage Spaces on a stand-alone server](deploy-standalone-storage-spaces.md).
- **On a clustered server using Storage Spaces Direct with local, direct-attached storage in each cluster node**. For more information, see [Storage Spaces Direct overview](/azure-stack/hci/concepts/storage-spaces-direct-overview).
- **On a clustered server with one or more shared SAS storage enclosures holding all drives**. For more information, see [Storage Spaces on a cluster with shared SAS overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831739(v%3dws.11)).
