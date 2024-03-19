---
title: subst
description: Reference article for the subst command, which associates a path with a drive letter.
ms.topic: reference
ms.assetid: 3e69234c-2312-4343-868b-afc1017c622a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# subst

Associates a path with a drive letter. If used without parameters, **subst** displays the names of the virtual drives in effect.

## Syntax

```
subst [<drive1>: [<drive2>:]<path>]
subst <drive1>: /d
```

### Parameters

| Parameter | Description |
|--|--|
| `<drive1>:` | Specifies the virtual drive to which you want to assign a path. |
| `[<drive2>:]<path>` | Specifies the physical drive and path that you want to assign to a virtual drive. |
| /d | Deletes a substituted (virtual) drive. |
| /? | Displays help at the command prompt. |

## Remarks

- The following commands don't work and must not be used on drives specified in the **subst** command:

  - [chkdsk command](chkdsk.md)

    [diskcomp command](diskcomp.md)

    [diskcopy command](diskcopy.md)

    [format command](format.md)

    [label command](label.md)

    [recover command](recover.md)

- The `<drive1>` parameter must be within the range that is specified by the **lastdrive** command. If not, **subst** displays the following error message: `Invalid parameter - drive1:`

## Examples

To create a virtual drive z for the path b:\user\betty\forms, type:

```
subst z: b:\user\betty\forms
```

Instead of typing the full path, you can reach this directory by typing the letter of the virtual drive followed by a colon as follows:

```
z:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)