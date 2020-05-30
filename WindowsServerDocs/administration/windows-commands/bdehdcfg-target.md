---
title: bdehdcfg target
description: Reference topic for the bdehdcfg target command, which prepares a partition for use as a system drive by BitLocker and Windows recovery.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: f761d25d-8349-4ac7-ac46-6bb340a4348f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bdehdcfg: target

Prepares a partition for use as a system drive by BitLocker and Windows Recovery. By default, this partition is created without a drive letter.

## Syntax

```
bdehdcfg -target {default|unallocated|<drive_letter> shrink|<drive_letter> merge}
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| default | Indicates that the command-line tool will follow the same process as the BitLocker setup wizard. |
| unallocated | Creates the system partition out of the unallocated space available on the disk. |
| `<drive_letter>` shrink | Reduces the drive specified by the amount necessary to create an active system partition. To use this command, the drive specified must have at least 5 percent free space. |
| `<drive_letter>` merge | Uses the drive specified as the active system partition. The operating system drive cannot be a target for merge. |

## Examples

To designate an existing drive (P) as the system drive:

```
bdehdcfg -target P: merge
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
