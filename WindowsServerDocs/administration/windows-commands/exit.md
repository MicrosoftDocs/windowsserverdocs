---
title: exit
description: Reference article for exit, which exits the command interpreter.
ms.topic: reference
ms.assetid: d3cee4a2-6210-46f0-b8e4-7381c3c4e530
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# exit

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Exits the command interpreter or the current batch script.

## Syntax

```
exit [/b] [<exitcode>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /b | Exits the current batch script instead of exiting Cmd.exe. If executed from outside a batch script, exits Cmd.exe. |
| `<exitcode>` | Specifies a numeric number. If **/b** is specified, the ERRORLEVEL environment variable is set to that number. If you are quitting the command interpreter, the process exit code is set to that number. |
| /? | Displays help at the command prompt. |

## Examples

To close the command interpreter, type:

```
exit
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
