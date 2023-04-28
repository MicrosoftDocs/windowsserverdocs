---
title: mask
description: Reference article for the mask command, which removes hardware shadow copies that were imported by using the import command.
ms.topic: reference
ms.assetid: bf301474-d74a-44e7-9fad-c8a11e7ca3bd
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# mask

Removes hardware shadow copies that were imported by using the **import** command.

## Syntax

```
mask <shadowsetID>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| shadowsetID | Removes shadow copies that belong to the specified Shadow Copy Set ID. |

#### Remarks

- You can use an existing alias or an environment variable in place of *ShadowSetID*. Use **add** without parameters to see existing aliases.

### Examples

To remove the imported shadow copy *%Import_1%*, type:

```
mask %Import_1%
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)