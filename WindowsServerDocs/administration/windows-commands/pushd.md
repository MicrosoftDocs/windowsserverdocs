---
title: pushd
description: Reference article for the pushd command, which stores the current directory for use by the popd command, and then changes to the specified directory.
ms.topic: reference
ms.assetid: 396bc545-0f41-473e-b0ac-76fbbb74d390
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# pushd

Stores the current directory for use by the **popd** command, and then changes to the specified directory.

Every time you use the **pushd** command, a single directory is stored for your use. However, you can store multiple directories by using the **pushd** command multiple times. The directories are stored sequentially in a virtual stack, so if you use the **pushd** command once, the directory in which you use the command is placed at the bottom of the stack. If you use the command again, the second directory is placed on top of the first one. The process repeats every time you use the **pushd** command.

If you use the **popd** command, the directory on the top of the stack is removed and the current directory is changed to that directory. If you use the **popd** command again, the next directory on the stack is removed. If command extensions are enabled, the **popd** command removes any drive-letter assignment created by the **pushd** command.

## Syntax

```
pushd [<path>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<path>` | Specifies the directory to make the current directory. This command supports relative paths. |
| /? | Displays help at the command prompt. |

#### Remarks

- If command extensions are enabled, the **pushd** command accepts either a network path or a local drive letter and path.

- If you specify a network path, the **pushd** command temporarily assigns the highest unused drive letter (starting with Z:) to the specified network resource. The command then changes the current drive and directory to the specified directory on the newly assigned drive. If you use the **popd** command with command extensions enabled, the **popd** command removes the drive-letter assignment created by **pushd**.

### Examples

To change the current directory from the one in which the batch program was run, and then to change it back:

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

- [popd command](popd.md)
