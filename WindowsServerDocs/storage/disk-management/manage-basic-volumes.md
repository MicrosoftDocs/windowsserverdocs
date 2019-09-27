---
title: Manage basic volumes
description: This article describes how to manage basic volumes.
ms.date: 10/12/2017
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Manage basic volumes

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A basic disk is a physical disk that contains primary partitions, extended partitions, or logical drives. Partitions and logical drives on basic disks are known as basic volumes. You can only create basic volumes on basic disks.

You can add more space to existing primary partitions and logical drives by extending them into adjacent, contiguous unallocated space on the same disk. To extend a basic volume, it must be formatted with the NTFS file system. You can extend a logical drive within contiguous free space in the extended partition that contains it. If you extend a logical drive beyond the free space available in the extended partition, the extended partition grows to contain the logical drive as long as the extended partition is followed by contiguous unallocated space.

## See Also

-   [Assign a mount point folder path to a drive](assign-a-mount-point-folder-path-to-a-drive.md)
-   [Extend a Basic Volume](extend-a-basic-volume.md)
-   [Shrink a Basic Volume](shrink-a-basic-volume.md)