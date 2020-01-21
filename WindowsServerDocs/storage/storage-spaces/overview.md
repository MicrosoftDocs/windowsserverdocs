---
title: Storage Spaces overview
ms.prod: windows-server
ms.author: jgerend
ms.manager: dougkim
ms.technology: storage-file-systems
ms.topic: article
author: jasongerend
ms.date: 05/22/2018
---
# Storage Spaces overview

Storage Spaces is a technology in Windows and Windows Server that can help protect your data from drive failures. It is conceptually similar to RAID, implemented in software. You can use Storage Spaces to group three or more drives together into a storage pool and then use capacity from that pool to create Storage Spaces. These typically store extra copies of your data so if one of your drives fails, you still have an intact copy of your data. If you run low on capacity, just add more drives to the storage pool.

There are four major ways to use Storage Spaces:

- **On a Windows PC** - for more info, see [Storage Spaces in Windows 10](https://windows.microsoft.com/windows-10/storage-spaces-windows-10).
- **On a stand-alone server with all storage in a single server** - for more info, see [Deploy Storage Spaces on a stand-alone server](deploy-standalone-storage-spaces.md).
- **On a clustered server using Storage Spaces Direct with local, direct-attached storage in each cluster node** - for more info, see [Storage Spaces Direct overview](storage-spaces-direct-overview.md).
- **On a clustered server with one or more shared SAS storage enclosures holding all drives** - for more info, see [Storage Spaces on a cluster with shared SAS overview](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831739(v%3dws.11)).

