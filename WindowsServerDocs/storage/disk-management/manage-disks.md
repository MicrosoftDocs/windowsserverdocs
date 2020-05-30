---
title: Manage disks
description: This article describes how to manage disks
ms.date: 06/07/2019
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Manage disks

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic and its subtopics discuss using Disk Management to manage the disks in a computer, and includes information about initializing new disks, converting disks between different partition styles, and how Windows handles the online status of new disks.

## Online and offline status

Disk Management displays whether a disk is online (available), or offline.

In Windows, by default, all newly-discovered disks are brought online with read and write access. In Windows Server, by default, newly-discovered disks are brought online with read and write access unless they are on a shared bus (such as SCSI, iSCSI, Serial Attached SCSI, or Fibre Channel). Disks on a shared bus are offline the first time they are detected.

If a disk is offline, you must bring it online before you can initialize it or create volumes on it.

To bring a disk online or take it offline, right-click the disk name and then choosing the appropriate action.

## See Also

-   [Initialize new disks](initialize-new-disks.md)
-   [Move Disks to Another Computer](move-disks-to-another-computer.md)
-   [Change a dynamic disk back to a basic disk](change-a-dynamic-disk-back-to-a-basic-disk.md)
-   [Change a Master Boot Record disk into a GUID Partition Table disk](change-an-mbr-disk-into-a-gpt-disk.md)
-   [Change a GUID Partition Table disk into a Master Boot Record disk](change-a-gpt-disk-into-an-mbr-disk.md)
-   [Manage Virtual Hard Disks](manage-virtual-hard-disks.md)