---
title: delete partition
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65752312-cb16-46f6-870f-1b95c507b101
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# delete partition



Deletes the partition with focus.

## Syntax

```
delete partition [noerr] [override]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|override|Enables DiskPart to delete any partition regardless of type. Typically, DiskPart only permits you to delete known data partitions.|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

> [!CAUTION]
> Deleting a partition on a dynamic disk can delete all dynamic volumes on the disk, thus destroying any data and leaving the disk in a corrupt state. To delete a dynamic volume, always use the **delete volume** command instead. Partitions can be deleted from dynamic disks, but they should not be created. For example, it is possible to delete an unrecognized GUID Partition Table (GPT) partition on a dynamic GPT disk. Deleting such a partition does not cause the resulting free space to become available. This command is intended to allow you to reclame space on a corrupted offline dynamic disk in an emergency situation where the **clean** command in DiskPart cannot be used.
> -   You cannot delete the system partition, boot partition, or any partition that contains the active paging file or crash dump information.
> -   A partition must be selected for this operation to succeed. Use the **select partition** command to select a partition and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To delete the partition with focus, type:
```
delete partition
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

