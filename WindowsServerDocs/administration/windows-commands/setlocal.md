---
title: setlocal
description: Reference article for the setlocal command, which starts localization of environment variables in a batch file.
ms.topic: reference
ms.assetid: e4e4b6d3-3f1a-4851-a782-25ee2470e16e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 03/29/2021
---

# setlocal

Starts localization of environment variables in a batch file. Localization continues until a matching **endlocal** command is encountered or the end of the batch file is reached.

## Syntax

```
Setlocal [EnableExtensions | DisableExtensions] [EnableDelayedExpansion | DisableDelayedExpansion]
```

### Parameters

| Parameter | Description |
| :-------: | :---------- |
| EnableExtensions | Enables the command extensions until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| DisableExtensions | Disables the command extensions until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| EnableDelayedExpansion | Enables the delayed environment variable expansion until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| DisableDelayedExpansion | Disables the delayed environment variable expansion until the matching **endlocal** command is encountered, regardless of the setting before the **setlocal** command was run. |
| /? | Displays help at the command prompt. |

#### Remarks

- If you use **setlocal** outside of a script or batch file, it has no effect.

- Use **setlocal** to change environment variables when you run a batch file. Environment changes made after you run **setlocal** are local to the batch file. The cmd.exe command-line interpreter restores previous settings when it encounters an **endlocal** command, or reaches the end of the batch file.

- You can have more than one **setlocal** or **endlocal** command in a batch script (that is, nested commands).

- Command Extensions is a mode of the [cmd](cmd.md) command interpreter that changes the behavior of variable expansion and of many internal commands (internal to cmd.exe). These changes are described in the documentation of each command. The cmd documentation page contains a list of affected commands. The [assoc](assoc.md), [color](color.md), and [ftype](ftype.md) commands are not available at all if Command Extensions are disabled.

- The **setlocal** command sets the ERRORLEVEL variable. If you pass {**EnableExtensions** | **DisableExtensions**} or {**EnableDelayedExpansion** | **DisableDelayedExpansion**}, the ERRORLEVEL variable is set to **0** (zero). Otherwise, it's set to **1**. You can use this information in batch scripts to determine whether the extensions are available, as shown in the following example:

    ```
    Setlocal EnableExtensions
    Verify other 2>NUL
    if ErrorLevel 1 Echo Unable to enable extensions.
    ```

    Because **cmd** does not set the ERRORLEVEL variable when command extensions are disabled, the **Verify** command initializes the ERRORLEVEL variable to a nonzero value when you use it with an invalid argument. Also, if you use the **Setlocal** command with any of the arguments {**EnableExtensions** | **DisableExtensions**} or {**EnableDelayedExpansion** | **DisableDelayedExpansion**} and it does not set the ERRORLEVEL variable to **1**, command extensions are not available.

## Examples

To localize environment variables in a batch file, follow this sample script:

```
rem ******* Begin Comment **************
rem This program starts the SuperApp batch script on the network,
rem directs the output to a file, and displays the file
rem in Notepad.
rem ******* End Comment **************
@echo off
setlocal
path=g:\programs\SuperApp;%path%
call SuperApp>c:\SuperApp.out
endlocal
start Notepad c:\SuperApp.out
```

## Additional References

- [The command-line interpreter cmd.exe](cmd.md)
- [Command-Line Syntax Key](command-line-syntax-key.md)
