---
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
title: Fsutil volume
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 11/07/2016
---
# Fsutil volume
>Applies To: Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Dismounts a volume, or queries the hard disk drive to determine how much free space is currently available on the hard disk drive or which file is using a particular cluster.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil volume [diskfree] <VolumePath>
fsutil volume [dismount] <VolumePath>
fsutil volume [querycluster] <VolumePath> <Cluster> [<Cluster>] … …
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|allocationreport|Allocated clusters report.|
|diskfree|Queries the hard disk drive to determine the amount of free space on it.|
|dismount|Dismounts a volume.|
|<VolumePath>|Specifies the drive letter (followed by a colon).|
|filelayout|Queries all the information available about the specified file(s).|
|list|Lists the volumes on the disk.|
|querycluster|Finds which file is using a specified cluster. You can specify multiple clusters with the **querycluster** parameter.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|
|<cluster>|Specifies the logical cluster number (LCN).|

## <a name="BKMK_examples"></a>Examples
To dismount a volume on drive C, type:

```
fsutil volume dismount c:
```

To query the amount of free space of a volume on drive C, type:

```
fsutil volume diskfree c:
```

To find the file(s) that are using the clusters, specified by the logical cluster numbers 50 and 0x2000, on drive C, type:

```
fsutil volume querycluster C: 50 0x2000
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)

[How NTFS Works](http://go.microsoft.com/fwlink/?LinkId=183396)


