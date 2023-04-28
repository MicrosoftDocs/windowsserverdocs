---
title: popd
description: Reference article for the pnputil command, which changes the current directory to the directory that was most recently stored by the pushd command.
ms.topic: reference
ms.assetid: 8a4c52d5-9fd1-4eac-9c0c-5767b25728ed
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# popd

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **popd** command changes the current directory to the directory that was most recently stored by the **pushd** command.

Every time you use the **pushd** command, a single directory is stored for your use. However, you can store multiple directories by using the **pushd** command multiple times. The directories are stored sequentially in a virtual stack, so if you use the **pushd** command once, the directory in which you use the command is placed at the bottom of the stack. If you use the command again, the second directory is placed on top of the first one. The process repeats every time you use the **pushd** command.

If you use the **popd** command, the directory on the top of the stack is removed and the current directory is changed to that directory. If you use the **popd** command again, the next directory on the stack is removed. If command extensions are enabled, the **popd** command removes any drive-letter assignments created by the **pushd** command.

## Syntax

```
popd
```

### Parameters

| Parameter | Description |
|--|--|
| /? | Displays help at the command prompt. |

### Examples

To change the current directory from the one in which the batch program was run, and then to change it back, type:

```
@echo off
rem This batch file deletes all .txt files in a specified directory
pushd %1
del *.txt
popd
cls
echo All text files deleted in the %1 directory
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [pushd](pushd.md)
