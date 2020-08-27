---
title: assoc
description: Reference article for the assoc command, which displays or modifies file name extension associations.
ms.topic: reference
ms.assetid: 237bedda-b24c-4fec-a39c-9b7eacf96417
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# assoc

Displays or modifies file name extension associations. If used without parameters, **assoc** displays a list of all the current file name extension associations.

> [!NOTE]
> This command is only supported within cmd.exe and is not available from PowerShell.
> Though you can use `cmd /c assoc` as a workaround.

## Syntax

```
assoc [<.ext>[=[<filetype>]]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<.ext>` | Specifies the file name extension. |
| `<filetype>` | Specifies the file type to associate with the specified file name extension. |
| /? | Displays help at the command prompt. |

### Remarks

- To remove the file type association for a file name extension, add a white space after the equal sign by pressing the SPACEBAR.

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

> [!NOTE]
> Make sure you add a space after the equal sign.

To view the output of **assoc** one screen at a time, type:

```
assoc | more
```

To send the output of **assoc** to the file assoc.txt, type:

```
assoc>assoc.txt
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftype command](ftype.md)
