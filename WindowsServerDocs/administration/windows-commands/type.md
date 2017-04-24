---
title: type
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c44fe905-a865-4c97-8cc5-fb95fec7d4d5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# type

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the contents of a text file. Use the **type** command to view a text file without modifying it.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
type [<Drive>:][<path>]<FileName>
```
## Parameters
|Parameter|Description|
|-------|--------|
|[<Drive>:][<path>]<FileName>|Specifies the location and name of the file or files that you want to view. Separate multiple file names with spaces.|
|/?|Displays help at the command prompt.|
## remarks
-   if *FileName* contains spaces, enclose it in quotation marks (for example, "File Name Containing Spaces.txt").
-   if you display a binary file or a file that is created by a program, you may see strange characters on the screen, including formfeed characters and escape-sequence symbols. These characters represent control codes that are used in the binary file. In general, avoid using the **type** command to display binary files.
## <a name="BKMK_examples"></a>Examples
To display the contents of a file named Holiday.mar, type:
```
type holiday.mar 
```
To display the contents of a lengthy file named Holiday.mar one screen at a time, type:
```
type holiday.mar | more 
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
