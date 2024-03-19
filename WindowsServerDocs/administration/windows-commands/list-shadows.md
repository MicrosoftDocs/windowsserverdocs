---
title: list shadows
description: Reference article for the list shadows command, which lists persistent and existing non-persistent shadow copies that are on the system.
ms.topic: reference
ms.assetid: fe568423-00ae-4ede-a1e7-07977cb50ad1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# list shadows

Lists persistent and existing non-persistent shadow copies that are on the system.

## Syntax

```
list shadows {all | set <setID> | id <shadowID>}
```

### Parameters

| Parameter | Description |
| ---------- | ---------- |
| all | Lists all shadow copies. |
| set `<setID>` | Lists shadow copies that belong to the specified Shadow Copy Set ID. |
| id `<shadowID>` | Lists any shadow copy with the specified shadow copy ID. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)