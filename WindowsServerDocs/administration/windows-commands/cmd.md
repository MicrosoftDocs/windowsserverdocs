---
title: cmd
description: Reference article for the cmd command, which starts a new instance of the command interpreter, Cmd.exe.
ms.topic: reference
ms.assetid: 6ec588db-31a9-4a73-a970-65a2c6f4abbe
ms.author: wscontent
author: xelu86
ms.date: 09/12/2023
---

# cmd

Starts a new instance of the command interpreter, Cmd.exe. If used without parameters, **cmd** displays the version and copyright information of the operating system.

> [!NOTE]
> Users seeking more advanced capabilities are encouraged to explore [PowerShell](/powershell/) for enhanced scripting and automation.

## Syntax

```
cmd [/c|/k] [/s] [/q] [/d] [/a|/u] [/t:{<b><f> | <f>}] [/e:{on | off}] [/f:{on | off}] [/v:{on | off}] [<string>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /c | Carries out the command specified by `<string>` and then exits the command processor. |
| /k | Carries out the command specified by `<string>` and keeps the command processor running. |
| /s | When used with `/c` or `/k`, triggers special non-parsing rules that strip the first and last quotes (`"`) around the `<string>` but leaves the rest of the command unchanged. |
| /q | Turns echo off. |
| /d | Disables execution of AutoRun commands. |
| /a | Formats command output as American National Standards Institute (ANSI). |
| /u | Formats command output as Unicode. |
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

- To redirect command output to the input of another command, use the pipe (`|`) character. For example:

  ```
  <command1> | <command2>
  ```
  
- To redirect command output to a file, use the greater-than angle bracket `>` character. For example:

  ```
  <command1> > <file1.txt>
  ```
  
- To use multiple commands for `<string>`, separate them by the command separator `&&`. For example:

  ```
  <command1>&&<command2>&&<command3>
  ```

- If the directory path, files, or any information you supply contains spaces, you must use double quotation marks (`"`) around the text, such as `"Computer Name"`. For example:

  ```
  mkdir Test&&mkdir "Test 2"&&move "Test 2" Test
  ```
  
- You must use quotation marks around the following special characters: & < > [ ] | { } ^ = ; ! ' + , ` ~ [white space].

- If you specify `/c` or `/k`, the `cmd` processes, the remainder of `<string>`, and the quotation marks are preserved only if all of the following conditions are met:

  - You don't also use `/s`.
  - You use exactly one set of quotation marks.
  - You don't use any special characters within the quotation marks (for example: & < > ( ) @ ^ | ).
  - You use one or more white-space characters within the quotation marks.
  - The `<string>` within quotation marks is the name of an executable file.
  
  If the previous conditions aren't met, `<string>` is processed by examining the first character to verify whether it's an opening quotation mark. If the first character is an opening quotation mark, it's stripped along with the closing quotation mark. Any text following the closing quotation marks is preserved.

- If you don't specify `/d`, Cmd.exe looks for the following registry subkeys:

  - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\AutoRun\REG_SZ**

  - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun\REG_EXPAND_SZ**

  If one or both registry subkeys are present, they're executed before all other variables.

  > [!CAUTION]
  > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

- You can disable command extensions for a particular process by using `/e:off`. You can enable or disable extensions for all `cmd` command-line options on a computer or user session by setting the following **REG_DWORD** values:

  - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\EnableExtensions\REG_DWORD**

  - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\EnableExtensions\REG_DWORD**

  Set the **REG_DWORD** value to either **0×1** (enabled) or **0×0** (disabled) in the registry by using Regedit.exe. User-specified settings take precedence over computer settings, and command-line options take precedence over registry settings.

  > [!CAUTION]
  > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

- When you enable command extensions, the following commands are affected:

  - `assoc`
  - `call`
  - `chdir` (`cd`)
  - `color`
  - `del` (`erase`)
  - `endlocal`
  - `for`
  - `ftype`
  - `goto`
  - `if`
  - `mkdir` (`md`)
  - `popd`
  - `prompt`
  - `pushd`
  - `set`
  - `setlocal`
  - `shift`
  - `start` (also includes changes to external command processes)

- If you enable delayed environment variable expansion, you can use the exclamation point character (`!`) to substitute the value of an environment variable at run time.

- File and directory name completion isn't enabled by default. You can enable or disable file name completion for a particular process of the `cmd` command with `/f:{on | off}`.

- You can enable or disable file and directory name completion for all processes of the `cmd` command on a computer or for a user logon session by setting the following **REG_DWORD** values:

  - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\CompletionChar\REG_DWORD**

  - **HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\PathCompletionChar\REG_DWORD**

  - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\CompletionChar\REG_DWORD**

  - **HKEY_CURRENT_USER\Software\Microsoft\Command Processor\PathCompletionChar\REG_DWORD**

  To set the **REG_DWORD** value, run Regedit.exe and use the hexadecimal value of a control character for a particular function (for example, **0×9** is TAB and **0×08** is BACKSPACE). Use the [**0×20**] value for white space, because it isn't a valid control character. User-specified settings take precedence over computer settings, and command-line options take precedence over registry settings.

  > [!CAUTION]
  > Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

- If you enable file and directory name completion by using `/f:on`, use **CTRL+D** for directory name completion and **CTRL+F** for file name completion. The only difference between the key combinations **CTRL+D** and **CTRL+F** is that **CTRL+D** only matches directory names and **CTRL+F** matches both file and directory names. If you use file and directory name completion on the built-in directory commands `cd`, `md`, or `rd`, directory completion is assumed.

- Pressing **CTRL+D** or **CTRL+F** processes the file and directory name completion. These key combination functions append a wildcard character to `<string>` if one isn't present, build a list of paths that match, and then display the first matching path. If none of the paths match, the file and directory name completion function beeps and doesn't change the display.

  - To move through the list of matching paths, press **CTRL+D** or **CTRL+F** repeatedly.
  - To move through the list backwards, press the **SHIFT** key and **CTRL+D** or **CTRL+F** simultaneously.
  - To discard the saved list of matching paths and generate a new list, edit `<string>` and press **CTRL+D** or **CTRL+F**.
  - If you switch between **CTRL+D** and **CTRL+F**, the saved list of matching paths is discarded, and a new list is generated. 

- File and directory name completion correctly processes file names that contain white space or special characters if you place quotation marks around the matching path.

- If you process file and directory name completion from within `<string>`, at the point in `<string>` where the completion was processed, any part of the *path* to the right of the cursor is discarded.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
