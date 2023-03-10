---
title: Initialize new disks
description: Learn how to initialize new disks with Disk Management and get them ready to use. Also access links for troubleshooting.
ms.date: 03/09/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Initialize new disks

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

If you add a brand new disk to your PC, and it doesn't show up in File Explorer, you might need to [assign a drive letter](change-a-drive-letter.md) for the disk. You might also need to initialize the disk before you use it.

You can only initialize a drive that's not yet formatted. When you initialize a disk, everything on the disk is erased. This action prepares the disk for use by Windows. After you initialize your disk, you can format it, and then store files on it.

> [!WARNING]
> If your disk already contains necessary files, don't initialize the disk. You'll lose all the files. Instead, we recommend troubleshooting the disk to see if you can read the files. For details, see [A disk's status is Not Initialized or the disk is missing entirely](troubleshooting-disk-management.md#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).

## Initialize a new disk

The following steps show how to initialize a new disk by using Disk Management. If you prefer to use PowerShell, run the [Initialize-Disk](/powershell/module/storage/initialize-disk) cmdlet.

1. Open Disk Management with administrator permissions.

   1. In the search box on the taskbar, enter **Disk Management**.
   1. Select and hold (or right-click) **Disk Management**, and then select **Run as administrator** > **Yes**.
   
   If you can't open Disk Management as an administrator, follow these steps:
   
   1. In the search box on the taskbar, enter **Computer Management**, and then select **Run as administrator** > **Yes**.
   1. After Computer Management opens, go to **Storage** > **Disk Management**.

1. In Disk Management, select and hold (or right-click) the disk you want to initialize, and then select **Initialize Disk**. If the disk is listed as *Offline*, first select and hold (or right-click) the disk, and then select **Online**.

   Some USB drives can't be initialized. These disks are only formatted and then assigned a [drive letter](change-a-drive-letter.md).

   ![Screenshot that shows Disk Management for an unformatted disk with the Initialize Disk shortcut menu displayed.](media/uninitialized-disk.PNG)

1. In the **Initialize Disk** dialog box, make sure the correct disk is selected, and then choose **OK** to accept the default partition style. If you need to change the partition style (GPT or MBR), see [Compare partition styles - GPT and MBR](#compare-partition-styles---gpt-and-mbr).

   The disk status briefly changes to **Initializing** and then to the **Online** status. If initializing fails for some reason, see [A disk's status is Not Initialized or the disk is missing entirely](troubleshooting-disk-management.md#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).

   ![Screenshot that shows the Initialize Disk dialog box with the GPT partition style selected.](media/initialize-disk.PNG)

1. Select and hold (or right-click) the unallocated space on the drive, and then select **New Simple Volume**. 

1. Select **Next**. Specify the size of the volume, and then select **Next** again.

   For the volume size, the common approach is to accept the default size, which uses the whole drive.

1. Specify the drive letter you want to assign to the volume, and then select **Next**.

1. Specify the file system you want to use (usually NTFS), select **Next**, and then **Finish**.

## Compare partition styles - GPT and MBR

Disks can be divided into multiple chunks called _partitions_. Each partition - even if there's only one - has to have a partition style - GPT or MBR. Windows uses the partition style to understand how to access the data on the disk. 

Most PCs use the GUID Partition Table (GPT) disk type for hard drives and SSDs. GPT is more robust and allows for volumes bigger than 2 TB. The older Master Boot Record (MBR) disk type is used by 32-bit PCs, older PCs, and removable drives such as memory cards.

You don't usually have to worry about partition style. Windows automatically uses the appropriate disk type.

To convert a disk from MBR to GPT or vice versa, you first have to delete all volumes from the disk, which erases everything on the disk. For more information, see [Convert an MBR disk into a GPT disk](change-an-mbr-disk-into-a-gpt-disk.md), or [Convert a GPT disk into an MBR disk](change-a-gpt-disk-into-an-mbr-disk.md).