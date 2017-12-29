---
title: Change a Master Boot Record (MBR) into a GUID partition table (GPT) disk
description: Describes how to change a Master boot record (MBR) into a GUID partition table (GPT) disk
ms.date: 10/12/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Convert an MBR disk into a GPT disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Master Boot Record (MBR) disks use the standard BIOS partition table. GUID Partition Table (GPT) disks use Unified Extensible Firmware Interface (UEFI). One advantage of GPT disks is that you can have more than four partitions on each disk. GPT is also required for disks larger than two terabytes (TB).

You can change a disk from MBR to GPT partition style as long as the disk contains no partitions or volumes.
You cannot use the GPT partition style on removable media, or on cluster disks that are connected to shared SCSI or Fibre Channel buses that are used by the Cluster service.

> [!NOTE]
> Before you convert disks, close any programs that are running on those disks.

## Changing an MBR disk into a GPT disk

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
#### To change an MBR disk into a GPT disk using the Windows interface

1.  Back up or move the data on the basic MBR disk you want to convert into a GPT disk.

2.  If the disk contains any partitions or volumes, right-click each and then click **Delete Partition** or **Delete Volume**.

3.  Right-click the MBR disk that you want to change into a GPT disk, and then click **Convert to GPT Disk**.

<a id="BKMK_CMD"></a>
#### To change an MBR disk into a GPT disk using a command line

1.  Back up or move the data on the basic MBR disk you want to convert into a GPT disk.

2.  Open an elevated command prompt by right-clicking **Command Prompt**  and then choosing **Run as Administrator**.

3. Type `diskpart`. If the disk does not contain any partitions or volumes, skip to step 6.

4.  At the **DISKPART** prompt, type `list disk`. Note the disk number you want to convert.

5.  At the **DISKPART** prompt, type `select disk <disknumber>`.

6.  At the **DISKPART** prompt, type `clean`.

> [!NOTE]
> Running the **clean** command will delete all partitions or volumes on the disk.

7.  At the **DISKPART** prompt, type `convert gpt`.

<br />

| Value  | Description  |
| ----- | ----|
| <p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**select disk** <em>disknumber</em></p> | <p>Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.</p> |
| <p>**clean**</p> | <p>Removes all partitions or volumes from the disk with focus.</p>  |
| <p>**convert gpt**</p>| <p>Converts an empty basic disk with the Master Boot Record (MBR) partition style into a basic disk with the GUID Partition Table (GPT) partition style.</p> |

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


