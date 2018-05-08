---
title: Storage Spaces overview
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: elizapo
ms.technology: storage-file-systems
ms.topic: article
author: jasongerend
ms.date: 04/24/2018
---
# Storage Spaces overview

Storage Spaces is a series of technologies in Windows and Windows Server that enables you to help protect your data from drive failures and extend storage over time as you add drives. You can use Storage Spaces to group two or more drives together in a storage pool and then use capacity from that pool to create virtual drives called storage spaces. These storage spaces typically store extra copies of your data so if one of your drives fails, you still have an intact copy of your data. If you run low on capacity, just add more drives to the storage pool.

There are four major ways to use Storage Spaces:

- **On a Windows PC** - for more info, see [Storage Spaces in Windows 10](http://windows.microsoft.com/en-us/windows-10/storage-spaces-windows-10).
- **On a stand-alone server with all storage in a single server** - for more info, see [Deploy Storage Spaces on a stand-alone server](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj822938(v%3dws.11)).
- **On a clustered server using Storage Spaces Direct with local, non-shared storage in each cluster node** - for more info, see [Storage Spaces Direct overview](storage-spaces-direct-overview.md).
- **On a clustered server with one or more shared SAS storage enclosures holding all drives** - for more info, see [Storage Spaces on a cluster with shared SAS overview](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831739(v%3dws.11)).

