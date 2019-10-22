---
title: attrib
description: "Windows Commands topic for **attrib** - Displays, sets, or removes attributes assigned to files or directories."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e763ca5-21a2-45d2-b26d-a9c44c99091a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# attrib



Displays, sets, or removes attributes assigned to files or directories. If used without parameters, **attrib** displays attributes of all files in the current directory.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
attrib [{+|-}r] [{+|-}a] [{+|-}s] [{+|-}h] [{+|-}i] [<Drive>:][<Path>][<FileName>] [/s [/d] [/l]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|{+\|-}r|Sets (**+**) or clears (**-**) the Read-only file attribute.|
|{+\|-}a|Sets (**+**) or clears (**-**) the Archive file attribute.|
|{+\|-}s|Sets (**+**) or clears (**-**) the System file attribute.|
|{+\|-}h|Sets (**+**) or clears (**-**) the Hidden file attribute.|
|{+\|-}i|Sets (**+**) or clears (**-**) the Not Content Indexed file attribute.|
|[\<Drive>:][<Path>][<FileName>]|Specifies the location and name of the directory, file, or group of files for which you want to display or change attributes. You can use the **?** and **&#42;** wildcard characters in the *FileName* parameter to display or change the attributes for a group of files.|
|/s|Applies **attrib** and any command-line options to matching files in the current directory and all of its subdirectories.|
|/d|Applies **attrib** and any command-line options to directories.|
|/l|Applies **attrib** and any command-line options to the Symbolic Link, rather than the target of the Symbolic Link.|
|/?|Displays help at the command prompt.|

## Remarks

-   You can use wildcard characters (**?** and **&#42;**) with the *FileName* parameter to display or change the attributes for a group of files.
-   If a file has the System (**s**) or Hidden (**h**) attribute set, you must clear the attribute before you can change any other attributes for that file.
-   The Archive attribute (**a**) marks files that have changed since the last time they were backed up. Note that the **xcopy** command uses archive attributes.

## <a name="BKMK_examples"></a>Examples

To display the attributes of a file named News86 that is located in the current directory, type:
```
attrib news86 
```
To assign the Read-only attribute to the file named Report.txt, type:
```
attrib +r report.txt 
```
To remove the Read-only attribute from files in the Public directory and its subdirectories on a disk in drive B, type:
```
attrib -r b:\public\*.* /s 
```
To set the Archive attribute for all files on drive A, and then clear the Archive attribute for files with the .bak extension, type:
```
attrib +a a:*.* & attrib -a a:*.bak 
```
