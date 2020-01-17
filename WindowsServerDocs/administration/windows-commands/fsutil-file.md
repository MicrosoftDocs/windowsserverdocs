---
ms.assetid: 9f3dc104-dd69-4b03-b824-a29896780164
title: Fsutil file
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil file
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Finds a file by user name (if Disk Quotas are enabled), queries allocated ranges for a file, sets a file's short name, sets a file's valid data length, sets zero data for a file, or creates a new file.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil file [createnew] <filename> <length>
fsutil file [findbysid] <username> <directory>
fsutil file [optimizemetadata] [/A] <filename>
fsutil file [queryallocranges] offset=<offset> length=<length> <filename>
fsutil file [queryextents] [/R] <filename> [<startingvcn> [<numvcns>]]
fsutil file [queryfileid] <filename>
fsutil file [queryfilenamebyid] <volume> <fileid>
fsutil file [queryoptimizemetadata] <filename>
fsutil file [queryvaliddata] [/R] [/D] <filename>
fsutil file [seteof] <filename> <length>
fsutil file [setshortname] <filename> <shortname>
fsutil file [setvaliddata] <filename> <datalength>
fsutil file [setzerodata] offset=<offset> length=<length> <filename>

```

## Parameters

|Parameter|Description|
|-------------|---------------|
|createnew|Creates a file of the specified name and size, with content that consists of zeroes.|
|\<filename>|Specifies the full path to the file including the file name and extension, for example C:\documents\filename.txt.|
|\<length>|Specifies the file's valid data length.|
|findbysid|Finds files that belong to a specified user on NTFS volumes where Disk Quotas are enabled.|
|\<username>|Specifies the user's user name or logon name.|
|\<directory>|Specifies the full path to the directory, for example C:\users.|
|optimizemetadata|This performs an immediate compaction of the metadata for a given file.|
|/A|Analyze file metadata before and after optimization.|
|queryallocranges|Queries the allocated ranges for a file on an NTFS volume. Useful for determining whether a file has sparse regions.|
|offset=\<offset>|Specifies the start of the range that should be set to zeroes.|
|length=\<length>|Specifies the length of the range (in bytes).|
|queryextents|Queries extents for a file.|
|/R|If <filename> is a reparse point, open it rather than its target.|
|\<startingvcn>|Specifies first VCN to query. If omitted, start at VCN 0.|
|\<numvcns>|Number of VCNs to query. If omitted or 0, query until EOF.|
|queryfileid|Queries the file ID of a file on an NTFS volume.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|\<volume>|Specifies the volume as drive name followed by a colon.|
|queryfilenamebyid|Displays a random link name for a specified file ID on an NTFS volume. Since a file can have more than one link name pointing to that file, it is not guaranteed which file link will be provided as a result of the query for the file name.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|\<fileid>|Specifies the ID of the file on an NTFS volume.|
|queryoptimizemetadata|Queries the metadata state of a file.|
|queryvaliddata|Queries the valid data length for a file.|
|/D|Display detailed valid data information.|
|seteof|Sets the EOF of the given file.|
|setshortname|Sets the short name (8.3 character-length file name) for a file on an NTFS volume.|
|\<shortname>|Specifies the file's short name.|
|setvaliddata|Sets the valid data length for a file on an NTFS volume.|
|\<datalength>|Specifies the length of the file in bytes.|
|setzerodata|Sets a range (specified by *Offset* and *Length*) of the file to zeroes, which empties the file. If the file is a sparse file, the underlying allocation units are decommitted.|

## Remarks

-   In NTFS, there are two IMPORTANT concepts of file length: the end-of-file (EOF) marker and the Valid Data Length (VDL). The EOF indicates the actual length of the file. The VDL identifies the length of valid data on disk. Any reads between VDL and EOF automatically return 0 to preserve the C2 object reuse requirement.

-   The **setvaliddata** parameter is only available for administrators because it requires the Perform volume maintenance tasks (SeManageVolumePrivilege) privilege. This feature is only required for advanced multimedia and system area network scenarios. The **setvaliddata** parameter must be a positive value that is greater than the current VDL, but less than the current file size.

    It is useful for programs to set a VDL when:

    -   Writing raw clusters directly to disk through a hardware channel. This allows the program to inform the file system that this range contains valid data that can be returned to the user.

    -   Creating large files when performance is an issue. This avoids the time it takes to fill the file with zeroes when the file is created or extended.

## <a name="BKMK_examples"></a>Examples
To find files that are owned by scottb on drive C, type:

```
fsutil file findbysid scottb c:\users  
```

To query the allocated ranges for a file on an NTFS volume, type:

```
fsutil file queryallocranges offset=1024 length=64 c:\temp\sample.txt  
```

To optimize metadata for a file, type:

```
fsutil file optimizemetadata C:\largefragmentedfile.txt
```

To query the extents for a file, type:

```
fsutil file queryextents C:\Temp\sample.txt
```

To set the EOF for a file, type:

```
fsutil file seteof C:\testfile.txt 1000
```

To set the short name for the file Longfilename.txt on drive C to Longfile.txt, type:

```
fsutil file setshortname c:\longfilename.txt longfile.txt  
```

To set the valid data length to 4096 bytes for a file named Testfile.txt on an NTFS volume, type:

```
fsutil file setvaliddata c:\testfile.txt 4096  
```

To set a range of a file on an NTFS volume to zeros to empty it, type:

```
fsutil file setzerodata offset=100 length=150 c:\temp\sample.txt  
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


