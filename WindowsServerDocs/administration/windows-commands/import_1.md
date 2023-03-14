---
title: import diskpart
description: Reference article for the import command, which imports a foreign disk group into the disk group of the local computer.
ms.topic: reference
ms.assetid: 4b9d2751-7637-4738-83b0-8c578eb28f27
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# import (diskpart)

Imports a foreign disk group into the disk group of the local computer. This command imports every disk that is in the same group as the disk with focus.

> [IMPORTANT]
> Before you can use this command, you must use the [select disk command](select-disk.md) to select a dynamic disk in a foreign disk group and shift the focus to it.

## Syntax

```
import [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To import every disk that is in the same disk group as the disk with focus into the disk group of the local computer, type:

```
import
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diskpart command](diskpart.md)
