---
title: compact
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 429b3752-df0a-43a4-a210-df2f3ad03c3b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# compact



Displays or alters the compression of files or directories on NTFS partitions. If used without parameters, **compact** displays the compression state of the current directory and the files it contains.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
compact [/c | /u] [/s[:<Dir>]] [/a] [/i] [/f] [/q] [<FileName>[...]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/c|Compresses the specified directory or file.|
|/u|Uncompresses the specified directory or file.|
|/s[:\<Dir>]|Applies the **compact** command to all subdirectories of the specified directory (or of the current directory if none is specified).|
|/a|Displays hidden or system files.|
|/i|Ignores errors.|
|/f|Forces compression or uncompression of the specified directory or file. **/f** is used in the case of a file that was partly compressed when the operation was interrupted by a system crash. To force the file to be compressed in its entirety, use the **/c** and **/f** parameters and specify the partially compressed file.|
|/q|Reports only the most essential information.|
|\<FileName>|Specifies the file or directory. You can use multiple file names, and the **&#42;** and **?** wildcard characters.|
|/?|Displays help at the command prompt.|

## Remarks

-   The **compact** command is the command-line version of the NTFS file system compression feature. The compression state of a directory indicates whether files are automatically compressed when they are added to the directory. Setting the compression state of a directory does not necessarily change the compression state of files that are already in the directory.
-   You cannot use **compact** to read, write, or mount volumes that have been compressed using DriveSpace or DoubleSpace.
-   You cannot use **compact** to compress file allocation table (FAT) or FAT32 partitions.

## <a name="BKMK_examples"></a>Examples

To set the compression state of the current directory, its subdirectories, and existing files, type:
```
compact /c /s 
```
To set the compression state of files and subdirectories within the current directory, without altering the compression state of the current directory itself, type:
```
compact /c /s *.*
```
To compress a volume, from the root directory of the volume, type:
```
compact /c /i /s:\
```

> [!NOTE]
> This example sets the compression state of all directories (including the root directory on the volume) and compresses every file on the volume. The **/i** parameter prevents error messages from interrupting the compression process.

To compress all files with the .bmp file name extension in the \Tmp directory and all subdirectories of \Tmp, without modifying the compressed attribute of the directories, type:
```
compact /c /s:\tmp *.bmp
```
To force complete compression of the file Zebra.bmp, which was partially compressed during a system crash, type:
```
compact /c /f zebra.bmp
```
To remove the compressed attribute from the directory C:\Tmp, without changing the compression state of any files in that directory, type:
```
compact /u c:\tmp
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)