---
title: bdehdcfg size
description: Reference article for the bdehdcfg size command, which specifies the size of the system partition when a new system drive is being created.
ms.topic: reference
ms.assetid: 80f55b1d-a28d-4edf-9997-1fb918b7b5a1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bdehdcfg: size

Specifies the size of the system partition when a new system drive is being created. If you do not specify a size, the tool will use the default value of 300 MB. The minimum size of the system drive is 100 MB. If you will store system recovery or other system tools on the system partition, you should increase the size accordingly.

> [!NOTE]
> The **size** command cannot be combined with the `target <drive_letter> merge` command.

## Syntax

```
bdehdcfg -target {default|unallocated|<drive_letter> shrink} -size <size_in_mb>
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<size_in_mb>` | Indicates the number of megabytes (MB) to use for the new partition. |

## Examples

To allocate 500 MB to the default system drive:

```
bdehdcfg -target default -size 500
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
