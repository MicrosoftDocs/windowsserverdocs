---
title: start
description: Reference article for the start command, which starts a separate Command Prompt window to run a specified program or command.
ms.topic: reference
ms.assetid: 0173f9b3-5cd7-4edb-b01e-d02193b4fadc
ms.author: wscontent
author: xelu86
ms.date: 10/02/2023
---

# start

Starts a separate Command Prompt window to run a specified program or command.

## Syntax

```
start <"title"> [/d <path>] [/i] [{/min | /max}] [{/separate | /shared}] [{/low | /normal | /high | /realtime | /abovenormal | /belownormal}] [/node <NUMA node>] [/affinity <hexaffinity>] [/wait] [/b] [/machine <x86|amd64|arm|arm64>] [<command> [<parameter>... ] | <program> [<parameter>... ]]
```

> [!NOTE]
> The **machine** parameter is currently in PREVIEW for Windows 11 only. The parameter is available
> beginning with the [Windows 11 Insider Preview Build 22557](https://blogs.windows.com/windows-insider/2022/02/16/announcing-windows-11-insider-preview-build-22557/).
> This information relates to a prerelease product that may be substantially modified before it's
> released. Microsoft makes no warranties, expressed or implied, with respect to the information
> provided here.

### Parameters

| Parameter | Description |
|--|--|
| `"title"` | Specifies the title to display in the **Command Prompt** window title bar. |
| /d `<path>` | Specifies the startup directory. |
| /i | Passes the Cmd.exe startup environment to the new **Command Prompt** window. If `/i` isn't specified, the current environment is used. |
| `{/min | /max}` | Specifies to minimize (`/min`) or maximize (`/max`) the new **Command Prompt** window. |
| `{/separate | /shared}` | Starts 16-bit programs in a separate memory space (`/separate`) or shared memory space (**/shared**). These options aren't supported on 64-bit platforms. |
| `{/low | /normal | /high | /realtime | /abovenormal | /belownormal}` | Starts an application in the specified priority class. |
| /node `<NUMA node>` | Leverages memory locality on NUMA (Non-Uniform Memory Architecture) nodes as a decimal integer. Two processes that communicate with each other through shared memory on the preferred NUMA node can minimize memory latencies while allocating memory from the same NUMA node when possible. They're free to run on processors outside the specified node.|
| /affinity `<hexaffinity>` | Applies the specified processor affinity mask (expressed as a hexadecimal number) to the new application. Two programs are able to run on specific processor cores within the same NUMA node. This number can be changed to the processor-specific supported amount without having to change the affinity mask.|
| /wait | Starts an application and waits for it to end. |
| /b | Starts an application without opening a new **Command Prompt** window. CTRL+C handling is ignored unless the application enables CTRL+C processing. Use CTRL+BREAK to interrupt the application. |
| /machine `<x86 | amd64 | arm | arm64>` | Specifies the machine architecture of the application process. |
| `[<command> [<parameter>... ] | <program> [<parameter>... ]]` | Specifies the command or program to start. |
| `<parameter>` | Specifies parameters to pass to either the command or the program. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can run non-executable files through their file association by typing the name of the file as a command.

- If you run a command that contains the string CMD as the first token without an extension or path qualifier, CMD is replaced with the value of the COMSPEC variable. This prevents users from picking up `cmd` from the current directory.

- If you run a 32-bit graphical user interface (GUI) application, `cmd` doesn't wait for the application to quit before returning to the command prompt. This behavior doesn't occur if you run the application from a command script.

- If you're running on a 64-bit platform, the `/separate` and `/shared` parameters aren't supported.

- If you run a command that uses a first token that isn't a command or the file path to an existing file with an extension, `Cmd.exe` uses the value of the PATHEXT environment variable to determine which extensions to look for and in what order. The default value for the PATHEXT variable is `.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC`

    Note the syntax is the same as the PATH variable, with semicolons (;) separating each extension.

- **start** searches for a specified executable file, and if found, the executable launches regardless of the current working directory. When searching for an executable file, if there's no match on any extension, **start** checks to see if the name matches a directory name. If it does, **start** opens `Explorer.exe` on that path.

## Examples

To start the *Myapp* program at the command prompt and retain use of the current **Command Prompt** window, type:

```cmd
start Myapp
```

To view the **start** command-line help information in a separate maximized **Command Prompt** window, type:

```cmd
start /max start /?
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
