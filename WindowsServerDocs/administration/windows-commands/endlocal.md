---
title: endlocal
description: Reference article for the endlocal command, which ends localization of environment changes in a batch file, and restores environment variables to their values before the corresponding setlocal command was run.
ms.topic: reference
ms.assetid: 765fae3c-0c0a-4639-99a4-cf613489b949
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# endlocal

Ends localization of environment changes in a batch file, and restores environment variables to their values before the corresponding **setlocal** command was run.

## Syntax

```
endlocal
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /? | Displays help at the command prompt. |

#### Remarks

- The **endlocal** command has no effect outside a script or batch file.

- There is an implicit **endlocal** command at the end of a batch file.

- If command extensions are enabled (command extensions are enabled by default), the **endlocal** command restores the state of command extensions (that is, enabled or disabled) to what it was before the corresponding **setlocal** command was run.

> [!NOTE]
> For more information about enabling and disabling command extensions, see the [Cmd command](cmd.md).

### Examples

You can localize environment variables in a batch file. For example, the following program starts the *superapp* batch program on the network, directs the output to a file, and displays the file in Notepad:

```
@echo off
setlocal
path=g:\programs\superapp;%path%
call superapp>c:\superapp.out
endlocal
start notepad c:\superapp.out
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
