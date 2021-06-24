---
title: cmd
description: Reference article for the cmd command, which starts a new instance of the command interpreter, Cmd.exe.
ms.topic: reference
ms.assetid: 6ec588db-31a9-4a73-a970-65a2c6f4abbe
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# cmd

Starts a new instance of the command interpreter, Cmd.exe. If used without parameters, **cmd** displays the version and copyright information of the operating system.

## Syntax

```
cmd [/c|/k] [/s] [/q] [/d] [/a|/u] [/t:{<b><f> | <f>}] [/e:{on | off}] [/f:{on | off}] [/v:{on | off}] [<string>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /c | Carries out the command specified by *string* and then stops. |
| /k | Carries out the command specified by *string* and continues. |
| /s | Modifies the treatment of *string* after **/c** or **/k**. |
| /q | Turns the echo off. |
| /d | Disables execution of AutoRun commands. |
| /a | Formats internal command output to a pipe or a file as American National Standards Institute (ANSI). |
| /u | Formats internal command output to a pipe or a file as Unicode. |
| /t:{`<b><f>` \| `<f>`} | Sets the background (*b*) and foreground (*f*) colors. |
| /e:on | Enables command extensions. |
| /e:off | Disables commands extensions. |
| /f:on | Enables file and directory name completion. |
| /f:off | Disables file and directory name completion. |
| /v:on | Enables delayed environment variable expansion. |
| /v:off | Disables delayed environment variable expansion. |
| `<string>` | Specifies the command you want to carry out. |
| /? | Displays help at the command prompt. |

The following table lists valid hexadecimal digits that you can use as the values for `<b>` and `<f>`:

| Value | Color |
| ----- | ----- |
| 0 | Black |
| 1 | Blue |
| 2 | Green |
| 3 | Aqua |
| 4 | Red |
| 5 | Purple |
| 6 | Yellow |
| 7 | White |
| 8 | Gray |
| 9 | Light blue |
| a | Light green |
| b | Light aqua |
| c | Light red |
| d | Light purple |
| e | Light yellow |
| f | Bright white |

## Remarks

- To use multiple commands for `<string>`, separate them by the command separator **&&** and enclose them in quotation marks. For example:

    ```
    "<command1>&&<command2>&&<command3>"
    ```

- If you specify **/c** or **/k**, **cmd** processes, the remainder of *string*, and the quotation marks are preserved only if all of the following conditions are met:

    - You don't also use **/s**.

    - You use exactly one set of quotation marks.

    - You don't use any special characters within the quotation marks (for example: & < > ( ) @ ^ | ).

    - You use one or more white-space characters within the quotation marks.

    - The *string* within quotation marks is the name of an executable file.

    If the previous conditions aren't met, *string* is processed by examining the first character to verify whether it is an opening quotation mark. If the first character is an opening quotation mark, it is stripped along with the closing quotation mark. Any text following the closing quotation marks is preserved.

- If you don't specify **/d** in *string*, Cmd.exe looks for the following registry subkeys:

    - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun\REG_SZ**

    - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun\REG_EXPAND_SZ**

    If one or both registry subkeys are present, they're executed before all other variables.

    > [!CAUTION]
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

- You can disable command extensions for a particular process by using **/e:off**. You can enable or disable extensions for all **cmd** command-line options on a computer or user session by setting the following **REG_DWORD** values:

    - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\EnableExtensions\REG_DWORD**

    - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\EnableExtensions\REG_DWORD**

    Set the **REG_DWORD** value to either **0×1** (enabled) or **0×0** (disabled) in the registry by using Regedit.exe. User-specified settings take precedence over computer settings, and command-line options take precedence over registry settings.

    > [!CAUTION]
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

    When you enable command extensions, the following commands are affected:
    - **assoc**

    - **call**

    - **chdir (cd)**

    - **color**

    - **del (erase)**

    - **endlocal**

    - **for**

    - **ftype**

    - **goto**

    - **if**

    - **mkdir (md)**

    - **popd**

    - **prompt**

    - **pushd**

    - **set**

    - **setlocal**

    - **shift**

    - **start** (also includes changes to external command processes)

- If you enable delayed environment variable expansion, you can use the exclamation point character to substitute the value of an environment variable at run time.

- File and directory name completion is not enabled by default. You can enable or disable file name completion for a particular process of the **cmd** command with **/f:**{**on** | **off**}. You can enable or disable file and directory name completion for all processes of the **cmd** command on a computer or for a user logon session by setting the following **REG_DWORD** values:

    - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\CompletionChar\REG_DWORD**

    - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\PathCompletionChar\REG_DWORD**

    - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\CompletionChar\REG_DWORD**

    - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\PathCompletionChar\REG_DWORD**

    To set the **REG_DWORD** value, run Regedit.exe and use the hexadecimal value of a control character for a particular function (for example, **0×9** is TAB and **0×08** is BACKSPACE). User-specified settings take precedence over computer settings, and command-line options take precedence over registry settings.

    > [!CAUTION]
    > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

- If you enable file and directory name completion by using **/f:on**, use **CTRL+D** for directory name completion and **CTRL+F** for file name completion. To disable a particular completion character in the registry, use the value for white space [**0×20**] because it is not a valid control character.

  - Pressing **CTRL+D** or **CTRL+F**, processes the file and directory name completion. These key combination functions append a wildcard character to *string* (if one is not present), builds a list of paths that match, and then displays the first matching path.<p>If none of the paths match, the file and directory name completion function beeps and does not change the display. To move through the list of matching paths, press **CTRL+D** or **CTRL+F** repeatedly. To move through the list backwards, press the **SHIFT** key and **CTRL+D** or **CTRL+F** simultaneously. To discard the saved list of matching paths and generate a new list, edit *string* and press **CTRL+D** or **CTRL+F**. If you switch between **CTRL+D** and **CTRL+F**, the saved list of matching paths is discarded and a new list is generated. The only difference between the key combinations **CTRL+D** and **CTRL+F** is that **CTRL+D** only matches directory names and **CTRL+F** matches both file and directory names. If you use file and directory name completion on any of the built-in directory commands (that is, **CD**, **MD**, or **RD**), directory completion is assumed.

  - File and directory name completion correctly processes file names that contain white space or special characters if you place quotation marks around the matching path.

  - You must use quotation marks around the following special characters: & < > [ ] | { } ^ = ; ! ' + , ` ~ [white space].

  - If the information that you supply contains spaces, you must use quotation marks around the text (for example, "Computer Name").

  - If you process file and directory name completion from within *string*, any part of the *path* to the right of the cursor is discarded (at the point in *string* where the completion was processed).

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
