---
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
title: Fsutil volume
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil volume
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Dismounts a volume, or queries the hard disk drive to determine how much free space is currently available on the hard disk drive or which file is using a particular cluster.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil volume [allocationreport] <VolumePath>
fsutil volume [diskfree] <VolumePath>
fsutil volume [dismount] <VolumePath>
fsutil volume [filelayout] <VolumePath> <fileid>
fsutil volume [list]
fsutil volume [querycluster] <VolumePath> <Cluster> [<Cluster>] … …
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|allocationreport|Displays information about how storage is used on a given volume.|
|\<VolumePath>|Specifies the drive letter (followed by a colon).|
|diskfree|Queries the hard disk drive to determine the amount of free space on it.|
|dismount|Dismounts a volume.|
|filelayout|Displays NTFS metadata for the given file.|
|\<fileid>|Specifies the file id.|
|list|Lists all of the volumes on the system.|
|querycluster|Finds which file is using a specified cluster. You can specify multiple clusters with the **querycluster** parameter.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|\<cluster>|Specifies the logical cluster number (LCN).|

## <a name="BKMK_examples"></a>Examples
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

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)

[How NTFS Works](https://go.microsoft.com/fwlink/?LinkId=183396)


