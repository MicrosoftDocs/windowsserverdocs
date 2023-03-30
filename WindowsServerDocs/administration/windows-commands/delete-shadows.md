---
title: delete shadows
description: Reference article for the delete shadows command, which deletes shadow copies.
ms.topic: reference
ms.assetid: e29a84d2-04d1-4eb1-910a-5a47bddbc24d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# delete shadows

Deletes shadow copies.

## Syntax

```
delete shadows [all | volume <volume> | oldest <volume> | set <setID> | id <shadowID> | exposed {<drive> | <mountpoint>}]
```

### Parameters

| Parameter | Description |
| ---- | ---- |
| all | Deletes all shadow copies. |
| volume `<volume>` | Deletes all shadow copies of the given volume. |
| oldest `<volume>` | Deletes the oldest shadow copy of the given volume. |
| set `<setID>` | Deletes the shadow copies in the Shadow Copy Set of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment. |
| id `<shadowID>` | Deletes a shadow copy of the given ID. You can specify an alias by using the **%** symbol if the alias exists in the current environment. |
| exposed {`<drive>` \| `<mountpoint>`} | Deletes shadow copies exposed at the specified drive or mount point. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [delete command](delete.md)
