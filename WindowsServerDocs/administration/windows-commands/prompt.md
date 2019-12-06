---
title: prompt
description: Learn how to customize your command prompt.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3d98e965-02eb-46ad-9d0a-5dc44830373e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---

# prompt



Changes the Cmd.exe command prompt. If used without parameters, **prompt** resets the command prompt to the default setting, which is the current drive letter and directory followed by the greater than symbol (**>**).

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
prompt [<Text>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Text>|Specifies the text and information that you want to include in the command prompt.|
|/?|Displays help at the command prompt.|

## Remarks

You can customize the command prompt to display any text you want, including such information as the name of the current directory, the time and date, and the Microsoft Windows version number.

The following table lists the character combinations that you can include instead of, or in addition to, one or more character strings in the *Text* parameter. The list includes a brief description of the text or information that each character combination adds to your command prompt.  

| Character |                                 Description                                 |
|-----------|-----------------------------------------------------------------------------|
|    $q     |                               = (equal sign)                                |
|    $$     |                               $ (dollar sign)                               |
|    $t     |                                Current time                                 |
|    $d     |                                Current date                                 |
|    $p     |                           Current drive and path                            |
|    $v     |                           Windows version number                            |
|    $n     |                                Current drive                                |
|    $g     |                            > (greater than sign)                            |
|    $l     |                             < (less than sign)                              |
|    $b     |                              \| (pipe symbol)                               |
|    $_     |                               ENTER-LINEFEED                                |
|    $e     |                         ANSI escape code (code 27)                          |
|    $h     | Backspace (to delete a character that has been written to the command line) |
|    $a     |                                & (ampersand)                                |
|    $c     |                            ( (left parenthesis)                             |
|    $f     |                            ) (right parenthesis)                            |
|    $s     |                                    space                                    |

When command extensions are enabled (that is, the default) the **prompt** command supports the following formatting characters:  

|Character|Description|
|---------|-----------|
|$+|Zero or more plus sign (**+**) characters, depending on the depth of the **pushd** directory stack (one character for each level pushed).|
|$m|The remote name associated with the current drive letter or the empty string if current drive is not a network drive.|

If you include the **$p** character in the text parameter, your disk is read after you enter each command (to determine the current drive and path). This can take extra time, especially for floppy disk drives.

## <a name="BKMK_examples"></a>Examples

To set a two-line command prompt with the current time and date on the first line and the greater than sign on the next line, type:
```
prompt $d$s$s$t$_$g 
```
The prompt is changed as follows, where the date and time are current:
```
Fri 06/01/2007  13:53:28.91
>
```
To set the command prompt to display as an arrow (`-->`), type:
```
prompt --$g
```
To manually change the command prompt to the default setting (the current drive and path followed by the greater than sign), type:
```
prompt $p$g
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
