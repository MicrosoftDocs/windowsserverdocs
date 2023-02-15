---
title: bdehdcfg newdriveletter
description: Reference article for the bdehdcfg newdriveletter command, which assigns a new drive letter to the portion of a drive used as the system drive.
ms.topic: reference
ms.assetid: f1f200a0-6850-4f0d-9047-f9f982a590f8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bdehdcfg: newdriveletter

Assigns a new drive letter to the portion of a drive used as the system drive. As a best practice, we recommend not assigning a drive letter to your system drive.

## Syntax

```
bdehdcfg -target {default|unallocated|<drive_letter> shrink|<drive_letter> merge} -newdriveletter <drive_letter>
```

#### Parameters

| Parameter | Description |
| ---------| ----------- |
| `<drive_letter>` | Defines the drive letter that will be assigned to the specified target drive. |

## Examples

To assign the default drive the drive letter `P`:

```
bdehdcfg -target default -newdriveletter P:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
