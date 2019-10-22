---
title: tree
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 345d3192-401e-4a3b-a8ac-36a85c7be79d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# tree



Displays the directory structure of a path or of the disk in a drive graphically.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
tree [<Drive>:][<Path>] [/f] [/a]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive>:|Specifies the drive that contains the disk for which you want to display the directory structure.|
|\<Path>|Specifies the directory for which you want to display the directory structure.|
|/f|Displays the names of the files in each directory.|
|/a|Specifies that **tree** is to use text characters instead of graphic characters to show the lines that link subdirectories.|
|/?|Displays help at the command prompt.|

## Remarks

The structure displayed by **tree** depends upon the parameters that you specify at the command prompt. If you do not specify a drive or path, **tree** displays the tree structure beginning with the current directory of the current drive.

## <a name="BKMK_examples"></a>Examples

To display the names of all the subdirectories on the disk in your current drive, type:
```
tree \
```
To display, one screen at a time, the files in all the directories on drive C, type:
```
tree c:\ /f | more 
```
To print a list of all the directories on drive C, type:
```
tree c:\ /f  prn 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)