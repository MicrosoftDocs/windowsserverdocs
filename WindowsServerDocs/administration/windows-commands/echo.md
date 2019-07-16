---
title: echo
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb9fcd0f-5e73-4504-aa95-78204e1a79d3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# echo



Displays messages or turns on or off the command echoing feature. If used without parameters, **echo** displays the current echo setting.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
echo [<Message>]
echo [on | off]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|[on \| off]|Turns on or off the command echoing feature. Command echoing is on by default.|
|\<Message>|Specifies the text to display on the screen.|
|/?|Displays help at the command prompt.|

## Remarks

-   The **echo** *Message* command is particularly useful when **echo** is turned off. To display a message that is several lines long without displaying any commands, you can include several **echo** *Message* commands after the **echo off** command in your batch program.
-   When **echo** is turned off, the command prompt does not appear in the Command Prompt window. To display the command prompt, type **echo on.**
-   If used in a batch file, **echo on** and **echo off** do not affect the setting at the command prompt.
-   To prevent echoing a particular command in a batch file, insert an at sign (@) in front of the command. To prevent echoing all commands in a batch file, include the **echo off** command at the beginning of the file.
-   To display a pipe (**|**) or redirection character (**<** or **>**) when you are using **echo**, use a caret (^) immediately before the pipe or redirection character (for example, **^|**, **^>**, or **^<**). To display a caret, type two carets in succession (**^^**).

## Examples

To display the current **echo** setting, type:

```
echo
```

To echo a blank line on the screen, type:

```
echo.
```

> [!NOTE]
> Do not include a space before the period. Otherwise, the period will be displayed instead of a blank line.

To prevent echoing commands at the command prompt, type:

```
echo off 
```

> [!NOTE]
> When **echo** is turned off, the command prompt does not appear in the Command Prompt window. To display the command prompt again, type **echo on**.

To prevent all commands in a batch file (including the **echo off** command) from displaying on the screen, on the first line of the batch file type:

```
@echo off
```

You can use the **echo** command as part of an **if** statement. For example, to search the current directory for any file with the .rpt file name extension, and to echo a message if such a file is found, type:

```
if exist *.rpt echo The report has arrived.
```

The following batch file searches the current directory for files with the .txt file name extension, and displays a message indicating the results of the search:

```
@echo off
if not exist *.txt (
echo This directory contains no text files.
) else (
   echo This directory contains the following text files:
   echo.
   dir /b *.txt
   )
```

If no .txt files are found when the batch file is run, the following message displays:

```
This directory contains no text files.
```

If .txt files are found when the batch file is run the following output displays (for this example, assume the files File1.txt, File2.txt, and File3.txt exist):

```
This directory contains the following text files:
File1.txt
File2.txt
File3.txt
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
