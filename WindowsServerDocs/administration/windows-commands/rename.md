---
title: rename
description: Reference article for the rename command, which renames a file or directory.
ms.topic: reference
ms.assetid: 7f2ea658-0fa9-4015-8031-22c2b0089231
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# rename

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Renames files or directories.

> [!NOTE]
> This command is the same as the [ren command](ren.md).

## Syntax

```
rename [<drive>:][<path>]<filename1> <filename2>
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:][<path>]<filename1>` | Specifies the location and name of the file or set of files you want to rename. *Filename1* can include wildcard characters (**&#42;** and **?**). |
| `<filename2>` | Specifies the new name for the file. You can use wildcard characters to specify new names for multiple files. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can't specify a new drive or path when renaming files. You also can't use this command to rename files across drives or to move files to a different directory.

- Characters represented by wildcard characters in *filename2* will be identical to the corresponding characters in *filename1*.

- *Filename2* must be a unique file name. If *filename2* matches an existing file name, the following message appears: `Duplicate file name or file not found`.

### Examples

To change all the .txt file name extensions in the current directory to .doc extensions, type:

```
rename *.txt *.doc
```

To change the name of a directory from *Chap10* to *Part10*, type:

```
rename chap10 part10
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ren command](ren.md)
