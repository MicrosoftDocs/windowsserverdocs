---
title: rem
description: Reference article for the rem command, which records comments in a script, batch, or config.sys file.
ms.topic: reference
ms.assetid: 1a45b585-a83c-4ff6-badd-ff40f34cec23
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# rem

Records comments in a script, batch, or config.sys file. If no comment is specified, **rem** adds vertical spacing.

> [!NOTE]
> This command is internal to the command-line interpreter, cmd.exe.

## Syntax

```
rem [<comment>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<comment>` | Specifies a string of characters to include as a comment. |
| /? | Displays help at the command prompt. |

#### Remarks

- The **rem** command doesn't display comments on the screen. To display comments on the screen, you must include the **echo on** command in your file.

- You can't use a redirection character (`<` or `>`) or pipe (`|`) in a batch file comment.

- Although you can use **rem** without a comment to add vertical spacing to a batch file, you can also use blank lines. Blank lines are ignored when a batch program is processed.

### Examples

To add vertical spacing through batch file comments, type:

```
@echo off
rem  This batch program formats and checks new disks.
rem  It is named Checknew.bat.
rem
rem echo Insert new disk in Drive B.
pause
format b: /v chkdsk b:
```

To include an explanatory comment before the **prompt** command in a config.sys file, type:

```
rem Set prompt to indicate current directory
prompt $p$g
```

To provide a comment about what a script does, type:

```
rem The commands in this script set up 3 drives.
rem The first drive is a primary partition and is
rem assigned the letter D. The second and third drives
rem are logical partitions, and are assigned letters
rem E and F.
create partition primary size=2048
assign d:
create partition extended
create partition logical size=2048
assign e:
create partition logical
assign f:
```

For multi-line comments, use conditional execution:

```
  Rem/||(
    The REM statement evaluates to success,
    so these lines will never be executed.
    Keep in mind that you will need to escape closing parentheses
    within multi-line comment blocks like shown in this example. ^)
  )
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
