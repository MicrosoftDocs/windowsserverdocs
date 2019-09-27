---
title: fc
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 485fc3d8-b7c5-496d-87be-0011112f27d5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# fc



Compares two files or sets of files and displays the differences between them.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fc /a [/c] [/l] [/lb<N>] [/n] [/off[line]] [/t] [/u] [/w] [/<NNNN>] [<Drive1>:][<Path1>]<FileName1> [<Drive2>:][<Path2>]<FileName2>
fc /b [<Drive1:>][<Path1>]<FileName1> [<Drive2:>][<Path2>]<FileName2>
```

## Parameters

|            Parameter             |                                                                                                                                     Description                                                                                                                                      |
|----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                /a                |                                                 Abbreviates the output of an ASCII comparison. Instead of displaying all of the lines that are different, **fc** displays only the first and last line for each set of differences.                                                  |
|                /b                |             Compares the two files in binary mode, byte by byte, and does not attempt to resynchronize the files after finding a mismatch. This is the default mode for comparing files that have the following file extensions: .exe, .com, .sys, .obj, .lib, or .bin.              |
|                /c                |                                                                                                                               Ignores the letter case.                                                                                                                               |
|                /l                |               Compares the files in ASCII mode, line-by-line, and attempts to resynchronize the files after finding a mismatch. This is the default mode for comparing files, except files with the following file extensions: .exe, .com, .sys, .obj, .lib, or .bin.                |
|             /lb\<N>              |                         Sets the number of lines for the internal line buffer to *N*. The default length of the line buffer is 100 lines. If the files that you are comparing have more than 100 consecutive differing lines, **fc** cancels the comparison.                         |
|                /n                |                                                                                                                Displays the line numbers during an ASCII comparison.                                                                                                                 |
|            /off[line]            |                                                                                                               Does not skip files that have the offline attribute set.                                                                                                               |
|                /t                |                                                                    Prevents **fc** from converting tabs to spaces. The default behavior is to treat tabs as spaces, with stops at each eighth character position.                                                                    |
|                /u                |                                                                                                                        Compares files as Unicode text files.                                                                                                                         |
|                /w                |         Compresses white space (that is, tabs and spaces) during the comparison. If a line contains many consecutive spaces or tabs, **/w** treats these characters as a single space. When used with **/w**, **fc** ignores white space at the beginning and end of a line.         |
|             /\<NNNN>             | Specifies the number of consecutive lines that must match following a mismatch, before **fc** considers the files to be resynchronized. If the number of matching lines in the files is less than *NNNN*, **fc** displays the matching lines as differences. The default value is 2. |
| [\<Drive1>:][<Path1>]<FileName1> |                                                                                        Specifies the location and name of the first file or set of files to compare. *FileName1* is required.                                                                                        |
| [\<Drive2>:][<Path2>]<FileName2> |                                                                                       Specifies the location and name of the second file or set of files to compare. *FileName2* is required.                                                                                        |
|                /?                |                                                                                                                         Displays help at the command prompt.                                                                                                                         |

## Remarks

-   This command is implemeted by c:\WINDOWS\fc.exe. You can use this command within PowerShell, but be sure to spell out the full executable (fc.exe) since 'fc' is an alias for Format-Custom.

-   Reporting differences between files for an ASCII comparison

    When you use **fc** for an ASCII comparison, **fc** displays the differences between two files in the following order:  
    -   Name of the first file
    -   Lines from *FileName1* that differ between the files
    -   First line to match in both files
    -   Name of the second file
    -   Lines from *FileName2* that differ
    -   First line to match
-   Using **/b** for binary comparisons

    **/b** displays mismatches that are found during a binary comparison in the following syntax:

    `\<XXXXXXXX: YY ZZ>`

    The value of *XXXXXXXX* specifies the relative hexadecimal address for the pair of bytes, measured from the beginning of the file. Addresses start at 00000000. The hexadecimal values for *YY* and *ZZ* represent the mismatched bytes from *FileName1* and *FileName2*, respectively.
-   Using wildcard characters

    You can use wildcard characters (**&#42;** and **?**) in *FileName1* and *FileName2*. If you use a wildcard in *FileName1*, **fc** compares all the specified files to the file or set of files specified by *FileName2*. If you use a wildcard in *FileName2*, **fc** uses the corresponding value from *FileName1*.
-   Working with memory

    When comparing ASCII files, **fc** uses an internal buffer (large enough to hold 100 lines) as storage. If the files are larger than the buffer, **fc** compares what it can load into the buffer. If **fc** does not find a match in the loaded portions of the files, it stops and displays the following message:

    `Resynch failed. Files are too different.`

    When comparing binary files that are larger than the available memory, **fc** compares both files completely, overlaying the portions in memory with the next portions from the disk. The output is the same as that for files that fit completely in memory.

## <a name="BKMK_examples"></a>Examples

To make an ASCII comparison of two text files, Monthly.rpt and Sales.rpt, and display the results in abbreviated format, type:
```
fc /a monthly.rpt sales.rpt 
```
To make a binary comparison of two batch files, Profits.bat and Earnings.bat, type:
```
fc /b profits.bat earnings.bat
```
Results similar to the following appear:
```
00000002: 72 43
00000004: 65 3A
0000000E: 56 92
...
...
...
000005E8: 00 6E
FC: Earnings.bat longer than Profits.bat
```
If the Profits.bat and Earnings.bat files are identical, **fc** displays the following message:
```
Comparing files Profits.bat and Earnings.bat
FC: no differences encountered
```
To compare every .bat file in the current directory with the file New.bat, type:
```
fc *.bat new.bat
```
To compare the file New.bat on drive C with the file New.bat on drive D, type:
```
fc c:new.bat d:*.bat
```
To compare each batch file in the root directory on drive C to the file with the same name in the root directory on drive D, type:
```
fc c:*.bat d:*.bat
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
