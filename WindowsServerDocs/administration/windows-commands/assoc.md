---
title: assoc
description: "Windows Commands topic for **assoc** - Displays or modifies file name extension associations."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 237bedda-b24c-4fec-a39c-9b7eacf96417
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# assoc



Displays or modifies file name extension associations. If used without parameters, **assoc** displays a list of all the current file name extension associations.

> [!NOTE]
> This command is only supported within CMD.EXE and is not available from PowerShell.
>

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
assoc [<.ext>[=[<FileType>]]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|<.ext>|Specifies the file name extension.|
|\<FileType>|Specifies the file type to associate with the specified file name extension.|
|/?|Displays help at the command prompt.|

## Remarks

-   To remove the file type association for a file name extension, add a white space after the equal sign by pressing the SPACEBAR.
-   To view current file types that have open command strings defined, use the **ftype** command.
-   To redirect the output of **assoc** to a text file, use the **>** redirection operator.

## <a name="BKMK_examples"></a>Examples

To view the current file type association for the file name extension .txt, type:
```
assoc .txt
```
To remove the file type association for the file name extension .bak, type:
```
assoc .bak= 
```

> [!NOTE]
> Be sure to add a space after the equal sign.

To view the output of **assoc** one screen at a time, type:
```
assoc | more
```
To send the output of **assoc** to the file assoc.txt, type:
```
assoc>assoc.txt
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
