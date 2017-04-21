---
title: select
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9eeb40c0-4258-46e2-8dbc-94f63497e771
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# select

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

shifts the focus to a disk, partition, volume, or virtual hard disk (VHD).
## Syntax
```
select disk
select partition
select volume
select vdisk
```
## Parameters
|Parameter|Description|
|-------|--------|
|[select disk](select-disk.md)|shifts the focus to a disk.|
|[select partition](select-partition.md)|shifts the focus to a partition.|
|[select volume](select-volume.md)|shifts the focus to a volume.|
|[select vdisk](select-vdisk.md)|shifts the focus to a VHD.|
## remarks
-   if a volume is selected with a corresponding partition, the partition will be automatically selected.
-   if a partition is selected with a corresponding volume, the volume will be automatically selected.
### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)

