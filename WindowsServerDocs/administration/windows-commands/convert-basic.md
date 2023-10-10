---
title: convert basic
description: Reference article for the convert basic command, which converts an empty dynamic disk to a basic disk.
ms.topic: reference
ms.assetid: 61329896-3b56-4959-8d58-45cbe18ba860
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert basic

Converts an empty dynamic disk to a basic disk. A dynamic disk must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a dynamic disk and shift the focus to it.

> [!IMPORTANT]
> The disk must be empty to convert it to a basic disk. Back up your data, and then delete all partitions or volumes before converting the disk.

> [!NOTE]
> For instructions regarding how to use this command, see [Change a Dynamic Disk Back to a Basic Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc755238(v=ws.11))).

## Syntax

```
convert basic [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To convert the selected dynamic disk to basic, type:

```
convert basic
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [convert command](convert.md)
