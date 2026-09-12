---
title: rename
description: Learn how to use the rename command to rename files or directories from the command line in Windows Server, including wildcard examples for batch renaming.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
ai-usage: ai-assisted
---

# rename

Renames one or more files or directories. Use wildcard characters (`*` and `?`) to rename multiple files in a single command.

> [!NOTE]
> This command is the same as the [ren command](ren.md).

## Syntax

```syntax
rename [<drive>:][<path>]<filename1> <filename2>
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:][<path>]<filename1>` | Specifies the location and name of the file or set of files you want to rename. *Filename1* can include wildcard characters (**&#42;** and **?**). |
| `<filename2>` | Specifies the new name for the file. Use wildcard characters to specify new names for multiple files. |
| `/?` | Shows help at the command prompt. |

#### Remarks

- You can't specify a new drive or path when renaming files. You also can't use this command to rename files across drives or to move files to a different directory.

- Wildcard characters in *filename2* represent the corresponding characters in *filename1*.

- *Filename2* must be a unique file name. If *filename2* matches an existing file name, the following message appears: `Duplicate file name or file not found`.

### Examples

To change all the .txt file name extensions in the current directory to .doc extensions, type:

```cmd
rename *.txt *.doc
```

When you use wildcards in *filename2*, the command replaces each wildcard with the characters in the *same position* in the original name. A **?** keeps the single character in that position, and a **&#42;** keeps all remaining characters from that position to the end of the name or extension. Because the match is positional, the results can be surprising.

To replace a fixed-length prefix in a set of file names while keeping the rest of each name, type:

```cmd
rename img*.jpg pic*.jpg
```

Because `img` and `pic` are both three characters, each **&#42;** starts at the same position, so only the prefix changes:

| Original file name | New file name |
|--|--|
| `img001.jpg` | `pic001.jpg` |
| `img_final.jpg` | `pic_final.jpg` |

> [!NOTE]
> The replacement prefix must be the same length as the text it replaces. For example, `rename img*.jpg photo*.jpg` renames `img001.jpg` to `photo1.jpg`, because `photo` is five characters and overwrites the first five characters (`img00`) of the original name.

To change a single character at a known position and keep the rest of the name, type:

```cmd
rename ??-*.log ??_*.log
```

This command matches names whose third character is a hyphen and replaces only that hyphen with an underscore:

| Original file name | New file name |
|--|--|
| `ab-server.log` | `ab_server.log` |
| `db-audit.log` | `db_audit.log` |

To append an extension without removing the current one, type:

```cmd
rename *.log *.log.bak
```

The **&#42;** keeps the original name and extension, and the command appends `.bak` to the end:

| Original file name | New file name |
|--|--|
| `server.log` | `server.log.bak` |
| `app.debug.log` | `app.debug.log.bak` |

To change the name of a directory from *Chap10* to *Part10*, type:

```cmd
rename chap10 part10
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ren command](ren.md)
