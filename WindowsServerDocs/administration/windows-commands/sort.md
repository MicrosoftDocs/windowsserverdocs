---
title: sort
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 77116469-4790-4442-8a21-9fa73b65ef9f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# sort



Reads input, sorts data, and writes the results to the screen, to a file, or to another device.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
sort [/r] [/+<N>] [/m <Kilobytes>] [/l <Locale>] [/rec <Characters>] [[<Drive1>:][<Path1>]<FileName1>] [/t [<Drive2>:][<Path2>]] [/o [<Drive3>:][<Path3>]<FileName3>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/r|Reverses the sort order (that is, sorts from Z to A and from 9 to 0).|
|/+\<N>|Specifies the character position number where **sort** will begin each comparison. *N* can be any valid integer.|
|/m \<Kilobytes>|Specifies the amount of main memory to use for the sort in kilobytes (KB).|
|/l \<Locale>|Overrides the sort order of characters that are defined by the system default locale (that is, the language and Country/Region selected during installation).|
|/rec \<Characters>|Specifies the maximum number of characters in a record or a line of the input file (the default value is 4,096 and the maximum is 65,535).|
|[\<Drive1>:][\<Path1>]\<FileName1>|Specifies the file to be sorted. If no file name is specified, the standard input is sorted. Specifying the input file is faster than redirecting the same file as standard input.|
|/t [\<Drive2>:][\<Path2>]|Specifies the path of the directory to hold the **sort** command's working storage if the data does not fit in the main memory. By default, the system temporary directory is used.|
|/o [\<Drive3>:][\<Path3>]\<FileName3>|Specifies the file where the sorted input is to be stored. If not specified, the data is written to the standard output. Specifying the output file is faster than redirecting standard output to the same file.|
|/?|Displays help at the command prompt.|

## Remarks

-   Using the **/+** command-line option

    By default, comparisons start at the first character of each line. The **/+** command-line option starts comparisons at the character that is specified by *N*. For example, `/+3` indicates that each comparison should begin at the third character of each line. Lines with fewer than *N* characters collate before other lines.
-   Using the **/m** command-line option

    The memory used is always a minimum of 160 KB. If the memory size is specified, the exact specified amount is used for the sort (must be at least 160 KB), regardless of how much main memory is available.

    The default maximum memory size when no size is specified is 90 percent of the available main memory if both the input and output are files, or 45 percent of main memory otherwise. The default setting usually gives the best performance.
-   Using the **/l** command-line option

    Currently, the only alternative to the default locale is the "C" locale, which is faster than natural language sorting (it sorts characters according to their binary encodings).
-   Using redirection symbols with the **sort** command

    You can use the pipe symbol (**|**) to direct input data to the **sort** command from another command or to direct sorted output to another command. You can specify input and output files by using redirection symbols (**<** or **>**). It can be faster and more efficient (especially with large files) to specify the input file directly (as defined by *FileName1* in the command syntax), and then specify the output file using the **/o** parameter.
-   Case sensitivity

    The **sort** command does not distinguish between uppercase and lowercase letters.
-   Limits on file size

    The **sort** command has no limit on file size.
-   Collating sequence

    The sort program uses the collating-sequence table that corresponds to the Country/Region code and code-page settings. Characters greater than ASCII code 127 are sorted based on information in the Country.sys file or in an alternate file specified by the **country** command in your Config.nt file.
-   Memory usage

    If the sort fits within the maximum memory size (as set by default or as specified by the **/m** parameter), the sort is performed in a single pass. Otherwise, the sort is performed in two separate sort and merge passes, and the amounts of memory used for both passes are equal. When two passes are performed, the partially sorted data is stored in a temporary file on disk. If there is not enough memory to perform the sort in two passes, a run-time error is issued. If the **/m** command-line option is used to specify more memory than is truly available, performance degradation or a run-time error can occur.

## <a name="BKMK_examples"></a>Examples

**Sorting a file**

To sort and display in reverse order the lines in a file named Expenses.txt, type:

`sort /r expenses.txt`

**Sorting the output from a command**

To search a large file named Maillist.txt for the text "Jones," and to sort the results of the search, use the pipe (|) to direct the output of a **find** command to the **sort** command, as follows:

`find "Jones" maillist.txt | sort`

The command produces a sorted list of lines that contain the specified text.

**Sorting keyboard input**

To sort keyboard input and display the results alphabetically on the screen, you can first use the **sort** command with no parameters, as follows:

`sort`

Then type the text that you want sorted, and press ENTER at the end of each line. When you have finished typing text, press CTRL+Z, and then press ENTER. The **sort** command displays the text you typed, sorted alphabetically.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)