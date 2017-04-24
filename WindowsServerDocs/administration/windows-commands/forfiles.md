---
title: forfiles
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 43f6b004-446d-4fdd-91c5-5653613524a4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# forfiles

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

selects and executes a command on a file or set of files. This command is useful for batch processing.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
forfiles [/p <path>] [/m <Searchmask>] [/s] [/c "<Command>"] [/d [{+|-}][{<date>|<Days>}]]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/p <path>|Specifies the path from which to start the search. By default, searching starts in the current working directory.|
|/m <Searchmask>|Searches files according to the specified search mask. The default search mask is **\*.\***.|
|/s|Instructs the **forfiles** command to search into subdirectories recursively.|
|/c "<Command>"|Runs the specified command on each file. Command strings should be enclosed in quotation marks. The default command is **"cmd /c echo @file"**.|
|/d [{+&#124;-}][{<date>&#124;<Days>}]|selects files with a last modified date within the specified time frame.<br /><br />-   selects files with a last modified date later than or equal to (**+**) or earlier than or equal to (**-**) the specified date, where *date* is in the format MM/DD/YYYY.<br />-   selects files with a last modified date later than or equal to (**+**) the current date plus the number of days specified, or earlier than or equal to (**-**) the current date minus the number of days specified.<br />-   Valid values for *Days* include any number in the range 0 32,768. If no sign is specified, **+** is used by default.|
|/?|Displays help at the command prompt.|
## remarks
-   **forfiles** is most commonly used in batch files.
-   **forfiles /s** is similar to **dir /s.**
-   You can use the following variables in the command string as specified by the **/c** command-line option.
    |Variable|Description|
    |------|--------|
    |@FILE|File name.|
    |@FNAME|File name without extension.|
    |@EXT|File name extension.|
    |@path|Full path of the file.|
    |@RELpath|Relative path of the file.|
    |@ISdir|Evaluates to TRUE if a file type is a directory. Otherwise, this variable evaluates to FALSE.|
    |@FSIZE|File size, in bytes.|
    |@Fdate|Last modified date stamp on the file.|
    |@Ftime|Last modified time stamp on the file.|
-   With **forfiles**, you can run a command on or pass arguments to multiple files. For example, you could run the **type** command on all files in a tree with the .txt file name extension. Or you could execute every batch file (*.bat) on drive C, with the file name "Myinput.txt" as the first argument.
-   With **forfiles**, you can do any of the following:
    -   select files by an absolute date or a relative date by using the **/d** parameter.
    -   Build an archive tree of files by using variables such as @FSIZEand @Fdate.
    -   Differentiate files from directories by using the @ISdirvariable.
    -   Include special characters in the command line by using the hexadecimal code for the character, in 0x*HH* format (for example, 0x09 for a tab).
-   **forfiles** works by implementing the **recurse subdirectories** flag on tools that are designed to process only a single file.
## <a name="BKMK_examples"></a>Examples
To list all of the batch files on drive C, type:
```
forfiles /p c:\ /s /m *.bat /c "cmd /c echo @file is a batch file"
```
To list all of the directories on drive C, type:
```
forfiles /p c:\ /s /m *.* /c "cmd /c if @isdir==true echo @file is a directory"
```
To list all of the files in the current directory that are at least one year old, type:
```
forfiles /s /m *.* /d -365 /c "cmd /c echo @file is at least one year old."
```
To display the text "*File* is outdated" for each of the files in the current directory that are older than January 1, 2007, type:
```
forfiles /s /m *.* /d -01/01/2007 /c "cmd /c echo @file is outdated." 
```
To list the file name extensions of all the files in the current directory in column format, and add a tab before the extension, type:
```
forfiles /s /m *.* /c "cmd /c echo The extension of @file is 0x09@ext" 
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
