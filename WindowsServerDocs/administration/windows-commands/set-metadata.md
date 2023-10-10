---
title: set metadata
description: Reference article for the set metadata command, which sets the name and location of the shadow creation metadata file used to transfer shadow copies from one computer to another.
ms.topic: reference
ms.assetid: 67e6f60a-b42a-451a-95cf-b22ace7d50c2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# set metadata

Sets the name and location of the shadow creation metadata file used to transfer shadow copies from one computer to another. If used without parameters, **set metadata** displays help at the command prompt.

## Syntax

```
set metadata [<drive>:][<path>]<metadata.cab>
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:][<path>]` | Specifies the location to create the metadata file. |
| `<metadata.cab>` | Specifies the name of the cab file to store shadow creation metadata. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [set context command](set-context.md)

- [set option command](set-option.md)

- [set verbose command](set-verbose.md)
