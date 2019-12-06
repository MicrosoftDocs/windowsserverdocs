---
ms.assetid: 2e748187-6a10-4bb0-aed5-34f886a250d2
title: Fsutil
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 08/21/2018
---
# Fsutil

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Performs tasks that are related to file allocation table (FAT) and NTFS file systems, such as managing reparse points, managing sparse files, or dismounting a volume. If it is used without parameters, **Fsutil** displays a list of supported subcommands. 

> [!Note] 
> You must be logged on as an administrator or a member of the Administrators group to use Fsutil. The Fsutil command is quite powerful and should be used only by advanced users who have a thorough knowledge of Windows operating systems.
>
>You have to enable Windows Subsystem for Linux before you can run **Fsutil**. Run the following command as Administrator in PowerShell to enable this optional feature:
>
>```
> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
>```
> You'll be prompted to restart your computer once it's installed. After your computer restarts, you'll be able to run **Fsutil** as an administrator.

## Parameters

|Subcommand |Description|
|---|---|
|[Fsutil 8dot3name](fsutil-8dot3name.md) | Queries or changes the settings for short name behavior on the system, for example, generates 8.3 character-length file names. Removes short names for all files within a directory. Scans a directory and identifies registry keys that might be impacted if short names were stripped from the files in the directory.|
|[Fsutil behavior](fsutil-behavior.md) |Queries or sets volume behavior.|
|[Fsutil dirty](fsutil-dirty.md)| Queries whether the volume's dirty bit is set or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted.|
|[Fsutil file](fsutil-file.md)|Finds a file by user name (if Disk Quotas are enabled), queries allocated ranges for a file, sets a file's short name, sets a file's valid data length, sets zero data for a file, creates a new file of a specified size, finds a file ID if given the name, or finds a file link name for a specified file ID.|
|[Fsutil fsinfo](fsutil-fsinfo.md)|Lists all drives and queries the drive type, volume information, NTFS-specific volume information, or file system statistics.|
|[Fsutil hardlink](fsutil-hardlink.md)|Lists hard links for a file, or creates a hard link (a directory entry for a file). Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories (or even in the same directory, with different names). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it are deleted. After you create a hard link, programs can use it like any other file name.|
|[Fsutil objectid](fsutil-objectid.md)|Manages object identifiers, which are used by the Windows operating system to track objects such as files and directories.|
|[Fsutil quota](fsutil-quota.md)|Manages disk quotas on NTFS volumes to provide more precise control of network-based storage. Disk quotas are implemented on a per-volume basis and enable both hard- and soft-storage limits to be implemented on a per-user basis.|
|[Fsutil repair](fsutil-repair.md)|Queries or sets the self-healing state of the volume. Self-healing NTFS attempts to correct corruptions of the NTFS file system online without requiring **Chkdsk.exe** to be run. Includes initiating on-disk verification and waiting for repair completion.|
|[Fsutil reparsepoint](fsutil-reparsepoint.md)|Queries or deletes reparse points (NTFS file system objects that have a definable attribute containing user-controlled data). Reparse points are used to extend functionality in the input/output (I/O) subsystem. They are used for directory junction points and volume mount points. They are also used by file system filter drivers to mark certain files as special to that driver.|
|[Fsutil resource](fsutil-resource.md)|Creates a Secondary Transactional Resource Manager, starts or stops a Transactional Resource Manager, displays information about a Transactional Resource Manager  or modifies its behavior.|
|[Fsutil sparse](fsutil-sparse.md)|Manages sparse files. A sparse file is a file with one or more regions of unallocated data in it. A program will see these unallocated regions as containing bytes with the value zero, but no disk space is used to represent these zeros. All meaningful or nonzero data is allocated, whereas all non-meaningful data (large strings of data composed of zeros) is not allocated. When a sparse file is read, allocated data is returned as stored and unallocated data is returned as zeros (by default in accordance with the C2 security requirement specification). Sparse file support allows data to be deallocated from anywhere in the file.|
|[Fsutil tiering](fsutil-tiering.md)|Enables management of storage tier functions, such as setting and disabling flags and listing of tiers.|
|[Fsutil transaction](fsutil-transaction.md)|Commits a specified transaction, rolls back a specified transaction, or displays info about the transaction.|
|[Fsutil usn](fsutil-usn.md)|Manages the update sequence number (USN) change journal, which provides a persistent log of all changes made to files on the volume.|
|[Fsutil volume](fsutil-volume.md)|Manages a volume. Dismounts a volume, queries to see how much free space is available on a disk, or finds a file that is using a specified cluster.|
|[Fsutil wim](fsutil-wim.md)|Provides functions to discover and manage WIM-backed files.|

## See also
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)