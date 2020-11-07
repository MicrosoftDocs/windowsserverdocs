---
title: reg import
description: Reference article for the reg import command, which copies the contents of a file that contains exported registry subkeys, entries, and values into the registry of the local computer.
ms.topic: reference
ms.assetid: 0be103de-08fc-4f02-b590-361782680b3e
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# reg import

Copies the contents of a file that contains exported registry subkeys, entries, and values into the registry of the local computer.

## Syntax

```
reg import <filename>
```

### Parameters

| Parameter | Description |
|--|--|
| `<filename>` | Specifies the name and path of the file that has content to be copied into the registry of the local computer. This file must be created in advance by using **reg export**. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg import** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To import registry entries from the file named AppBkUp.reg, type:

```
reg import AppBkUp.reg
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [reg export command](reg-export.md)
