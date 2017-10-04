---
title: Overview of Disk Management
description: This article gives an overview of the Disk Management utility
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jrgerend 
---

# Overview of Disk Management

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Disk Management is a system utility for managing hard disks and the volumes or partitions that they contain. With Disk Management, you can initialize disks, create volumes, and format volumes with the FAT, FAT32, or NTFS file systems. Disk Management enables you to perform most disk-related tasks without restarting the system or interrupting users. Most configuration changes take effect immediately.

In this version of Windows, Disk Management provides the same features you may already be familiar with from earlier versions, but also adds some new features:

-   **Simpler partition creation.** When you right-click a volume, you can choose whether to create a basic, spanned, or striped partition directly from the menu. See [Create and format a hard disk partition](http://windows.microsoft.com/windows/create-format-hard-disk-partition#create-format-hard-disk-partition=windows-7).
-   **Disk conversion options.** When you want to add more than four partitions to a basic disk, you are prompted to convert the disk to dynamic or to the GUID Partition Table (GPT) partition style.
-   **Extend and shrink partitions.** You can extend and shrink partitions directly from the Windows interface. See [Can I repartition my hard disk?](http://windows.microsoft.com/windows/repartition-hard-disk#1TC=windows-7).

## See Also

-   [Checklist: Add a new disk](checklist--add-a-new-disk.md)
-   [Manage disks](manage-disks.md)
-   [Manage basic volumes](manage-basic-volumes.md)
-   [Manage dynamic volumes](manage-dynamic-volumes.md)
-   [Create a striped volume](create-a-striped-volume.md)
-   [Troubleshooting Disk Management](troubleshooting-disk-management.md)
-   [Resources for Disk Management](https://technet.microsoft.com/library/cc753721(v=ws.11).aspx)
-  For more in-depth information about Disk Management, including best practices and concepts, see <http://go.microsoft.com/fwlink/?LinkId=64097>.