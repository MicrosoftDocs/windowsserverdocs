---
title: find
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ca66b22-3b7c-4166-8503-eb75fc53ab46
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# find



Searches for a string of text in a file or files, and displays lines of text that contain the specified string.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
find [/v] [/c] [/n] [/i] [/off[line]] "<String>" [[<Drive>:][<Path>]<FileName>[...]]
```

## Parameters

|           Parameter           |                                              Description                                               |
|-------------------------------|--------------------------------------------------------------------------------------------------------|
|              /v               |                    Displays all lines that do not contain the specified \<String>.                     |
|              /c               |              Counts the lines that contain the specified \<String>and displays the total.              |
|              /n               |                            Precedes each line with the file's line number.                             |
|              /i               |                            Specifies that the search is not case-sensitive.                            |
|         [/off[line]]          |                        Does not skip files that have the offline attribute set.                        |
|          "\<String>"          | Required. Specifies the group of characters (enclosed in quotation marks) that you want to search for. |
| [\<Drive>:][<Path>]<FileName> |        Specifies the location and name of the file in which to search for the specified string.        |
|              /?               |                                  Displays help at the command prompt.                                  |

## Remarks

-   Specifying a string

    If you do not use **/i**, **find** searches for exactly what you specify for *String*. For example, the **find** command treats the characters "a" and "A" differently. If you use **/i**, however, **find** is not case sensitive, and it treats "a" and "A" as the same character.

    If the string you want to search for contains quotation marks, you must use double quotation marks for each quotation mark contained within the string (for example, "This ""string"" contains quotation marks").
-   Using **find** as a filter

    If you omit a file name, **find** acts as a filter, taking input from the standard input source (usually the keyboard, a pipe (|), or a redirected file) and then displaying any lines that contain *String*.
-   Ordering command syntax

    You can type parameters and command-line options for the **find** command in any order.
-   Using wildcards

    You cannot use wildcards (**&#42;** and **?**) in file names or extensions that you specify with the **find** command. To search for a string in a set of files that you specify with wildcards, you can use the **find** command within a **for** command.
-   Using **/v** or **/n** with **/c**

    If you use **/c** and **/v** in the same command line, **find** displays a count of the lines that do not contain the specified string. If you specify **/c** and **/n** in the same command line, **find** ignores **/n**.
-   Using **find** with carriage returns

    The **find** command does not recognize carriage returns. When you use **find** to search for text in a file that includes carriage returns, you must limit the search string to text that can be found between carriage returns (that is, a string that is not likely to be interrupted by a carriage return). For example, **find** does not report a match for the string "tax file" if a carriage return occurs between the words "tax" and "file."

## <a name="BKMK_examples"></a>Examples

To display all lines from Pencil.ad that contain the string "Pencil Sharpener", type:
```
find "Pencil Sharpener" pencil.ad
```
To find a string that contains text within quotation marks, you must enclose the entire string in quotation marks. Then you must use two quotation marks for each quotation mark contained within the string. To find "The scientists labeled their paper "for discussion only." It is not a final report." in Report.doc, type:
```
find "The scientists labeled their paper ""for discussion only."" It is not a final report." report.doc
```
If you want to search for a set of files, you can use the **find** command within the **for** command. To search the current directory for files that have the extension .bat and that contain the string "PROMPT", type:
```
for %f in (*.bat) do find "PROMPT" %f 
```
To search your hard disk to find and display the file names on drive C that contain the string "CPU", use the pipe (|) to direct the output of the **dir** command to the **find** command as follows:
```
dir c:\ /s /b | find "CPU" 
```
Because **find** searches are case-sensitive and **dir** produces uppercase output, you must either type the string "CPU" in uppercase letters or use the **/i** command-line option with **find**.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)