---
title: DiskPart
description: Windows Commands topic for DiskPart, which helps you manage your computer's drives.
ms.prod: windows-server
ms.technology: storage
author: jasongerend
manager: elizapo
ms.author: jgerend
---

# DiskPart

>Applies To: Windows 10, Windows 8.1, Windows 8, Windows 7, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2, Windows Server 2008

DiskPart commands help you manage your computer's drives (disks, partitions, volumes, or virtual hard disks). 

Before you can use DiskPart commands, you must first list, and then select an object to give it focus. When an object has focus, any DiskPart commands that you type will act on that object.

## List the available objects

You can list the available objects and determine an object's number or drive letter by using:

- `list disk` - Displays all the disks on the computer.

- `list volume` - Displays all the volumes on the computer.

- `list partition` - Displays the partitions on the disk that has focus on the computer.

- `list vdisk` - Displays all the virtual disks on the computer.

When you use the **list** commands, an asterisk (\*) appears next to the object with focus.

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

You can run the following commands in the Diskpart command interpreter:

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
| [Expand vdisk](expand-vdisk.md) | 
| [Extend](extend.md) | 
| [Filesystems](filesystems.md) | 
| [Format](format.md) | 
| [GPT](gpt.md) | 
| [Help](help.md) | 
| [Import](import.md) | 
| [Inactive](inactive.md) | 
| [List](list.md) | 
| [Merge vdisk](merge-vdisk.md) | 
| [Offline](offline.md) | 
| [Online](online.md) | 
| [Recover](recover.md) | 
| [Rem](rem.md) | 
| [Remove](remove.md) | 
| [Repair](repair.md) | 
| [Rescan](rescan.md) | 
| [Retain](retain.md) | 
| [San](san.md) | 
| [Select](select.md) | 
| [Set id](set-id.md) | 
| [Shrink](shrink.md) | 
| [Uniqueid](uniqueid.md) | 

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md

- [Disk management overview](https://docs.microsoft.com/windows-server/storage/disk-management/overview-of-disk-management)

- [Storage Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/storage/)
