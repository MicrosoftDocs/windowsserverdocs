---
title: Fsutil file
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5218abea-2a19-468c-b275-71ebce5aa667
---
# Fsutil file
Finds a file by user name (if Disk Quotas are enabled), queries allocated ranges for a file, sets a file's short name, sets a file's valid data length, sets zero data for a file, or creates a new file.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil file [createnew] <FileName> <Length>
fsutil file [findbysid] <UserName> <Directory>
fsutil file [queryallocranges] offset=<Offset> length=<Length> <FileName>
fsutil file [quaeryfileid] <FileName>
fsutil file [queryfilenamebyid] <Volume> <Fileid>
fsutil file [setshortname] <FileName> <ShortName>
fsutil file [setvaliddata] <FileName> <DataLength>
fsutil file [setzerodata] offset=<Offset> length=<Length> <FileName>

```

## Parameters

|Parameter|Description|
|-------------|---------------|
|createnew|Creates a file of the specified name and size, with content that consists of zeroes.|
|<FileName>|Specifies the full path to the file including the file name and extension, for example C:\documents\filename.txt.|
|<Length>|Specifies the file's valid data length.|
|findbysid|Finds files that belong to a specified user on NTFS volumes where Disk Quotas are enabled.|
|<UserName>|Specifies the user's user name or logon name.|
|<Directory>|Specifies the full path to the directory, for example C:\users.|
|queryallocranges|Queries the allocated ranges for a file on an NTFS volume. Useful for determining whether a file has sparse regions.|
|offset=<Offset>|Specifies the start of the range that should be set to zeroes.|
|length=<Length>|Specifies the length of the range (in bytes).|
|queryfileid|Queries the file ID of a file on an NTFS volume.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|queryfilenamebyid|Displays a random link name for a specified file ID on an NTFS volume. Since a file can have more than one link name pointing to that file, it is not guaranteed which file link will be provided as a result of the query for the file name.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|<Fileid>|Specifies the ID of the file on an NTFS volume.|
|<Volume>|Specifies the volume as drive name followed by a colon.|
|setshortname|Sets the short name (8.3 character-length file name) for a file on an NTFS volume.|
|<ShortName>|Specifies the file's short name.|
|setvaliddata|Sets the valid data length for a file on an NTFS volume.|
|<DataLength>|Specifies the length of the file in bytes.|
|setzerodata|Sets a range (specified by *Offset* and *Length*) of the file to zeroes, which empties the file. If the file is a sparse file, the underlying allocation units are decommitted.|

## Remarks

-   In NTFS, there are two important concepts of file length: the end-of-file (EOF) marker and the Valid Data Length (VDL). The EOF indicates the actual length of the file. The VDL identifies the length of valid data on disk. Any reads between VDL and EOF automatically return 0 to preserve the C2 object reuse requirement.

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
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


