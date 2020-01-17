---
title: Md
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82162d00-cc34-4776-9e55-4b4836dbd6a9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Md



Creates a directory or subdirectory.

> [!NOTE]
> This command is the same as the **mkdir** command.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
md [<Drive>:]<Path>
mkdir [<Drive>:]<Path>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive>:|Specifies the drive on which you want to create the new directory.|
|\<Path>|Required. Specifies the name and location of the new directory. The maximum length of any single path is determined by the file system.|
|/?|Displays help at the command prompt.|

## Remarks

Command extensions, which are enabled by default, allow you to use a single **md** command to create intermediate directories in a specified path.

## <a name="BKMK_examples"></a>Examples

To create a directory named Directory1 within the current directory, type:
```
md Directory1
```
To create the directory tree Taxes\Property\Current within the root directory, with command extensions enabled, type:
```
md \Taxes\Property\Current
```
To create the directory tree Taxes\Property\Current within the root directory as in the previous example, but with command extensions disabled, type the following sequence of commands:
```
md \Taxes
md \Taxes\Property
md \Taxes\Property\Current
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Cmd](cmd.md)