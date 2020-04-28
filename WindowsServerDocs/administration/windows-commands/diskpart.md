---
title: DiskPart
description: Reference topic for **DiskPart**, which helps you manage your computer's drives.
ms.prod: windows-server
ms.technology: storage
author: jasongerend
manager: elizapo
ms.author: jgerend
---

# DiskPart

> Applies to: Windows 10, Windows 8.1, Windows 8, Windows 7, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2, Windows Server 2008

DiskPart commands help you manage your computer's drives (disks, partitions, volumes, or virtual hard disks).

Before you can use DiskPart commands, you must first list, and then select an object to give it focus. When an object has focus, any DiskPart commands that you type will act on that object.

## List available objects

You can list the available objects and determine an object's number or drive letter by using:

- `list disk` - Displays all the disks on the computer.

- `list volume` - Displays all the volumes on the computer.

- `list partition` - Displays the partitions on the disk that has focus on the computer.

- `list vdisk` - Displays all the virtual disks on the computer.

When you use the **list** commands, an asterisk (*) appears next to the object with focus.

## Determine focus

When you select an object, the focus remains on that object until you select a different object. For example, if the focus is set on disk 0 and you select volume 8 on disk 2, the focus shifts from disk 0 to disk 2, volume 8.

Some commands automatically change the focus. For example, when you create a new partition, the focus automatically switches to the new partition.

You can only give focus to a partition on the selected disk. When a partition has focus, the related volume (if any) also has focus. When a volume has focus, the related disk and partition also have focus if the volume maps to a single specific partition. If this is not the case, focus on the disk and partition is lost.

## DiskPart commands

To start the DiskPart command interpreter, at the command prompt type:

```
diskpart
```

> [!IMPORTANT]
> You must be in your local **Administrators** group, or a group with similar permissions, to run DiskPart.

You can run the following commands from the Diskpart command interpreter:

| Command | Description |
| ------- | ----------- |
| [Active](active.md) | Marks the disk's partition with focus, as active. |
| [Add](add.md) | Mirrors the simple volume with focus to the specified disk. |
| [Assign](assign.md) | Assigns a drive letter or mount point to the volume with focus. |
| [Attach vdisk](attach-vdisk.md) | Attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive. |
| [Attributes](attributes.md) | Displays, sets, or clears the attributes of a disk or volume. |
| [Automount](automount.md) | Enables or disables the automount feature. | 
| [Break](break.md) | Breaks the mirrored volume with focus into two simple volumes. |
| [Clean](clean.md) | Removes any and all partition or volume formatting from the disk with focus. |
| [Compact vdisk](compact-vdisk.md) | Reduces the physical size of a dynamically expanding virtual hard disk (VHD) file. |
| [Convert](convert.md) | Converts file allocation table (FAT) and FAT32 volumes to the NTFS file system, leaving existing files and directories intact. |
| [Create](create.md) | Creates a partition on a disk, a volume on one or more disks, or a virtual hard disk (VHD). |
| [Delete](delete.md) | Deletes a partition or a volume. |
| [Detach vdisk](detach-vdisk.md) | Stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer. |
| [Detail](detail.md) | Displays information about the selected disk, partition, volume, or virtual hard disk (VHD). |
| [Exit](exit.md) | Exits the DiskPart command interpreter. |
| [Expand vdisk](expand-vdisk.md) | Expands a virtual hard disk (VHD) to the size that you specify. |
| [Extend](extend.md) | Extends the volume or partition with focus, along with its file system, into free (unallocated) space on a disk. |
| [Filesystems](filesystems.md) | Displays information about the current file system of the volume with focus and lists the file systems that are supported for formatting the volume. |
| [Format](format.md) | Formats a disk to accept Windows files. |
| [GPT](gpt.md) | Assigns the gpt attribute(s) to the partition with focus on basic GUID partition table (gpt) disks. |
| [Help](help.md) | Displays a list of the available commands or detailed help information on a specified command. |
| [Import](import.md) | Imports a foreign disk group into the disk group of the local computer. |
| [Inactive](inactive.md) | Marks the system partition or boot partition with focus as inactive on basic master boot record (MBR) disks. |
| [List](list.md) | Displays a list of disks, of partitions in a disk, of volumes in a disk, or of virtual hard disks (VHDs). |
| [Merge vdisk](merge-vdisk.md) | Merges a differencing virtual hard disk (VHD) with its corresponding parent VHD. |
| [Offline](offline.md) | Takes an online disk or volume to the offline state. |
| [Online](online.md) | Takes an offline disk or volume to the online state. |
| [Recover](recover.md) | Refreshes the state of all disks in a disk group, attempt to recover disks in an invalid disk group, and resynchronizes mirrored volumes and RAID-5 volumes that have stale data. |
| [Rem](rem.md) | Provides a way to add comments to a script. |
| [Remove](remove.md) | Removes a drive letter or mount point from a volume. |
| [Repair](repair.md) | Repairs the RAID-5 volume with focus by replacing the failed disk region with the specified dynamic disk. |
| [Rescan](rescan.md) | Locates new disks that may have been added to the computer. |
| [Retain](retain.md) | Prepares an existing dynamic simple volume to be used as a boot or system volume. |
| [San](san.md) | Displays or sets the storage area network (san) policy for the operating system. |
| [Select](select.md) | Shifts the focus to a disk, partition, volume, or virtual hard disk (VHD). |
| [Set id](set-id.md) | Changes the partition type field for the partition with focus. |
| [Shrink](shrink.md) | Reduces the size of the selected volume by the amount you specify. |
| [Uniqueid](uniqueid.md) | Displays or sets the GUID partition table (GPT) identifier or master boot record (MBR) signature for the disk with focus. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Disk management overview](https://docs.microsoft.com/windows-server/storage/disk-management/overview-of-disk-management)

- [Storage Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/storage/)
