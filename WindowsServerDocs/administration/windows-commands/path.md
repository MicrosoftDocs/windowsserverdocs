---
title: path
description: Reference article for setting the command path in the PATH environment variable, specifying the set of directories used to search for executable (.exe) files.
ms.topic: reference
ms.assetid: 1bfa1349-e79a-472b-a9e6-d7a91149ae8f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# path

Sets the command path in the PATH environment variable, specifying the set of directories used to search for executable (.exe) files. If used without parameters, this command displays the current command path.

## Syntax

```
path [[<drive>:]<path>[;...][;%PATH%]]
path ;
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:]<path>` | Specifies the drive and directory to set in the command path. The current directory is always searched before the directories specified in the command path. |
| ; | Separates directories in the command path. If used without other parameters, **;** clears the existing command paths from the PATH environment variable and directs Cmd.exe to search only in the current directory. |
| `%PATH%` | Appends the command path to the existing set of directories listed in the PATH environment variable. If you include this parameter, Cmd.exe replaces it with the command path values found in the PATH environment variable, eliminating the need to manually enter these values at the command prompt. |
| /? | Displays help at the command prompt. |

## Remarks


- The Windows operating system searches using default file name extensions in the following order of precedence: .exe, .com, .bat, and .cmd. Which means if you're looking for a batch file named, acct.bat, but have an app named acct.exe in the same directory, you must include the .bat extension at the command prompt.

- If two or more files in the command path have the same file name and extension, this command first searches for the specified file name in the current directory. Then, it searches the directories in the command path in the order that they're listed in the PATH environment variable.

- If you place the **path** command in your Autoexec.nt file, the Windows operating system automatically appends the specified MS-DOS subsystem search path every time you log on to your computer. Cmd.exe does not use the Autoexec.nt file. When started from a shortcut, Cmd.exe inherits the environment variables set in My Computer/Properties/Advanced/Environment.

## Examples

To search the paths *c:\user\taxes*, *b:\user\invest*, and *b:\bin* for external commands, type:

```
path c:\user\taxes;b:\user\invest;b:\bin
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
