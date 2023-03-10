---
title: Fsutil fsinfo
description: Reference article for the fsutil fsinfo command, which lists all drives, queries the drive type, queries volume information, queries NTFS-specific volume information, or queries file system statistics.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 7787a72e-a26b-415f-b700-a32806803478
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil fsinfo

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Lists all drives, queries the drive type, queries volume information, queries NTFS-specific volume information, or queries file system statistics.

## Syntax

```
fsutil fsinfo [drives]
fsutil fsinfo [drivetype] <volumepath>
fsutil fsinfo [ntfsinfo] <rootpath>
fsutil fsinfo [statistics] <volumepath>
fsutil fsinfo [volumeinfo] <rootpath>
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| drives | Lists all drives in the computer. |
| drivetype | Queries a drive and lists its type, for example CD-ROM drive. |
| ntfsinfo | Lists NTFS specific volume information for the specified volume, such as the number of sectors, total clusters, free clusters, and the start and end of the MFT Zone. |
| sectorinfo | Lists information about the hardware's sector size and alignment. |
| statistics | Lists file system statistics for the specified volume, such as metadata, log file, and MFT reads and writes. |
| volumeinfo | Lists information for the specified volume, such as the file system, and whether the volume supports case-sensitive file names, unicode in file names, disk quotas, or is a DirectAccess (DAX) volume. |
| `<volumepath>:` | Specifies the drive letter (followed by a colon). |
| `<rootpath>:` | Specifies the drive letter (followed by a colon) of the root drive. |

### Examples

To list all of the drives in the computer, type:

```
fsutil fsinfo drives
```

Output similar to the following displays:

```
Drives: A:\ C:\ D:\ E:\
```

To query the drive type of drive C, type:

```
fsutil fsinfo drivetype c:
```

Possible results of the query include:

```
Unknown Drive
No such Root Directory
Removable Drive, for example floppy
Fixed Drive
Remote/Network Drive
CD-ROM Drive
Ram Disk
```

To query the volume information for volume E, type:

```
fsutil fsinfo volumeinfo e:
```

Output similar to the following displays:

```
Volume Name : Volume
Serial Number : 0xd0b634d9
Max Component Length : 255
File System Name : NTFS
Supports Named Streams
Is DAX Volume
```

To query drive F for NTFS-specific volume information, type:

```
fsutil fsinfo ntfsinfo f:
```

Output similar to the following displays:

```
NTFS Volume Serial Number : 0xe660d46a60d442cb
Number Sectors : 0x00000000010ea04f
Total Clusters : 0x000000000021d409
Mft Zone End : 0x0000000000004700
```

To query the file system's underlying hardware for sector information, type:

```
fsutil fsinfo sectorinfo d:
```

Output similar to the following displays:

```
D:\>fsutil fsinfo sectorinfo d:
LogicalBytesPerSector : 4096
PhysicalBytesPerSectorForAtomicity : 4096
Trim Not Supported
DAX capable
```

To query the file system statistics for drive E, type:

```
fsutil fsinfo statistics e:
```

Output similar to the following displays:

```
File System Type : NTFS
Version : 1
UserFileReads : 75021
UserFileReadBytes : 1305244512
LogFileWriteBytes : 180936704
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
