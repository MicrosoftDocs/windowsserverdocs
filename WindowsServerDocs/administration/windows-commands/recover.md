---
title: recover
description: Reference article for the recover command, which recovers readable information from a bad or defective disk.
ms.topic: reference
ms.assetid: cf9be2e3-90c8-4773-a201-dc503b91948e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# recover

Recovers readable information from a bad or defective disk. This command reads a file, sector-by-sector, and recovers data from the good sectors. Data in bad sectors is lost. Because all data in bad sectors is lost when you recover a file, you should recover only one file at a time.

Bad sectors reported by the **chkdsk** command were marked as bad when your disk was prepared for operation. They pose no danger, and **recover** does not affect them.

## Syntax

```
recover [<drive>:][<path>]<filename>
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:][<path>]<filename>` | Specifies the file name (and the location of the file if it is not in the current directory) you want to recover. *Filename* is required and wildcards aren't supported. |
| /? | Displays help at the command prompt. |

### Examples

To recover the file *story.txt* in the *\fiction* directory on drive D, type:

```
recover d:\fiction\story.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
