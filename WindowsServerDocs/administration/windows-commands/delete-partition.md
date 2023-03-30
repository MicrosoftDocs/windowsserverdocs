---
title: delete partition
description: Reference article for the delete partition command, which deletes the partition with focus.
ms.topic: reference
ms.assetid: 65752312-cb16-46f6-870f-1b95c507b101
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# delete partition

Deletes the partition with focus. Before you begin, you must select a partition for this operation to succeed. Use the [select partition](select-partition.md) command to select a partition and shift the focus to it.

> [!WARNING]
> Deleting a partition on a dynamic disk can delete all dynamic volumes on the disk, destroying any data and leaving the disk in a corrupt state.
>
> You can't delete the system partition, boot partition, or any partition that contains the active paging file or crash dump information.

## Syntax

```
delete partition [noerr] [override]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |
| override | Enables DiskPart to delete any partition regardless of type. Typically, DiskPart only permits you to delete known data partitions. |

#### Remarks

- To delete a dynamic volume, always use the [delete volume](delete-volume.md) command instead.

- Partitions can be deleted from dynamic disks, but they shouldn't be created. For example, it's possible to delete an unrecognized GUID Partition Table (GPT) partition on a dynamic GPT disk. Deleting such a partition doesn't cause the resulting free space to become available. Instead, This command is intended to allow you to reclaim space on a corrupted offline dynamic disk in an emergency situation where the [clean](clean.md) command in DiskPart can't be used.

## Examples

To delete the partition with focus, type:

```
delete partition
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select partition](select-partition.md)

- [delete command](delete.md)

- [delete volume command](delete-volume.md)

- [clean command](clean.md)
