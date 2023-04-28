---
title: move
description: Reference article for the move command, which moves one or more files from one directory to another directory.
ms.topic: reference
ms.assetid: fde290a8-d385-450f-8987-ee837fed667d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# move

Moves one or more files from one directory to another directory.

> [!IMPORTANT]
> Moving encrypted files to a volume that doesn't support Encrypting File System (EFS) results will result in an error. You must first decrypt the files or move them to a volume that supports EFS.

## Syntax

```
move [{/y|-y}] [<source>] [<target>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /y | Stops prompting for confirmation that you want to overwrite an existing destination file. This parameter might be preset in the COPYCMD environment variable. You can override this preset by using the **-y** parameter. The default is to prompt before overwriting files, unless the command is run from within a batch script. |
| -y | Starts prompting for confirmation that you want to overwrite an existing destination file. |
| `<source>` | Specifies the path and name of the file(s) to move. To move or rename a directory, the *source* should be the current directory path and name. |
| `<target>` | Specifies the path and name to move files to. To move or rename a directory, the *target* should be the desired directory path and name. |
| /? | Displays help at the command prompt. |

### Examples

To move all files with the .xls extension from the *\Data* directory to the *\Second_Q\Reports* directory, type:

```
move \data\*.xls \second_q\reports\
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
