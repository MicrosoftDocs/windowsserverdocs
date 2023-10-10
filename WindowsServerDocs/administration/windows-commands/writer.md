---
title: writer
description: Reference article for the writer command, which verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure.
ms.topic: reference
ms.assetid: 7cf98295-411d-4705-8573-f898ff45c140
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# writer

Verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure. If used without parameters, **writer** displays help at the command prompt.

## Syntax

```
writer verify [writer> | <component>]
writer exclude [<writer> | <component>]
```

### Parameters

| Parameter | Description |
|--|--|
| verify | Verifies that the specified writer or component is included in the backup or restore procedure. The backup or restore procedure will fail if the writer or component is not included. |
| exclude | Excludes the specified writer or component from the backup or restore procedure. |

## Examples

To verify a writer by specifying its GUID (for this example, 4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f), type:

```
writer verify {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f}
```

To exclude a writer with the name *System Writer*, type:

```
writer exclude System Writer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
