---
title: start
description: Reference article for start, which starts a separate Command Prompt window to run a specified program or command.
ms.topic: reference
ms.assetid: 0173f9b3-5cd7-4edb-b01e-d02193b4fadc
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# start

Starts a separate Command Prompt window to run a specified program or command.

## Syntax

```
start [<title>] [/d <path>] [/i] [{/min | /max}] [{/separate | /shared}] [{/low | /normal | /high | /realtime | /abovenormal | belownormal}] [/affinity <hexaffinity>] [/wait] [/elevate] [/b] [<command> [<parameter>... ] | <program> [<parameter>... ]]
```

### Parameters

| Parameter | Description |
|--|--|
| `<title>` | Specifies the title to display in the **Command Prompt** window title bar. |
| /d `<path>` | Specifies the startup directory. |
| /i | Passes the Cmd.exe startup environment to the new **Command Prompt** window. If **/i** is not specified, the current environment is used. |
| `{/min | /max}` | Specifies to minimize (**/min**) or maximize (**/max**) the new **Command Prompt** window. |
| `{/separate | /shared}` | Starts 16-bit programs in a separate memory space (**/separate**) or shared memory space (**/shared**). These options are not supported on 64-bit platforms. |
| `{/low | /normal | /high | /realtime | /abovenormal | belownormal}` | Starts an application in the specified priority class. |
| /affinity `<hexaffinity>` | Applies the specified processor affinity mask (expressed as a hexadecimal number) to the new application. |
| /wait | Starts an application and waits for it to end. |
| /elevate | Runs application as administrator. |
| /b | Starts an application without opening a new **Command Prompt** window. CTRL+C handling is ignored unless the application enables CTRL+C processing. Use CTRL+BREAK to interrupt the application. |
| `[<command> [<parameter>... ] | <program> [<parameter>... ]]` | Specifies the command or program to start. |
| `<parameter>` | Specifies parameters to pass to either the command or the program. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can run non-executable files through their file association by typing the name of the file as a command.

- If you run a command that contains the string CMD as the first token without an extension or path qualifier, CMD is replaced with the value of the COMSPEC variable. This prevents users from picking up **cmd** from the current directory.

- If you run a 32-bit graphical user interface (GUI) application, **cmd** does not wait for the application to quit before returning to the command prompt. This behavior does not occur if you run the application from a command script.

- If you run a command that uses a first token that does not contain an extension, Cmd.exe uses the value of the PATHEXT environment variable to determine which extensions to look for and in what order. The default value for the PATHEXT variable is:

  ```
  .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
  ```

  Note that the syntax is the same as the PATH variable, with semicolons (;) separating each extension.

- When searching for an executable file, if there is no match on any extension, **start** checks to see if the name matches a directory name. If it does, **start** opens Explorer.exe on that path.

## Examples

To start the *Myapp* program at the command prompt and retain use of the current **Command Prompt** window, type:

```
start Myapp
```

To view the **start** command-line help topic in a separate maximized **Command Prompt** window, type:

```
start /max start /?
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
