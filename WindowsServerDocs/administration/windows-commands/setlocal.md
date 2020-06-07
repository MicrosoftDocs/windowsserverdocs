---
title: setlocal
description: Reference topic for setlocal, which starts localization of environment variables in a batch file.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: e4e4b6d3-3f1a-4851-a782-25ee2470e16e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 06/13/2020
---

# setlocal

Starts localization of environment variables in a batch file. Localization continues until a matching **endlocal** command is encountered or the end of the batch file is reached.


## Syntax

```
setlocal [enableextensions | disableextensions] [enabledelayedexpansion | disabledelayedexpansion]
```

## Arguments

| Argument | Description |
| -------- | ----------- |
| enableextensions | Enables the command extensions until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| disableextensions | Disables the command extensions until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| enabledelayedexpansion | Enables the delayed environment variable expansion until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| disabledelayedexpansion | Disables the delayed environment variable expansion until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| /?|Displays help at the command prompt. |

## Remarks

- Using **setlocal**

    When you use **setlocal** outside of a script or batch file, it has no effect.

- Changing environmental variables

    Use **setlocal** to change environment variables when you run a batch file. Environment changes made after you run **setlocal** are local to the batch file. The Cmd.exe program restores previous settings when it encounters an **endlocal** command or reaches the end of the batch file.

- Nesting commands

    You can have more than one **setlocal** or **endlocal** command in a batch program (that is, nested commands).

- Command Extensions

    Command Extensions is a mode of the [cmd](cmd.md) command interpreter that changes the behavior of variable expansion and of many internal commands (internal to cmd.exe). These changes are described in the documentation of each command. The cmd documentation page contains a list of affected commands. The [assoc](assoc.md), [color](color.md), and [ftype](ftype.md) commands are not available at all if Command Extensions are disabled.

- Testing for command extensions in batch files

    The **setlocal** command sets the ERRORLEVEL variable. If you pass {**enableextensions** | **disableextensions**} or {**enabledelayedexpansion** | **disabledelayedexpansion**}, the ERRORLEVEL variable is set to **0** (zero). Otherwise, it is set to **1**. You can use this information in batch scripts to determine whether the extensions are available, as shown in the following example:

    ```
    setlocal enableextensions
    verify other 2>nul
    if errorlevel 1 echo Unable to enable extensions
    ```

    Because **cmd** does not set the ERRORLEVEL variable when command extensions are disabled, the **verify** command initializes the ERRORLEVEL variable to a nonzero value when you use it with an invalid argument. Also, if you use the **setlocal** command with arguments {**enableextensions** | **disableextensions**} or {**enabledelayedexpansion** | **disabledelayedexpansion**} and it does not set the ERRORLEVEL variable to **1**, command extensions are not available.

## Examples

You can localize environment variables in a batch file, as shown in the following sample script:
```
rem *******Begin Comment**************
rem This program starts the superapp batch program on the network,
rem directs the output to a file, and displays the file
rem in Notepad.
rem *******End Comment**************
@echo off
setlocal
path=g:\programs\superapp;%path%
call superapp>c:\superapp.out
endlocal
start notepad c:\superapp.out
```

## Additional References

- [The command interpreter cmd.exe](cmd.md)
- [Command-Line Syntax Key](command-line-syntax-key.md)
