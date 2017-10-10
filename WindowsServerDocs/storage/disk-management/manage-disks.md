---
title: Manage disks
description: This article describes how to manage disks
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Manage disks

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This section includes the most common disk management tasks, including moving disks between computers, changing disks between basic and dynamic types, and changing the partition style of disks.

## Converting disk types

Although Disk Management allows you to change disks between various types and partition styles, some of the operations are irreversible (unless you reformat the drive). You should carefully consider the disk type and partition style that is most appropriate for your application.

For more information about considerations for using basic versus dynamic disks, see http://go.microsoft.com/fwlink/?LinkId=64117 and http://go.microsoft.com/fwlink/?LinkId=64119.

The following table shows the options for converting disks between the various partition styles:

| Disk type | Convert to MBR  | Convert to GPT| Convert to dynamic |
| ---- | --- | --- |--- |
| <p>Master Boot Record (MBR)</p> | <p>--</p> | <p>Allowed (if no volumes on disk).</p> | <p>Allowed, but disk might become unbootable. See Note.</p> |
| <p>GUID Partition Table (GPT)</p> | <p>Allowed (if no volumes on disk).</p> | <p>--</p>  | <p>Allowed, but disk might become unbootable. See Note.</p> |


> [!NOTE]
> In a multi-boot scenario, if you have booted into one operating system, and you convert a basic MBR disk that contains an alternate operating system to a dynamic disk, you will no longer be able to boot into the alternate operating system.

## Online and offline status

Disk Management displays the online and offline status of disks. 

In Windows Vista, by default, all newly-discovered disks are brought online with read and write access. In Windows Server 2008 Enterprise and Windows Server 2008 Datacenter, by default, newly-discovered disks are brought online with read and write access unless they are on a shared bus (such as SCSI, iSCSI, Serial Attached SCSI, or Fibre Channel). Disks on a shared bus will be offline the first time they are detected.

If a disk is offline, you must bring it online before you can initialize it or create volumes on it. 

-  Bring a disk online or take it offline by right-clicking the disk name and then choosing the appropriate action.

## See Also

-   [Initialize new disks](initialize-new-disks.md)
-   [Move Disks to Another Computer](move-disks-to-another-computer.md)
-   [Reactivate a missing or offline dynamic disk](reactivate-a-missing-or-offline-dynamic-disk.md)
-   [Change a basic disk into a dynamic disk](change-a-basic-disk-into-a-dynamic-disk.md)
-   [Change a dynamic disk back to a basic disk](change-a-dynamic-disk-back-to-a-basic-disk.md)
-   [Change a Master Boot Record disk into a GUID Partition Table disk](change-an-mbr-disk-into-a-gpt-disk.md)
-   [Change a GUID Partition Table disk into a Master Boot Record disk](change-a-gpt-disk-into-an-mbr-disk.md)
-   [Remove a missing dynamic disk](remove-a-missing-dynamic-disk.md)
-   [Manage Virtual Hard Disks](manage-virtual-hard-disks.md)