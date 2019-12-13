---
title: Change a GUID Partition Table (GPT) disk into a Master Boot Record (MBR) disk
description: Describes how to change a GUID Partition Table (GPT) disk to an Master Boot Record (MBR) partition style disk.
ms.date: 06/19/2018
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Convert a GPT disk into an MBR disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Master Boot Record (MBR) disks use the standard BIOS partition table. GUID Partition Table (GPT) disks use Unified Extensible Firmware Interface (UEFI). MBR disks do not support more than four partitions on each disk. The MBR partition method is not recommended for disks larger than two terabytes (TB).

You can change a disk from a GPT to an MBR partition style as long as the disk is empty and contains no volumes.

> [!NOTE]
> Before you convert a disk, backup any data on it and close any programs that are accessing the disk.

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

## Converting using the Windows interface

1.  Back up or move all volumes on the basic GPT disk you want to convert into an MBR disk.

2.  If the disk contains any partitions or volumes, right-click each and then click **Delete Volume**.

3.  Right-click the GPT disk that you want to change into an MBR disk, and then click **Convert to MBR disk**.

## Converting using a command line

1.  Back up or move all volumes on the basic GPT disk you want to convert into an MBR disk.

2.  Open an elevated command prompt by right-clicking **Command Prompt**  and then choosing **Run as Administrator**.

3. Type `diskpart`. If the disk contains no partitions or volumes, skip to step 6.

4.  At the **DISKPART** prompt, type `list disk`. Note the disk number that you want to delete.

5.  At the **DISKPART** prompt, type `select disk <disknumber>`.

6.  At the **DISKPART** prompt, type `clean`.

    > [!IMPORTANT]
    > Running the **clean** command will delete all partitions or volumes on the disk.

7.  At the **DISKPART** prompt, type `convert mbr`.

|                Value                  |      Description   |
| ------------------------------------- | -----------------  |
|  <strong>list disk</strong>  | Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a Basic or Dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (\*) has focus. |
| <strong>select disk</strong> |                                                                                                          Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.                                                                                                           |
| <strong>convert mbr</strong> |                                                                               Converts an empty basic disk with the GUID Partition Table (GPT) partition style to a basic disk with the Master Boot Record (MBR) partition style.                                                                                |

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)