---
title: edit
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e0ff2e8-3518-47c1-8c69-5e93f895fa0e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# edit



Starts MS-DOS Editor, which creates and changes ASCII text files.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
edit [/b] [/h] [/r] [/s] [/<NNN>] [[<Drive>:][<Path>]<FileName> [<FileName2> [...]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:][<Path>]<FileName> [<FileName2> [...]]|Specifies the location and name of one or more ASCII text files. If the file does not exist, MS-DOS Editor creates it. If the file exists, MS-DOS Editor opens it and displays its contents on the screen. *FileName* can contain wildcard characters (**&#42;** and **?**). Separate multiple file names with spaces.|
|/b|Forces monochrome mode, so that MS-DOS Editor displays in black and white.|
|/h|Displays the maximum number of lines possible for the current monitor.|
|/r|Loads file(s) in read-only mode.|
|/s|Forces the use of short filenames.|
|\<NNN>|Loads binary file(s), wrapping lines to *NNN* characters wide.|
|/?|Displays help at the command prompt.|

## Remarks

-   For additional help, open MS-DOS Editor, and then press the F1 key.
-   Some monitors do not support the display of shortcut keys by default. If your monitor does not display shortcut keys, use **/b**.

## <a name="BKMK_examples"></a>Examples

To open MS-DOS Editor, type:
```
edit
```
To create and edit a file named newtextfile.txt in the current directory, type:
```
edit newtextfile.txt
```