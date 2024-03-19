---
title: unexpose
description: Reference article for the unexpose command, which unexposes an exposed shadow copy.
ms.topic: reference
ms.assetid: 58dc7d0f-52e9-4587-9487-d3b4c3e52640
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# unexpose

Unexposes a shadow copy that was exposed by using the [expose command](expose.md). The exposed shadow copy can be specified by its Shadow ID, drive letter, share, or mount point.

## Syntax

```
unexpose {<shadowID> | <drive:> | <share> | <mountpoint>}
```

### Parameters

| Parameter | Description |
|--|--|
| `<shadowID>` | Displays the shadow copy specified by the given Shadow ID. You can use an existing alias or an environment variable in place of `<shadowID>`. Use the [add command](add.md) without parameters to see all existing aliases. |
| `<drive:>` | Displays the shadow copy associated with the specified drive letter (for example, drive P). |
| `<share>` | Displays the shadow copy associated with the specified share (for example, `\\MachineName`). |
| `<mountpoint>` | Displays the shadow copy associated with the specified mount point (for example, `C:\shadowcopy\`). |
| add | Used without parameters will show you the existing aliases. |

## Examples

To unexpose the shadow copy associated with *drive P:\*, type:

```
unexpose P:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [add command](add.md)

- [expose command](expose.md)
