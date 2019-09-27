---
title: popd
description: Learn how to change the directory to the directory most recently stored by the pushd command.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8a4c52d5-9fd1-4eac-9c0c-5767b25728ed
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---

# popd

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the current directory to the directory that was most recently stored by the **pushd** command.
for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax
```
popd
```

### Parameters
|Parameter|Description|
|-------|--------|
|/?|Displays help at the command prompt.|

## Remarks
-   Every time you use the **pushd** command, a single directory is stored for your use. However, you can store multiple directories by using the **pushd** command multiple times.
    The directories are stored sequentially in a virtual stack. If you use the **pushd** command once, the directory in which you use the command is placed at the bottom of the stack. If you use the command again, the second directory is placed on top of the first one. The process repeats every time you use the **pushd** command.
    You can use the **popd** command to change the current directory to the directory most recently stored by the **pushd** command. If you use the **popd** command, the directory on the top of the stack is removed from the stack and the current directory is changed to that directory. If you use the **popd** command again, the next directory on the stack is removed.
-   When command extensions are enabled, the **popd** command removes any drive-letter assignations created by **pushd**.

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

## additional references
-   [pushd](pushd.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)

