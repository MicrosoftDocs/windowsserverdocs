---
title: ftype
description: Reference article for the ftype command, which displays or modifies file type used in file name extension associations.
ms.topic: reference
ms.assetid: 6fb53cee-9bed-44dd-af5d-bc7cec1dd114
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftype

Displays or modifies file types that are used in file name extension associations. If used without an assignment operator (=), this command displays the current open command string for the specified file type. If used without parameters, this command displays the file types that have open command strings defined.

> [!NOTE]
> This command is only supported within cmd.exe and is not available from PowerShell.
> Though you can use `cmd /c ftype` as a workaround.

## Syntax

```
ftype [<filetype>[=[<opencommandstring>]]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<filetype>` | Specifies the file type to display or change. |
| `<opencommandstring>` | Specifies the open command string to use when opening files of the specified file type.|
| /? | Displays help at the command prompt. |

#### Remarks

The following table describes how **ftype** substitutes variables within an open command string:

| Variable | Replacement value |
| -------- | ----------------- |
| `%0` or `%1` | Gets substituted with the file name being launched through the association. |
| `%*` | Gets all of the parameters. |
| `%2`, `%3`, ... | Gets the first parameter (`%2`), the second parameter (`%3`), and so on. |
| `%~<n>` | Gets all of the remaining parameters starting with the *n*th parameter, where *n* can be any number from 2 to 9. |

### Examples

To display the current file types that have open command strings defined, type:

```
ftype
```

To display the current open command string for the *txtfile* file type, type:

```
ftype txtfile
```

This command produces output similar to the following:

`txtfile=%SystemRoot%\system32\NOTEPAD.EXE %1`

To delete the open command string for a file type called *example*, type:

```
ftype example=
```

To associate the .pl file name extension with the PerlScript file type and enable the PerlScript file type to run PERL.EXE, type the following commands:

```
assoc .pl=PerlScript
ftype PerlScript=perl.exe %1 %*
```

To eliminate the need to type the .pl file name extension when invoking a Perl script, type:

```
set PATHEXT=.pl;%PATHEXT%
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
