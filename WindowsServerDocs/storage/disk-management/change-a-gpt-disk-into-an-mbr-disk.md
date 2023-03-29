---
title: Change a GUID partition table (GPT) disk into a Master Boot Record (MBR) disk
description: Learn how to convert a GUID partition table (GPT) disk into a Master Boot Record (MBR) partition disk by using Windows or the command line.
ms.date: 03/20/2023
ms.topic: conceptual
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Convert a GPT disk into an MBR disk

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

Master Boot Record (MBR) disks use the standard BIOS partition table. GUID partition table (GPT) disks use the Unified Extensible Firmware Interface (UEFI). MBR disks don't support more than four partitions on each disk. The MBR partition method isn't recommended for disks larger than 2 terabytes (TB).

You can change a disk from MBR to GPT partition format as long as the disk contains no partitions or volumes.

> [!IMPORTANT]
> - Before you convert a disk, back up any data on the disk, and close any programs that access the disk.
> - You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to convert a disk.

## Convert a GPT disk with Disk Management

To complete the disk conversion by using Disk Management, follow these steps.

1. Back up or move the data on the GPT disk prior to conversion.

1. Delete all partitions and volumes on the GPT disk.

   - For each partition or volume, select and hold (or right-click) the item, and select **Delete Partition** or **Delete Volume**.

1. Select and hold (or right-click) the GPT disk to convert to the MBR format, and select **Convert to MBR Disk**.

The process notifies you when the conversion completes.

## Convert a GPT disk from the command line

To complete the disk conversion from the command line with the **diskpart** disk partition process, follow these steps.

1. Back up or move the data on the GPT disk prior to conversion.

1. Open an elevated command prompt: select and hold (or right-click) **Command Prompt**, and select **Run as Administrator**.

1. At the prompt, enter `diskpart` to initiate the disk partition process.

1. Prepare the GPT disk for conversion by cleaning (deleting) any partitions or volumes.

   > [!NOTE]
   > If the GPT disk doesn't have any partitions or volumes, skip to the last step to apply the conversion.

   1. At the **DISKPART** prompt, enter `list disk`. Make a note of the GPT disk number that you want to convert to MBR format.

   1. At the **DISKPART** prompt, enter `select disk` _`<disk-number>`_, where `<disk-number>` is the GPT disk number to convert.

   1. At the **DISKPART** prompt, enter `clean` to delete all partitions and volumes on the disk.

1. At the **DISKPART** prompt, enter `convert mbr` to convert the GPT disk to the MBR partition format.

The diskpart process notifies you when the conversion completes.

### Review diskpart commands

The following table shows a summary of the commands for the diskpart process.

| Command | Description |
| --- | --- |
| `list disk` | Displays a list of disks and information about them, such as their size and the amount of available free space. The command also shows whether the disk is a basic or dynamic disk, and whether it uses the GPT or MBR partition format. In the list of results, the disk marked with an asterisk (*) has the current focus for entered commands. |
| `select disk` _`disk-number`_ | Selects the specified disk, where *disk-number* is the disk number that you want to select. The command also gives the current focus to the specified disk. |
| `clean` | Removes all partition or volume sections from the disk that has the current focus. |
| `convert mbr` | Converts an empty basic disk with the GPT partition format into a basic disk with the MBR partition format. |

## Related links

- [Command-line syntax notation](/previous-versions/orphan-topics/ws.11/cc742449(v=ws.11))
