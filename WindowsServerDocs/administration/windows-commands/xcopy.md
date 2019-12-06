---
title: xcopy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 76a310d7-9925-4571-a252-0e28960d5f89
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 01/05/2019
---
# xcopy

Copies files and directories, including subdirectories.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
Xcopy <Source> [<Destination>] [/w] [/p] [/c] [/v] [/q] [/f] [/l] [/g] [/d [:MM-DD-YYYY]] [/u] [/i] [/s [/e]] [/t] [/k] [/r] [/h] [{/a | /m}] [/n] [/o] [/x] [/exclude:FileName1[+[FileName2]][+[FileName3]] [{/y | /-y}] [/z] [/b] [/j]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Source>|Required. Specifies the location and names of the files you want to copy. This parameter must include either a drive or a path.|
|[\<Destination>]|Specifies the destination of the files you want to copy. This parameter can include a drive letter and colon, a directory name, a file name, or a combination of these.|
|/w|Displays the following message and waits for your response before starting to copy files:</br>**Press any key to begin copying file(s)**|
|/p|Prompts you to confirm whether you want to create each destination file.|
|/c|Ignores errors.|
|/v|Verifies each file as it is written to the destination file to make sure that the destination files are identical to the source files.|
|/q|Suppresses the display of **xcopy** messages.|
|/f|Displays source and destination file names while copying.|
|/l|Displays a list of files that are to be copied.|
|/g|Creates decrypted *Destination* files when the destination does not support encryption.|
|/d [:MM-DD-YYYY]|Copies source files changed on or after the specified date only. If you do not include a *MM-DD-YYYY* value, **xcopy** copies all *Source* files that are newer than existing *Destination* files. This command-line option allows you to update files that have changed.|
|/u|Copies files from *Source* that exist on *Destination* only.|
|/i|If *Source* is a directory or contains wildcards and *Destination* does not exist, **xcopy** assumes *Destination* specifies a directory name and creates a new directory. Then, **xcopy** copies all specified files into the new directory. By default, **xcopy** prompts you to specify whether *Destination* is a file or a directory.|
|/s|Copies directories and subdirectories, unless they are empty. If you omit **/s**, **xcopy** works within a single directory.|
|/e|Copies all subdirectories, even if they are empty. Use **/e** with the **/s** and **/t** command-line options.|
|/t|Copies the subdirectory structure (that is, the tree) only, not files. To copy empty directories, you must include the **/e** command-line option.|
|/k|Copies files and retains the read-only attribute on *Destination* files if present on the *Source* files. By default, **xcopy** removes the read-only attribute.|
|/r|Copies read-only files.|
|/h|Copies files with hidden and system file attributes. By default, **xcopy** does not copy hidden or system files|
|/a|Copies only *Source* files that have their archive file attributes set. **/a** does not modify the archive file attribute of the source file. For information about how to set the archive file attribute by using **attrib**, see [Additional references](#additional-references).|
|/m|Copies *Source* files that have their archive file attributes set. Unlike **/a**, **/m** turns off archive file attributes in the files that are specified in the source. For information about how to set the archive file attribute by using **attrib**, see [Additional references](#additional-references).|
|/n|Creates copies by using the NTFS short file or directory names. **/n** is required when you copy files or directories from an NTFS volume to a FAT volume or when the FAT file system naming convention (that is, 8.3 characters) is required on the *Destination* file system. The *Destination* file system can be FAT or NTFS.|
|/o|Copies file ownership and discretionary access control list (DACL) information.|
|/x|Copies file audit settings and system access control list (SACL) information (implies **/o**).|
|/exclude:FileName1[+[FileName2][+[FileName3]( \)]|Specifies a list of files. At least one file must be specified. Each file will contain search strings with each string on a separate line in the file.</br>When any of the strings match any part of the absolute path of the file to be copied, that file will be excluded from being copied. For example, specifying the string **obj** will exclude all files underneath the directory **obj** or all files with the **.obj** extension.|
|/y|Suppresses prompting to confirm that you want to overwrite an existing destination file.|
|/-y|Prompts to confirm that you want to overwrite an existing destination file.|
|/z|Copies over a network in restartable mode.|
|/b|Copies the symbolic link instead of the files. This parameter was introduced in Windows Vista®.|
|/j|Copies files without buffering. Recommended for very large files. This parameter was added in Windows Server 2008 R2.|
|/?|Displays help at the command prompt.|

## Remarks

- Using **/z**

  If you lose your connection during the copy phase (for example, if the server going offline severs the connection), it resumes after you reestablish the connection. **/z** also displays the percentage of the copy operation completed for each file.

- Using **/y** in the COPYCMD environment variable.

  You can use **/y** in the COPYCMD environment variable. You can override this command by using **/-y** on the command line. By default, you are prompted to overwrite.

- Copying encrypted files

  Copying encrypted files to a volume that does not support EFS results in an error. Decrypt the files first or copy the files to a volume that does support EFS.

- Appending files

  To append files, specify a single file for destination, but multiple files for source (that is, by using wildcards or file1+file2+file3 format).

- Default value for *Destination*

  If you omit *Destination*, the **xcopy** command copies the files to the current directory.

- Specifying whether *Destination* is a file or directory

  If *Destination* does not contain an existing directory and does not end with a backslash (\), the following message appears:
  
  ```
  Does <Destination> specify a file name or directory name on the target(F = file, D = directory)?
  ```  
  
Press F if you want the file or files to be copied to a file. Press D if you want the file or files to be copied to a directory.

  You can suppress this message by using the **/i** command-line option, which causes **xcopy** to assume that the destination is a directory if the source is more than one file or a directory.
- Using the **xcopy** command to set archive attribute for *Destination* files

  The **xcopy** command creates files with the archive attribute set, whether or not this attribute was set in the source file. For more information about file attributes and **attrib**, see [Additional references](#additional-references).

- Comparing **xcopy** and **diskcopy**

  If you have a disk that contains files in subdirectories and you want to copy it to a disk that has a different format, use the **xcopy** command instead of **diskcopy**. Because the **diskcopy** command copies disks track by track, your source and destination disks must have the same format. The **xcopy** command does not have this requirement. Use **xcopy** unless you need a complete disk image copy.

- Exit codes for **xcopy**

  To process exit codes returned by **xcopy**, use the **ErrorLevel** parameter on the **if** command line in a batch program. For an example of a batch program that processes exit codes using **if**, see [Additional references](#additional-references). The following table lists each exit code and a description.  

  |Exit code|Description|
  |---------|-----------|
  |0|Files were copied without error.|
  |1|No files were found to copy.|
  |2|The user pressed CTRL+C to terminate **xcopy**.|
  |4|Initialization error occurred. There is not enough memory or disk space, or you entered an invalid drive name or invalid syntax on the command line.|
  |5|Disk write error occurred.|

## Examples

**1.** To copy all the files and subdirectories (including any empty subdirectories) from drive A to drive B, type:

```
xcopy a: b: /s /e 
```

**2.** To include any system or hidden files in the previous example, add the<strong>/h</strong> command-line option as follows:

```
xcopy a: b: /s /e /h
```

**3.** To update files in the \Reports directory with the files in the \Rawdata directory that have changed since December 29, 1993, type:

```
xcopy \rawdata \reports /d:12-29-1993
```

**4.** To update all the files that exist in \Reports in the previous example, regardless of date, type:

```
xcopy \rawdata \reports /u
```

**5.** To obtain a list of the files to be copied by the previous command (that is, without actually copying the files), type:

```
xcopy \rawdata \reports /d:12-29-1993 /l > xcopy.out
```

The file xcopy.out lists every file that is to be copied.

**6.** To copy the \Customer directory and all subdirectories to the directory \\\\Public\Address on network drive H:, retain the read-only attribute, and be prompted when a new file is created on H:, type:

```
xcopy \customer h:\public\address /s /e /k /p
```

**7.** To issue the previous command, ensure that **xcopy** creates the \Address directory if it does not exist, and suppress the message that appears when you create a new directory, add the **/i** command-line option as follows:

```
xcopy \customer h:\public\address /s /e /k /p /i
```

**8.** You can create a batch program to perform **xcopy** operations and use the batch **if** command to process the exit code if an error occurs. For example, the following batch program uses replaceable parameters for the **xcopy** source and destination parameters:

```
@echo off
rem COPYIT.BAT transfers all files in all subdirectories of
rem the source drive or directory (%1) to the destination
rem drive or directory (%2)
xcopy %1 %2 /s /e
if errorlevel 4 goto lowmemory
if errorlevel 2 goto abort
if errorlevel 0 goto exit
:lowmemory
echo Insufficient memory to copy files or
echo invalid drive or command-line syntax.
goto exit
:abort
echo You pressed CTRL+C to end the copy operation.
goto exit
:exit 
```

To use the preceding batch program to copy all files in the C:\Prgmcode directory and its subdirectories to drive B, type:

```
copyit c:\prgmcode b:
```

The command interpreter substitutes **C:\Prgmcode** for *%1* and **B:** for *%2*, then uses **xcopy** with the **/e** and **/s** command-line options. If **xcopy** encounters an error, the batch program reads the exit code and goes to the label indicated in the appropriate **IF ERRORLEVEL** statement, then displays the appropriate message and exits from the batch program.

**9.** This example all the non-empty directories, plus files whose name match the pattern given with the asterisk symbol.

```
xcopy .\toc*.yml ..\..\Copy-To\ /S /Y

rem Output example.
rem  .\d1\toc.yml
rem  .\d1\d12\toc.yml
rem  .\d2\toc.yml
rem  3 File(s) copied
```

In the preceding example, this particular source parameter value **.\\toc\*.yml** copy the same 3 files even if its two path characters **.\\** were removed. However, no files would be copied if the asterisk wildcard was removed from the source parameter, making it just **.\\toc.yml**.

#### Additional references

-   [Copy](copy.md)
-   [Move](move.md)
-   [Dir](dir.md)
-   [Attrib](attrib.md)
-   [Diskcopy](diskcopy.md)
-   [If](if.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
