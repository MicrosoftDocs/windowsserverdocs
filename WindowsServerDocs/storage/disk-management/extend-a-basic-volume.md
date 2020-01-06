---
title: Extend a basic volume
description: You can add space to an existing volume in Windows, extending it into empty space on the drive, but only if the empty space doesn't have a volume on it (it's unallocated) and comes immediately after the volume you want to extend, with no other volumes in-between. This article describes how to do so.
ms.date: 12/19/2019
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Extend a basic volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use Disk Management to add space to an existing volume, extending it into empty space on the drive, but only if the empty space doesn't have a volume on it (it's unallocated) and comes immediately after the volume you want to extend, with no other volumes in-between, as shown in the following image. The volume to extend also must be formatted with the NTFS or ReFS file systems.

:::image type="content" source="media/extend-volume-space-highlighted.png" alt-text="Disk Management showing free space that a volume can extend into.":::

## To extend a volume by using Disk Management

Here's how to extend a volume into empty space immediately after the volume on the drive:

1. Open Disk Management with administrator permissions.

   An easy way to do so is to type **Computer Management** in the search box on the taskbar, select and hold (or right-click) **Computer Management**, and then select **Run as administrator** > **Yes**. After Computer Management opens, go to **Storage** > **Disk Management**.
2. Select and hold (or right-click) the volume that you want to extend, and then select **Extend Volume**.

   If **Extend Volume** is grayed out, check the following:
    - Disk Management or Computer Management was opened with administrator permissions
    - There is unallocated space directly after (to the right) of the volume, as shown in the graphic above. If there's another volume in-between the unallocated space and the volume you want to extend, you can either delete the in-between volume and all files on it (make sure to back up or move any important files first!), use a non-Microsoft disk partitioning app that can move volumes without destroying data, or skip extending the volume and instead create a separate volume in the unallocated space.
    - The volume is formatted with the NTFS or ReFS file system. Other file systems can't be extended, so you'd have to move or back up the files on the volume and then format the volume with the NTFS or ReFS file system.
    - If the disk is larger than 2 TB, make sure that it's using the GPT partitioning scheme. To use more than 2 TB on a disk, it must be initialized using the GPT partitioning scheme. To convert to GPT, see [Change an MBR disk into a GPT disk](change-an-mbr-disk-into-a-gpt-disk.md).
    - If you still can't extend the volume, try searching the [Microsoft community - Files, folders, and storage](https://answers.microsoft.com/en-us/windows/forum/windows_10-files?sort=lastreplydate&dir=desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=all&isFilterExpanded=true&tm=1514405359639) site, and if you don't find an answer, post a question there and Microsoft or other members of the community will try to help, or [Contact Microsoft Support](https://support.microsoft.com/contactus/).

3. Select **Next**, and then on the **Select Disks** page of the wizard (shown here), specify how much to extend the volume. Typically you'll want to use the default value, which uses all available free space, but you can use a smaller value if you want to create additional volumes in the free space.

   :::image type="content" source="media/extend-volume-wizard.png" alt-text="The Extend Volume Wizard showing a volume being extended to take all available space":::

4. Select **Next** and then **Finish** to extend the volume.

## To extend a volume by using PowerShell

1. Select and hold (or right-click) the Start button and then select Windows PowerShell (Admin).
2. Enter the following command to resize the volume to the maximum size, specifying the drive letter of the volume you want to extend in the *$drive_letter* variable:

   ```PowerShell
   # Variable specifying the drive you want to extend
   $drive_letter = "C"

   # Script to get the partition sizes and then resize the volume
   $size = (Get-PartitionSupportedSize -DriveLetter $drive_letter)
   Resize-Partition -DriveLetter $drive_letter -Size $size.SizeMax
   ```

## See slso

- [Resize-Partition](https://docs.microsoft.com/powershell/module/storage/resize-partition)
- [Diskpart extend](https://docs.microsoft.com/windows-server/administration/windows-commands/extend)
