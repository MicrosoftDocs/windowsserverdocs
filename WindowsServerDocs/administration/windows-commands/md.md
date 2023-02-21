---
title: md
description: Reference article for the md command, which creates a directory or subdirectory.
ms.topic: reference
ms.assetid: 82162d00-cc34-4776-9e55-4b4836dbd6a9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# md

Creates a directory or subdirectory. Command extensions, which are enabled by default, allow you to use a single **md** command to create intermediate directories in a specified path.

> [!NOTE]
> This command is the same as the [mkdir command](mkdir.md).

## Syntax

```
md [<drive>:]<path>
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
md Directory1
```

To create the directory tree *Taxes\Property\Current* within the root directory, with command extensions enabled, type:

```
md \Taxes\Property\Current
```

To create the directory tree *Taxes\Property\Current* within the root directory as in the previous example, but with command extensions disabled, type the following sequence of commands:

```
md \Taxes
md \Taxes\Property
md \Taxes\Property\Current
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [mkdir command](mkdir.md)