---
title: expose
description: Reference article for the expose command, which exposes a persistent shadow copy as a drive letter, share, or mount point.
ms.topic: reference
ms.assetid: 9b0a21cf-3bef-4ade-b8f1-ac42f9203947
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# expose

Exposes a persistent shadow copy as a drive letter, share, or mount point.

## Syntax

```
expose <shadowID> {<drive:> | <share> | <mountpoint>}
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| shadowID | Specifies the shadow ID of the shadow copy you want to expose. You can also use an existing alias or an environment variable in place of *shadowID*. Use **add** without parameters to see existing aliases. |
| `<drive:>` | Exposes the specified shadow copy as a drive letter (for example, `p:`). |
| `<share>` | Exposes the specified shadow copy at a share (for example, `\\machinename`).   |
| `<mountpoint>` | Exposes the specified shadow copy to a mount point (for example, `C:\shadowcopy`). |

### Examples

To expose the persistent shadow copy associated with the VSS_SHADOW_1 environment variable as drive X, type:

```
expose %vss_shadow_1% x:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diskshadow command](diskshadow.md)
