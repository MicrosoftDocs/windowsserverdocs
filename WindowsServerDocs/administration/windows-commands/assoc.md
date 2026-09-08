---
title: assoc
no-loc: [assoc]
description: Reference article for the assoc command, which displays or modifies file name extension associations.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# assoc

Displays or modifies file name extension associations. If used without parameters, **assoc** displays a list of all the current file name extension associations.

> [!NOTE]
> This command is only supported within cmd.exe and is not available from PowerShell.
> Though you can use `cmd /c assoc` as a workaround.

## Syntax

```
assoc [<.[ext]>[=[<filetype>]]]
```

> [!NOTE]
> In the syntax, square brackets `[ ]` indicate optional items and angle brackets `< >` indicate placeholder values that you replace with your own text. Don't type the brackets. For example, to remove the association for the .jar file name extension, type `assoc .jar=`, not `assoc .jar=<filetype>`. If you type the angle brackets, cmd.exe treats `<` and `>` as redirection operators and returns an error. For more information, see [Command-Line Syntax Key](command-line-syntax-key.md).

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<.ext>` | Specifies the file name extension. |
| `<filetype>` | Specifies the file type to associate with the specified file name extension. |
| /? | Displays help at the command prompt. |

### Remarks

- To make changes in associations, you need administrator privileges.

- To remove the file type association for a file name extension, type the extension and an equal sign with nothing after it, for example `assoc .ext=`. You don't need to add a trailing space after the equal sign.

- To associate files without extension to a file type, use just a dot (see the examples).

- To view current file types that have open command strings defined, use the **ftype** command.

- To redirect the output of **assoc** to a text file, use the `>` redirection operator.

## Examples

To view the current file type association for the file name extension .txt, type:

```
assoc .txt
```

To remove the file type association for the file name extension .bak, type:

```
assoc .bak=
```

Type nothing after the equal sign. Don't type placeholder text such as `<filetype>`, and don't add a trailing space.

To remove the file type association for the file name extension .jar, type:

```
assoc .jar=
```

To view the output of **assoc** one screen at a time, type:

```
assoc | more
```

To send the output of **assoc** to the file assoc.txt, type:

```
assoc>assoc.txt
```

Associate **.log** to text files:

```
assoc .log=txtfile
```

Associate files with no extension to text files:

```
assoc .=txtfile
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftype command](ftype.md)
