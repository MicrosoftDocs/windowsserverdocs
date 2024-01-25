---
title: remove
description: Reference article for the remove command, which removes a drive letter or mount point from a volume.
ms.topic: reference
ms.assetid: b0886140-da8b-4231-8cb2-f280874d99c0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# remove

Removes a drive letter or mount point from the volume with focus. If the all parameter is used, all current drive letters and mount points are removed. If no drive letter or mount point is specified, then DiskPart removes the first drive letter or mount point it encounters.

The remove command can also be used to change the drive letter associated with a removable drive. You can't remove the drive letters on system, boot, or paging volumes. In addition, you can't remove the drive letter for an OEM partition, any GPT partition with an unrecognized GUID, or any of the special, non-data, GPT partitions such as the EFI system partition.

> [!NOTE]
> A volume must be selected for the **remove** command to succeed. Use the [select volume](select-volume.md) command to select a disk and shift the focus to it.

## Syntax

```
remove [{letter=<drive> | mount=<path> [all]}] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| letter=`<drive>` | The drive letter to remove. |
| mount=`<path>` | The mount point path to remove. |
| all | Removes all current drive letters and mount points. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To remove the d:\ drive, type:

```
remove letter=d
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
