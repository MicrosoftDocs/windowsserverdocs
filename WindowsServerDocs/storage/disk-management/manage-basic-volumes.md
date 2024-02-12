---
title: Manage basic volumes
description: This article describes basic disks and the requirements to add space to existing primary partitions and logical drives.
ms.date: 03/08/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Manage basic volumes

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

A basic disk is a physical disk that contains primary partitions, extended partitions, or logical drives. Partitions and logical drives on basic disks are called basic volumes. You can only create basic volumes on basic disks.

You can add more space to existing primary partitions and logical drives by extending them into adjacent, contiguous unallocated space on the same disk. To extend a basic volume, format it with the NTFS file system. You can extend a logical drive within contiguous free space in the extended partition that contains it. If you extend a logical drive beyond the free space available in the extended partition, the extended partition grows to contain the logical drive only if the extended partition is followed by contiguous unallocated space.

## Related topics

- [Mount a drive in a folder](assign-a-mount-point-folder-path-to-a-drive.md)
- [Extend a basic volume](extend-a-basic-volume.md)
- [Shrink a basic volume](shrink-a-basic-volume.md)
