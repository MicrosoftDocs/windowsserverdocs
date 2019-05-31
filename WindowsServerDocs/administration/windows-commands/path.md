---
title: path
description: Learn how to set the PATH environment variable.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1bfa1349-e79a-472b-a9e6-d7a91149ae8f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# path



Sets the command path in the PATH environment variable (the set of directories used to search for executable files). If used without parameters, **path** displays the current command path.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
path [[<Drive>:]<Path>[;...][;%PATH%]]
path ;
```

## Parameters

|     Parameter     |                                                                                                     Description                                                                                                      |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [\<Drive>:]<Path> |                                                                            Specifies the drive and directory to set in the command path.                                                                             |
|         ;         | Separates directories in the command path. If used without other parameters, **;** clears the existing command paths from the PATH environment variable and directs Cmd.exe to search only in the current directory. |
|      %PATH%       |                                                         Appends the command path to the existing set of directories listed in the PATH environment variable.                                                         |
|        /?         |                                                                                         Displays help at the command prompt.                                                                                         |

## Remarks

-   When you include **%PATH%** in the syntax, Cmd.exe replaces it with the command path values found in the PATH environment variable, eliminating the need to manually enter these values at the command prompt.
-   The current directory is always searched before the directories specified in the command path.
-   You might have files in a directory that share the same file name but have different extensions. For example, you might have a file named Accnt.com that starts an accounting program and another file named Accnt.bat that connects your server to the accounting system network.

    The Windows operating system searches for a file by using default file name extensions in the following order of precedence: .exe, .com, .bat, and .cmd. To run Accnt.bat when Accnt.com exists in the same directory, you must include the .bat extension at the command prompt.
-   If two or more files in the command path have the same file name and extension, **path** first searches for the specified file name in the current directory. Then it searches the directories in the command path in the order that they are listed in the PATH environment variable.
-   If you place the **path** command in your Autoexec.nt file, the Windows operating system automatically appends the specified MS-DOS subsystem search path every time you log on to your computer. Cmd.exe does not use the Autoexec.nt file. When started from a shortcut, Cmd.exe inherits the environment variables set in My Computer/Properties/Advanced/Environment.

## <a name="BKMK_examples"></a>Examples

To search the paths C:\User\Taxes, B:\User\Invest, and B:\Bin for external commands, type:

`path c:\user\taxes;b:\user\invest;b:\bin`

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)