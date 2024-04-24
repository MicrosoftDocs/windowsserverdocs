---
title: title
description: Reference article for the title command, which creates a title for the Command Prompt window.
ms.topic: reference
ms.assetid: c0bbe8bd-201a-4b6c-b617-5d9809881dc8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# title

Creates a title for the Command Prompt window.

## Syntax

```
title [<string>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<string>` | Specifies the text to appear as the title of the Command Prompt window. |
| /? | Displays help at the command prompt. |

#### Remarks

- To create window title for batch programs, include the **title** command at the beginning of a batch program.

- After a window title is set, you can reset it only by using the **title** command.

## Examples

To change the Command Prompt window title to *Updating Files* while the batch file executes the **copy** command, and then to return the title back to *Command Prompt*, type the following script:

```
@echo off
title Updating Files
copy \\server\share\*.xls c:\users\common\*.xls
echo Files Updated.
title Command Prompt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
