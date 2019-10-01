---
title: comp
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40319d23-704d-4da1-be93-8259547275d0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# comp



Compares the contents of two files or sets of files byte-by-byte. If used without parameters, **comp** prompts you to enter the files to compare.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
comp [<Data1>] [<Data2>] [/d] [/a] [/l] [/n=<Number>] [/c]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Data1>|Specifies the location and name of the first file or set of files that you want to compare. You can use wildcard characters (**&#42;** and **?**) to specify multiple files.|
|\<Data2>|Specifies the location and name of the second file or set of files that you want to compare. You can use wildcard characters (**&#42;** and **?**) to specify multiple files.|
|/d|Displays differences in decimal format. (The default format is hexadecimal.)|
|/a|Displays differences as characters.|
|/l|Displays the number of the line where a difference occurs, instead of displaying the byte offset.|
|/n=\<Number>|Compares only the number of lines that are specified for each file, even if the files are different sizes.|
|/c|Performs a comparison that is not case-sensitive.|
|/off[line]|Processes files with the offline attribute set.|
|/?|Displays Help at the command prompt.|

## Remarks

-   How the **comp** command identifies mismatching information

    During the comparison, **comp** displays messages that identify the locations of unequal information between the files. Each message indicates the offset memory address of the unequal bytes and the contents of the bytes (in hexadecimal notation unless the **/a** or **/d** command-line parameter is specified). Messages appear in the following format:

    `Compare error at OFFSET xxxxxxxx`

    `file1 = xx`

    `file2 = xx`

    After ten unequal comparisons, **comp** stops comparing the files and displays the following message:

    `10 Mismatches - ending compare`
-   Handling special cases for *Data1* and *Data2*  
    -   If you omit necessary components of either *Data1* or *Data2* or if you omit *Data2*, **comp** prompts you for the missing information.
    -   If *Data1* contains only a drive letter or a directory name with no file name, **comp** compares all of the files in the specified directory to the file specified in *Data1*.
    -   If *Data2* contains only a drive letter or a directory name, the default file name for *Data2* is the same as that in *Data1*.
    -   If **comp** cannot find the file(s) you specify, it prompts you with a message to determine whether you want to compare more files.
-   Comparing files in different locations

    **Comp** can compare files on the same drive or on different drives, and in the same directory or in different directories. When **comp** compares the files, it displays their locations and file names.
-   Comparing files with the same names

    The files that you compare can have the same file name, provided they are in different directories or on different drives. If you do not specify a file name for *Data2*, the default file name for *Data2* is the same as the file name in *Data1*. You can use wildcard characters (**&#42;** and **?**) to specify file names.
-   Comparing files of different sizes

    You must specify **/n** to compare files of different sizes. If the file sizes are different and **/n** is not specified, **comp** displays the following message:

    `Files are different sizes`

    `Compare more files (Y/N)?`

    To compare these files, press N to stop the **comp** command. Then, rerun the **comp** command with the **/n** option to compare only the first portion of each file.
-   Comparing files sequentially

    If you use wildcard characters (**&#42;** and **?**) to specify multiple files, **comp** finds the first file that matches *Data1* and compares it with the corresponding file in *Data2*, if it exists. The **comp** command reports the results of the comparison for each file matching *Data1*. When finished, **comp** displays the following message:

    `Compare more files (Y/N)?`

    To compare more files, press Y. The **comp** command prompts you for the locations and names of the new files. To stop the comparisons, press N. When you press Y, **comp** prompts you for command-line options to use. If you do not specify any command-line options, **comp** uses the ones you specified before.

## <a name="BKMK_examples"></a>Examples

To compare the contents of the directory C:\Reports with the backup directory \\\\Sales\Backup\April, type:
```
comp c:\reports \\sales\backup\april
```
To compare the first ten lines of the text files in the \Invoice directory and display the result in decimal format, type:
```
comp \invoice\*.txt \invoice\backup\*.txt /n=10 /d
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)