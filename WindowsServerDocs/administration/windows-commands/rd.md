---
title: rd
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 42e672f6-5bc2-4c16-af25-18e7ed2dd555
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# rd



Deletes a directory. This command is the same as the **rmdir** command.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
rd [<Drive>:]<Path> [/s [/q]]
rmdir [<Drive>:]<Path> [/s [/q]]
```

## Parameters

|     Parameter     |                                                                 Description                                                                  |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| [\<Drive>:]<Path> |                      Specifies the location and the name of the directory that you want to delete. *Path* is required.                       |
|        /s         |                     Deletes a directory tree (the specified directory and all its subdirectories, including all files).                      |
|        /q         | Specifies quiet mode. Does not prompt for confirmation when deleting a directory tree. (Note that **/q** works only if **/s** is specified.) |
|        /?         |                                                     Displays help at the command prompt.                                                     |

## Remarks

-   You cannot delete a directory that contains files, including hidden or system files. If you attempt to do so, the following message appears:

    `The directory is not empty`

    Use the **dir /a** command to list all files (including hidden and system files). Then use the **attrib** command with **-h** to remove hidden file attributes, **-s** to remove system file attributes, or **-h -s** to remove both hidden and system file attributes. After the hidden and file attributes have been removed, you can delete the files.
-   If you insert a backslash (\) at the beginning of *Path*, *Path* will start at the root directory (regardless of the current directory).
-   You cannot use **rd** to delete the current directory. If you attempt to delete the current directory, the following error message appears:

    `The process cannot access the file because it is being used by another process.`

    If you receive this error message, you must change to a different directory (not a subdirectory of the current directory), and then use **rd** (specify *Path* if necessary).
-   The **rd** command, with different parameters, is available from the Recovery Console.

## <a name="BKMK_examples"></a>Examples

You cannot delete the directory that you are currently working in. You must change to a directory that is not within the current directory. For example, to change to the parent directory, type:
```
cd ..
```
You can now safely remove the desired directory.

Use the **/s** option to remove a directory tree. For example, to remove a directory named Test (and all its subdirectories and files) from the current directory, type:
```
rd /s test
```
To run the previous example in quiet mode, type:
```
rd /s /q test
```

> [!CAUTION]
> When you run **rd /s** in quiet mode, the entire directory tree is deleted without confirmation. Ensure that important files are moved or backed up before using the **/q** command-line option.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)