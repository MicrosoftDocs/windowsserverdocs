---
title: convert
description: Reference article for the convert command, which converts a disk from one disk type to another.
ms.topic: reference
ms.assetid: ae151297-af21-4701-bd69-21d775518e03
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert

Converts a disk from one disk type to another.

## Syntax

```
convert basic
convert dynamic
convert gpt
convert mbr
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [convert basic command](convert-basic.md) | Converts an empty dynamic disk into a basic disk. |
| [convert dynamic command](convert-dynamic.md) | Converts a basic disk into a dynamic disk. |
| [convert gpt command](convert-gpt.md) | Converts an empty basic disk with the master boot record (MBR) partition style into a basic disk with the GUID partition table (GPT) partition style. |
| [convert mbr command](convert-mbr.md) | Converts an empty basic disk with the GUID Partition Table (GPT) partition style into a basic disk with the master boot record (MBR) partition style. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
