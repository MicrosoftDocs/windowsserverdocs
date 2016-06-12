---
title: rem
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a45b585-a83c-4ff6-badd-ff40f34cec23
---
# rem
Records comments \(remarks\) in a batch file or CONFIG.SYS. if no comment is specified, **rem** adds vertical spacing.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
rem [<Comment>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<Comment>|Specifies a string of characters to include as a comment.|
|\/?|Displays help at the command prompt.|

## remarks

-   The **rem** command does not display comments on the screen. You must use the **echo on** command in your batch or CONFIG.SYS file to display comments on the screen.

-   You cannot use a redirection character \(**<** or **>**\) or pipe \(**|**\) in a batch file comment.

-   Although you can use **rem** without a comment to add vertical spacing to a batch file, you can also use blank lines. Blank lines are ignored when a batch program is processed.

## <a name="BKMK_examples"></a>Examples
The following example shows a batch file that uses remarks for comments and for vertical spacing:

```
@echo off
rem  This batch program formats and checks new disks.
rem  It is named Checknew.bat.
rem
rem echo Insert new disk in Drive B.
pause 
format b: /v chkdsk b: 
```

To include an explanatory comment before the **prompt** command in your CONFIG.SYS file, add the following lines to CONFIG.SYS:

```
rem Set prompt to indicate current directory
prompt $p$g
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


