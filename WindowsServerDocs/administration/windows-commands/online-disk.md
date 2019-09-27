---
title: online disk
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bc44a783-eaa4-40ca-be01-5703b5bf4eb3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# online disk



Brings disks that are currently offline to an online state.

> [!IMPORTANT]
> This command is not available in any edition of Windows Vista.

> [!IMPORTANT]
> This command will fail if it is used on a read-only disk.

For instructions regarding how to use this command, see [Reactivate a Missing or Offline Dynamic Disk](https://go.microsoft.com/fwlink/?LinkId=207046) (https://go.microsoft.com/fwlink/?LinkId=207046).

## Syntax

```
online disk [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   When used without parameters in Windows Vista, this command operates on a disk group. For basic disks, there is never more than one disk per group. For dynamic disks, the group includes all non-foreign dynamic disks.
-   For basic disks, this command will attempt to bring online the selected disk and all volumes on that disk.
-   For dynamic disks, this command will attempt to bring online all disks that are not marked as foreign on the local computer. It will also attempt to bring online all volumes on the set of dynamic disks.
-   If a dynamic disk in a disk group is brought online and it is the only disk in the group, then the original group is recreated and the disk is moved to that group. If there are other disks in the group and they are online, then the disk is simply added back into the group.
-   If the group of a selected disk contains mirrored or RAID-5 volumes, this command also resynchronizes these volumes.
-   A disk must be selected for this command to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To bring the disk with focus online, type:
```
online disk
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

