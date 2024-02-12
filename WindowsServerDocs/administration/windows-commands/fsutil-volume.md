---
title: fsutil volume
description: Reference article for the fsutil volume command, which dismounts a volume, or queries the hard disk drive to determine how much free space is currently available on the hard disk drive or which file is using a particular cluster.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil volume

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Dismounts a volume, or queries the hard disk drive to determine how much free space is currently available on the hard disk drive or which file is using a particular cluster.

## Syntax

```
fsutil volume [allocationreport] <volumepath>
fsutil volume [diskfree] <volumepath>
fsutil volume [dismount] <volumepath>
fsutil volume [filelayout] <volumepath> <fileID>
fsutil volume [list]
fsutil volume [querycluster] <volumepath> <cluster> [<cluster>] … …
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| allocationreport | Displays information about how storage is used on a given volume. |
| `<volumepath>` | Specifies the drive letter (followed by a colon). |
| diskfree | Queries the hard disk drive to determine the amount of free space on it. |
| dismount | Dismounts a volume. |
| filelayout | Displays NTFS metadata for the given file. |
| `<fileID>` | Specifies the file id. |
| list | Lists all of the volumes on the system. |
| querycluster | Finds which file is using a specified cluster. You can specify multiple clusters with the **querycluster** parameter. |
| `<cluster>` | Specifies the logical cluster number (LCN). |

### Examples

To display an allocated clusters report, type:

```
fsutil volume allocationreport C:
```

To dismount a volume on drive C, type:

```
fsutil volume dismount c:
```

To query the amount of free space of a volume on drive C, type:

```
fsutil volume diskfree c:
```

To display all the information about a specified file(s), type:

```
fsutil volume C: *
fsutil volume C:\Windows
fsutil volume C: 0x00040000000001bf
```

To list the volumes on disk, type:

```
fsutil volume list
```

To find the file(s) that are using the clusters, specified by the logical cluster numbers 50 and 0x2000, on drive C, type:

```
fsutil volume querycluster C: 50 0x2000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)

- [How NTFS Works](/previous-versions/windows/it-pro/windows-server-2003/cc781134(v=ws.10))
