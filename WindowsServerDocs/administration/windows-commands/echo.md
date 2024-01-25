---
title: echo
description: Reference article for the echo command, which displays messages or turns on or off the command echoing feature.
ms.topic: reference
ms.assetid: fb9fcd0f-5e73-4504-aa95-78204e1a79d3
ms.author: wscontent
author: xelu86
ms.date: 10/02/2023
---

# echo

Displays messages or turns on or off the command echoing feature. If used without parameters, **echo** displays the current echo setting.

## Syntax

```
echo [<message>]
echo [on | off]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [on \| off] | Turns on or off the command echoing feature. Command echoing is on by default. |
| `<message>` | Specifies the text to display on the screen. |
| /? | Displays help at the command prompt. |

#### Remarks

- The `echo <message>` command is more useful when **echo** is turned off. To display a message that is several lines long without displaying any commands, you can include several `echo <message>` commands after the **echo off** command in your batch program.

- After **echo** is turned off, the command prompt doesn't appear in the Command Prompt window. To display the command prompt, type **echo on.**

- If used in a batch file, **echo on** and **echo off** don't affect the setting at the command prompt.

- If there's an empty variable in a batch file while using **echo**, it displays "ECHO is off". To prevent seeing this message, and produce a blank line instead, place a colon (`:`) between **echo** and the variable. For example, `echo:%var%`.

- To prevent echoing a particular command in a batch file, insert an (`@`) sign in front of the command. To prevent echoing all commands in a batch file, include the **echo off** command at the beginning of the file.

- To display an exclamation mark (`!`) in batch scripts, wrap the word or phrase in double quotes followed by a caret before the exclamation mark (`"Hello World^!"`). Alternatively, a double caret (`^^`) can be used without the need for double quotes (`Hello World^^!`).

- To display a pipe (`|`), ampersand (`&`) or redirection character (`<` or `>`) when you're using **echo**, use a caret (`^`) immediately before that character. For example, `^|`, `^&`, `^>`, or `^<`. To display a caret, type two carets in succession (`^^`).

### Examples

To display the current **echo** setting, type:

```
echo
```

To echo a blank line on the screen, type:

```
echo.
```

> [!NOTE]
> Don't include a space before the period. Otherwise, the period appears instead of a blank line.

To prevent echoing commands at the command prompt, type:

```
echo off
```

> [!NOTE]
> When **echo** is turned off, the command prompt doesn't appear in the Command Prompt window. To display the command prompt again, type **echo on**.

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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
