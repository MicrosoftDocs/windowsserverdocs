---
title: Fsutil
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 097de37c-812c-47b0-872b-4b55ea32b27f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Fsutil

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Performs tasks that are related to file allocation table \(FAT\) and NTFS file systems, such as managing reparse points, managing sparse files, or dismounting a volume. If it is used without parameters, **fsutil** displays a list of supported subcommands.  
  
> [!NOTE]  
> You must be logged on as an administrator or a member of the Administrators group to use **fsutil**. The **fsutil** command is quite powerful and should be used only by advanced users who have a thorough knowledge of Windows operating systems.  
  
## Parameters  
The following table lists the **fsutil** subcommands.  
  
|Subcommand|Description|  
|--------------|---------------|  
|[Fsutil 8dot3name](Fsutil-8dot3name.md)|Queries or changes the settings for short name behavior on the system, for example, generates 8.3 character\-length file names. Removes short names for all files within a directory. Scans a directory and identifies registry keys that might be impacted if short names were stripped from the files in the directory.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|  
|[Fsutil behavior](Fsutil-behavior.md)|Queries or sets NTFS volume behavior, which includes:<br /><br />-   The last access time stamp on NTFS volumes<br />-   How often quota events are written to the system log<br />-   The internal cache levels of NTFS paged pool and NTFS non\-paged pool memory<br />-   The amount of disk space reserved for the master file table \(MFT\) Zone<br />-   The silent deletion of data when the system encounters corruption on an NTFS volume.|  
|[Fsutil dirty](Fsutil-dirty.md)|Queries whether the volume's dirty bit is set or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted.|  
|[Fsutil file](Fsutil-file.md)|Finds a file by user name \(if Disk Quotas are enabled\), queries allocated ranges for a file, sets a file's short name, sets a file's valid data length, sets zero data for a file, creates a new file of a specified size, finds a file ID if given the name, or finds a file link name for a specified file ID.|  
|[Fsutil fsinfo](Fsutil-fsinfo.md)|Lists all drives and queries the drive type, volume information, NTFS\-specific volume information, or file system statistics.|  
|[Fsutil hardlink](Fsutil-hardlink.md)|Creates a hard link \(a directory entry for a file\). Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories \(or even in the same directory, with different names\). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it are deleted. After you create a hard link, programs can use it like any other file name.<br /><br />Lists the hard links for a specified file.|  
|[Fsutil objectid](Fsutil-objectid.md)|Manages object identifiers, which are used by the Windows operating system to track objects such as files and directories.|  
|[Fsutil quota](Fsutil-quota.md)|Manages disk quotas on NTFS volumes to provide more precise control of network\-based storage. Disk quotas are implemented on a per\-volume basis and enable both hard\- and soft\-storage limits to be implemented on a per\-user basis.|  
|[Fsutil repair](Fsutil-repair.md)|Queries or sets the self\-healing state of the volume. Self\-healing NTFS attempts to correct corruptions of the NTFS file system online without requiring **Chkdsk.exe** to be run.<br /><br />Includes initiating on\-disk verification and waiting for repair completion.|  
|[Fsutil reparsepoint](Fsutil-reparsepoint.md)|Queries or deletes reparse points \(NTFS file system objects that have a definable attribute containing user\-controlled data\). Reparse points are used to extend functionality in the input\/output \(I\/O\) subsystem. They are used for directory junction points and volume mount points. They are also used by file system filter drivers to mark certain files as special to that driver.<br /><br />This parameter applies to: Windows Vista,  Windows Server 2008 ,  Windows Server 2008 R2 , and  Windows 7 .|  
|[Fsutil resource](Fsutil-resource.md)|Creates a Secondary Transactional Resource Manager, starts or stops a Transactional Resource Manager, or displays information about a Transactional Resource Manager and modifies the following behavior:<br /><br />-   Whether a default Transactional Resource Manager will clean its transactional metadata at the next mount<br />-   The specified Transactional Resource Manager to prefer consistency over availability<br />-   The specified Transaction Resource Manager to prefer availability over consistency<br />-   The characteristics of a running Transactional Resource Manager<br /><br />This parameter applies to: Windows Vista,  Windows Server 2008 ,  Windows Server 2008 R2 , and  Windows 7 .|  
|[Fsutil sparse](Fsutil-sparse.md)|Manages sparse files. A sparse file is a file with one or more regions of unallocated data in it. A program will see these unallocated regions as containing bytes with the value zero, but no disk space is used to represent these zeros. All meaningful or nonzero data is allocated, whereas all non\-meaningful data \(large strings of data composed of zeros\) is not allocated. When a sparse file is read, allocated data is returned as stored and unallocated data is returned as zeros \(by default in accordance with the C2 security requirement specification\). Sparse file support allows data to be deallocated from anywhere in the file.|  
|[Fsutil transaction](Fsutil-transaction.md)|Commits a specified transaction, rolls back a specified transaction, or displays the following information:<br /><br />1.  A list of currently running transactions<br />2.  Transaction information for a specific file<br />3.  Information for a specific transaction<br />    This parameter applies to: Windows Vista,  Windows Server 2008 ,  Windows Server 2008 R2 , and  Windows 7 .|  
|[Fsutil usn](Fsutil-usn.md)|Manages the update sequence number \(USN\) change journal, which provides a persistent log of all changes made to files on the volume.|  
|[Fsutil volume](Fsutil-volume.md)|Manages a volume. Dismounts a volume, queries to see how much free space is available on a disk, or finds a file that is using a specified cluster.|  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

