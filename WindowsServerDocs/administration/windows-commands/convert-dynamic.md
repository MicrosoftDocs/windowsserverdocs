---
title: convert dynamic
description: Reference article for the convert dynamic command, which converts a basic disk into a dynamic disk.
ms.topic: reference
ms.assetid: 7b8fa4b1-850f-4e48-b05f-871c883ea33c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert dynamic

Converts a basic disk into a dynamic disk. A basic disk must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a basic disk and shift the focus to it.

> [!NOTE]
> For instructions regarding how to use this command, see [Change a Dynamic Disk Back to a Basic Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc755238(v=ws.11))).

## Syntax

```
convert dynamic [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- Any existing partitions on the basic disk become simple volumes.

## Examples

To convert a basic disk into a dynamic disk, type:

```
convert dynamic
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [convert command](convert.md)
