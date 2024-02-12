---
title: mkdir
description: Reference article for the mkdir command, which creates a directory or subdirectory.
ms.topic: reference
ms.assetid: 033a57a2-5deb-4c98-aa78-61ce8df2a330
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# mkdir

Creates a directory or subdirectory. Command extensions, which are enabled by default, allow you to use a single **mkdir** command to create intermediate directories in a specified path.

> [!NOTE]
> This command is the same as the [md command](md.md).

## Syntax

```
mkdir [<drive>:]<path>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>`: | Specifies the drive on which you want to create the new directory. |
| `<path>` | Specifies the name and location of the new directory. The maximum length of any single path is determined by the file system. This is a required parameter. |
| /? | Displays help at the command prompt. |

### Examples

To create a directory named *Directory1* within the current directory, type:

```
mkdir Directory1
```

To create the directory tree *Taxes\Property\Current* within the root directory, with command extensions enabled, type:

```
mkdir \Taxes\Property\Current
```

To create the directory tree *Taxes\Property\Current* within the root directory as in the previous example, but with command extensions disabled, type the following sequence of commands:

```
mkdir \Taxes
mkdir \Taxes\Property
mkdir \Taxes\Property\Current
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [md command](md.md)