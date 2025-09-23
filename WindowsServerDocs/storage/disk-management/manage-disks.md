---
title: Manage disks
description: Learn how to manage disks in a computer using Disk Management and discover whether a disk is online or offline and how to bring it online.
ms.date: 03/08/2023
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
---

# Manage disks

This article and the related topics show you how to use Disk Management to manage the disks in a computer. It includes information about how Windows manages the online status of new disks.

## Online and offline status

Disk Management displays whether a disk is online (available) or offline.

- In Windows, by default, all newly discovered disks are brought online with read and write access.
- In Windows Server, by default, newly discovered disks are brought online with read and write access unless they're on a shared bus (such as SCSI, iSCSI, Serial Attached SCSI, or Fibre Channel). Disks on a shared bus are offline the first time they're detected.

If a disk is offline, you must bring it online before you can initialize it or create volumes on it.

To bring a disk online or take it offline, follow these steps.

1. Open Disk Management. In the search box on the taskbar, enter **Computer Management** and select **Storage** > **Disk Management**.
1. Right-click the disk name, then select the appropriate action.

## Related topics

- [Initialize new disks](initialize-new-disks.md)
- [Move disks to another computer](move-disks-to-another-computer.md)
- [Change a dynamic disk back to a basic disk](change-a-dynamic-disk-back-to-a-basic-disk.md)
- [Convert disk partition style](change-disk-partition-scheme.md)
- [Manage Virtual Hard Disks](manage-virtual-hard-disks.md)

