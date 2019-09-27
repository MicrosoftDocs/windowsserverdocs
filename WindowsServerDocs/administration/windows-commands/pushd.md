---
title: pushd
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 396bc545-0f41-473e-b0ac-76fbbb74d390
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# pushd



Stores the current directory for use by the **popd** command, and then changes to the specified directory.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
pushd [<Path>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Path>|Specifies the directory to make the current directory. This command supports relative paths.|
|/?|Displays help at the command prompt.|

## Remarks

-   Every time you use the **pushd** command, a single directory is stored for your use. However, you can store multiple directories by using the **pushd** command multiple times.

    The directories are stored sequentially in a virtual stack. If you use the **pushd** command once, the directory in which you use the command is placed at the bottom of the stack. If you use the command again, the second directory is placed on top of the first one. The process repeats every time you use the **pushd** command.

    You can use the **popd** command to change the current directory to the directory most recently stored by the **pushd** command. If you use the **popd** command, the directory on the top of the stack is removed from the stack and the current directory is changed to that directory. If you use the **popd** command again, the next directory on the stack is removed.
-   If command extensions are enabled, the **pushd** command accepts either a network path or a local drive letter and path.
-   If you specify a network path, the **pushd** command temporarily assigns the highest unused drive letter (starting with Z:) to the specified network resource. The command then changes the current drive and directory to the specified directory on the newly assigned drive. If you use the **popd** command with command extensions enabled, the **popd** command removes the drive-letter assignation created by **pushd**.

## <a name="BKMK_examples"></a>Examples

The following example shows how you can use the **pushd** command and the **popd** command in a batch program to change the current directory from the one in which the batch program was run and then change it back:
```
@echo off
rem This batch file deletes all .txt files in a specified directory
pushd %1
del *.txt
popd
cls
echo All text files deleted in the %1 directory
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Popd](popd.md)