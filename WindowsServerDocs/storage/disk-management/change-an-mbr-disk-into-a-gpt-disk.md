---
title: Change a Master Boot Record (MBR) into a GUID partition table (GPT) disk
description: Learn how to change a Master Boot Record (MBR) into a GUID partition table (GPT) disk.
ms.date: 03/07/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Convert an MBR disk into a GPT disk

> **Applies To:** Windows 10, Windows 8.1, Windows 11, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2022

Master Boot Record (MBR) disks use the standard BIOS partition table. GUID partition table (GPT) disks use the Unified Extensible Firmware Interface (UEFI). One advantage of GPT disks is that you can have more than four partitions on each disk. GPT is also required for disks larger than 2 terabytes (TB).

You can change a disk from MBR to GPT partition format as long as the disk contains no partition or volume sections.

> [!Important]
> - Before you convert a disk, back up any data on the disk, and close any programs that access the disk.
> - You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to convert a disk.

## Disk conversion from Windows

To complete the disk conversion by using Windows, follow these steps.

1. Back up or move the data on the MBR disk to convert.

1. If the MBR disk has partition or volume sections, delete all sections.

   - For each partition or volume section, right-click the section, and select **Delete Partition** or **Delete Volume**, as appropriate.

1. Right-click the MBR disk to convert to the GPT format, and select **Convert to GPT Disk**.

The process notifies you when the conversion is complete.

## Disk conversion from the command line

To complete the disk conversion from the command line with the **diskpart** disk partition process, follow these steps.

1. Back up or move the data on the MBR disk to convert.

1. Open an elevated command prompt: right-click **Command Prompt** and select **Run as Administrator**.

1. At the prompt, enter `diskpart` to initiate the disk partition process.

1. Prepare the MBR disk for conversion by cleaning any partition or volume sections.

   > [!Note]
   > If the MBR disk doesn't have any partitions or volumes, skip to the last step to apply the conversion.

   1. At the **DISKPART** prompt, enter `list disk`. Note the MBR disk number that you want to convert to GPT format.

   1. At the **DISKPART** prompt, enter `select disk` _`<disk-number>`_, where `<disk-number>` is the MBR disk number to convert.

   1. At the **DISKPART** prompt, enter `clean` to delete all partition and volume sections on the disk.

1. At the **DISKPART** prompt, enter `convert gpt` to convert the MBR disk to the GPT partition format.

The diskpart process notifies you when the conversion is complete.

### diskpart commands

The following table summarizes the commands used with the diskpart process.

| Command | Description |
| --- | --- |
| `list disk` | Displays a list of disks and information about them, such as their size and the amount of available free space. The command also shows whether the disk is a basic or dynamic disk, and whether it uses the MBR or GPT partition format. In the list of results, the disk marked with an asterisk (*) has the current focus for entered commands. |
| `select disk` _`disk-number`_ | Selects the specified disk, where *disk-number* is the disk number that you want to select. The command also gives the current focus to the specified disk. |
| `clean` | Removes all partition or volume sections from the disk that has the current focus. |
| `convert gpt` | Converts an empty basic disk with the MBR partition format into a basic disk with the GPT partition format. |

## MBR2GPT conversion tool

As an alternate approach, you can use the MBR2GPT.EXE tool to convert the MBR disk to the GPT partition format. Keep in mind that the tool can be more complicated to use than the `diskpart` process. For details, see [Convert MBR partition to GPT](/windows/deployment/mbr-to-gpt).

## See also

- [Command-line syntax notation](/previous-versions/orphan-topics/ws.11/cc742449(v=ws.11))