---
title: del
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 346eede2-2085-44f5-9936-6877b5d5a833
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# del

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes one or more files. This command is the same as the **erase** command.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
del [/p] [/f] [/s] [/q] [/a[:]<attributes>] <Names>
erase [/p] [/f] [/s] [/q] [/a[:]<attributes>] <Names>
```
## Parameters
|Parameter|Description|
|-------|--------|
|<Names>|Specifies a list of one or more files or directories. Wildcards may be used to delete multiple files. If a directory is specified, all files within the directory will be deleted.|
|/p|prompts for confirmation before deleting the specified file.|
|/f|forces deletion of read-only files.|
|/s|deletes specified files from the current directory and all subdirectories. Displays the names of the files as they are being deleted.|
|/q|Specifies quiet mode. You are not prompted for delete confirmation.|
|/a[:]<attributes>|deletes files based on the following file attributes:<br /><br />**r** Read-only files<br /><br />**h** Hidden files<br /><br />**i** Not content indexed files<br /><br />**s** System files<br /><br />**a** Files ready for archiving<br /><br />**l** Reparse points<br /><br />-  Prefix meaning 'not'|
|/?|Displays help at the command prompt.|
## remarks
> [!CAUTION]
> if you use **del** to delete a file from your disk, you cannot retrieve it.
-   if you use **/p**, **del** displays the name of a file and sends the following message:
    `FileName, delete (Y/N)?`
    To confirm the deletion, press Y. To cancel the deletion and display the next file name (that is, if you specified a group of files), press N. To stop the **del** command, press CTRL+C.
-   if you disable command extensions, **/s** displays the names of any files that were not found instead of displaying the names of files that are being deleted (that is, the behavior is reversed).
-   if you specify a folder in *Names*, all of the files in the folder are deleted. For example, the following command deletes all of the files in the \Work folder:
    ```
    del \work
    ```
-   You can use wildcards (**\*** and **?**) to delete more than one file at a time. However, to avoid deleting files unintentionally, you should use wildcards cautiously with the **del** command. For example, if you type the following command:
    ```
    del *.*
    ```
    The **del** command displays the following prompt:
    `Are you sure (Y/N)?`
    To delete all of the files in the current directory, press Y and then press ENTER. To cancel the deletion, press N and then press ENTER.
> [!NOTE]
> Before you use wildcard characters with the **del** command, use the same wildcard characters with the **dir** command to list all the files that will be deleted.
-   The **del** command, with different parameters, is available from the recovery Console.
## <a name="BKMK_examples"></a>Examples
To delete all the files in a folder named Test on drive C, type either of the following:
```
del c:\test
del c:\test\*.*
```
To delete all files with the .bat file name extension from the current directory, type:
```
del *.bak
```
To delete all read-only files in the current directory, type:
```
del /a:r *.*
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
