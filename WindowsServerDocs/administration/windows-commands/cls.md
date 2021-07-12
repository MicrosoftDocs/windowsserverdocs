---
title: cls
description: Reference article for the cls command, which clears the Command Prompt window.
ms.topic: reference
ms.assetid: ce9bf55c-bed4-47fb-8f79-a134202c4ed3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# CLS

Clears the Command Prompt window. CLS is an internal for CMD.EXE command.

## Syntax

```
cls
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /? | Displays help at the command prompt. |

### Exit codes

| Exit code | Description |
| --------- | ----------- |
| - | On success the command will not change the errorlevel. |
| 1 | Bad command line switch passed (anything different than `/?`). |

## Examples

- To clear all information that appears in the Command Prompt window and return to a blank window, type:

```
cls
```
- When the output of the command is captured (redirected to a file or with FOR /F command) it will print a line feed character (ASCII 10):

```
rem -- this will print line feed charater in the console --
cls>con

rem -- this will assign line feed character to a variable --
for /f "tokens=* delims=" %# in ('cls') do @set "LF=%#"
echo %LF%
```

## Additional References

- [CMD](cmd.md)
- [Command-Line Syntax Key](command-line-syntax-key.md)
