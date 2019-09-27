---
title: ren
description: Learn how to rename a file or directory with the ren command.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60398e12-a05d-4524-a73a-0a925943e21d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---

# ren

Renames files or directories. This command is the same as the **rename** command.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
ren [<Drive>:][<Path>]<FileName1> <FileName2>
rename [<Drive>:][<Path>]<FileName1> <FileName2>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:][\<Path>]\<FileName1>|Specifies the location and name of the file or set of files you want to rename. *FileName1* can include wildcard characters (**&#42;** and **?**).|
|\<FileName2>|Specifies the new name for the file. You can use wildcard characters to specify new names for multiple files.|
|/?|Displays help at the command prompt.|

## Remarks

- You cannot specify a new drive or path when renaming files.
- You cannot use the **ren** command to rename files across drives or to move files to a different directory.
- You can use wildcard characters (**&#42;** and **?**) in either *FileName* parameter. Characters that are represented by wildcard characters in *FileName2* will be identical to the corresponding characters in *FileName1*.
- *FileName2* must be a unique file name. If *FileName2* matches an existing file name, **ren** displays the following message:  
  ```
  Duplicate file name or file not found
  ```

## <a name="BKMK_examples"></a>Examples

To change all the .txt file name extensions in the current directory to .doc extensions, type:
```
ren *.txt *.doc 
```
To change the name of a directory from Chap10 to Part10, type:
```
ren chap10 part10 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)