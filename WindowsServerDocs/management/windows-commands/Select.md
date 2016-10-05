---
title: Select
description: "Windows Commands"
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
# Select
Shifts the focus to a disk, partition, volume, or virtual hard disk (VHD).
## Syntax
```
select disk
select partition
select volume
select vdisk
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[Select disk](Select-disk.md)|Shifts the focus to a disk.|
|[Select partition](Select-partition.md)|Shifts the focus to a partition.|
|[Select volume](Select-volume.md)|Shifts the focus to a volume.|
|[Select vdisk](Select-vdisk.md)|Shifts the focus to a VHD.|
## Remarks
-   If a volume is selected with a corresponding partition, the partition will be automatically selected.
-   If a partition is selected with a corresponding volume, the volume will be automatically selected.
### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)
