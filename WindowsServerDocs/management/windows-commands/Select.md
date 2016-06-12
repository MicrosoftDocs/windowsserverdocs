---
title: select
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9eeb40c0-4258-46e2-8dbc-94f63497e771
---
# select
shifts the focus to a disk, partition, volume, or virtual hard disk \(VHD\).

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
|[select disk](select/select-disk.md)|shifts the focus to a disk.|
|[select partition](select/select-partition.md)|shifts the focus to a partition.|
|[select volume](select/select-volume.md)|shifts the focus to a volume.|
|[select vdisk](select/select-vdisk.md)|shifts the focus to a VHD.|

## remarks

-   if a volume is selected with a corresponding partition, the partition will be automatically selected.

-   if a partition is selected with a corresponding volume, the volume will be automatically selected.

### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


