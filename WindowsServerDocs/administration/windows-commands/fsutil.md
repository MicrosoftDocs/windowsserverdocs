---
title: fsutil
description: Reference article for the fsutil command, which performs tasks that are related to file allocation table (FAT) and NTFS file systems.
ms.author: alalve
author: toklima
ms.assetid: 2e748187-6a10-4bb0-aed5-34f886a250d2
ms.topic: reference
ms.date: 11/02/2022
---

# fsutil

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Performs tasks that are related to file allocation table (FAT) and NTFS file systems, such as managing reparse points, managing sparse files, or dismounting a volume. If it's used without parameters, **fsutil** displays a list of supported subcommands.

> [!NOTE]
> You must be logged on as an administrator or a member of the Administrators group to use **fsutil**. This command is quite powerful and should be used only by advanced users who have a thorough knowledge of Windows operating systems.

## Parameters

| Subcommand | Description |
| ---------- | ----------- |
| [fsutil 8dot3name](fsutil-8dot3name.md) | Queries or changes the settings for short name behavior on the system, for example, generates 8.3 character-length file names. Removes short names for all files within a directory. Scans a directory and identifies registry keys that might be impacted if short names were stripped from the files in the directory. |
| [fsutil devdrv](fsutil-devdrv.md) | Manages dev drive, which is a volume tuned for performance of developer scenarios. Dev drive also lets an administrator of the device control the file system minifilters that are attached to the volume. |
| [fsutil dirty](fsutil-dirty.md) | Queries whether the volume's dirty bit is set or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted. |
| [fsutil file](fsutil-file.md) | Finds a file by user name (if Disk Quotas are enabled), queries allocated ranges for a file, sets a file's short name, sets a file's valid data length, sets zero data for a file, creates a new file of a specified size, finds a file ID if given the name, or finds a file link name for a specified file ID. |
| [fsutil fsinfo](fsutil-fsinfo.md) | Lists all drives and queries the drive type, volume information, NTFS-specific volume information, or file system statistics. |
| [fsutil hardlink](fsutil-hardlink.md) | Lists hard links for a file, or creates a hard link (a directory entry for a file). Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories (or even in the same directory, with different names). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it are deleted. After you create a hard link, programs can use it like any other file name. |
| [fsutil objectid](fsutil-objectid.md) | Manages object identifiers, which are used by the Windows operating system to track objects such as files and directories. |
| [fsutil quota](fsutil-quota.md) | Manages disk quotas on NTFS volumes to provide more precise control of network-based storage. Disk quotas are implemented on a per-volume basis and enable both hard- and soft-storage limits to be implemented on a per-user basis. |
| [fsutil repair](fsutil-repair.md) | Queries or sets the self-healing state of the volume. Self-healing NTFS attempts to correct corruptions of the NTFS file system online without requiring **Chkdsk.exe** to be run. Includes initiating on-disk verification and waiting for repair completion. |
| [fsutil reparsepoint](fsutil-reparsepoint.md) | Queries or deletes reparse points (NTFS file system objects that have a definable attribute containing user-controlled data). Reparse points are used to extend functionality in the input/output (I/O) subsystem. They are used for directory junction points and volume mount points. They are also used by file system filter drivers to mark certain files as special to that driver. |
| [fsutil resource](fsutil-resource.md) | Creates a Secondary Transactional Resource Manager, starts or stops a Transactional Resource Manager, displays information about a Transactional Resource Manager  or modifies its behavior. |
| [fsutil sparse](fsutil-sparse.md) | Manages sparse files. A sparse file is a file with one or more regions of unallocated data in it. A program will see these unallocated regions as containing bytes with the value zero, but no disk space is used to represent these zeros. All meaningful or nonzero data is allocated, whereas all non-meaningful data (large strings of data composed of zeros) is not allocated. When a sparse file is read, allocated data is returned as stored, and unallocated data is returned as zeros (by default in accordance with the C2 security requirement specification). Sparse file support allows data to be deallocated from anywhere in the file. |
| [fsutil tiering](fsutil-tiering.md) | Enables management of storage tier functions, such as setting and disabling flags and listing of tiers. |
| [fsutil transaction](fsutil-transaction.md)   | Commits a specified transaction, rolls back a specified transaction, or displays info about the transaction. |
| [fsutil usn](fsutil-usn.md) | Manages the update sequence number (USN) change journal, which provides a persistent log of all changes made to files on the volume. |
| [fsutil volume](fsutil-volume.md) | Manages a volume. Dismounts a volume, queries to see how much free space is available on a disk, or finds a file that is using a specified cluster. |
| [fsutil wim](fsutil-wim.md) | Provides functions to discover and manage WIM-backed files. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
