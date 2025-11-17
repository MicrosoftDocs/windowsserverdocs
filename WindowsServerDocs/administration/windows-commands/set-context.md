---
title: Set context
description: Reference article for the set context command, which sets the context for shadow copy creation.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# Set context

Sets the context for shadow copy creation. If used without parameters, **set context** displays help at the command prompt.

## Syntax

```
set context {clientaccessible | persistent [nowriters] | volatile [nowriters]}
```

### Parameters

| Parameter | Description |
|--|--|
| clientaccessible | Specifies that the shadow copy is usable by client versions of Windows. This context is persistent by default. |
| persistent | Specifies that the shadow copy persists across program exit, reset, or restart. |
| volatile | Deletes the shadow copy on exit or reset. |
| nowriters | Specifies that all writers are excluded. |

## Examples

To prevent shadow copies from being deleted when you exit DiskShadow, type:

```
set context persistent
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [set metadata command](set-metadata.md)

- [set option command](set-option.md)

- [set verbose command](set-verbose.md)
