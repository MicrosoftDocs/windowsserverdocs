---
title: copy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9624d4a1-349a-4693-ad00-1d1d4e59e9ac

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# copy



Copies one or more files from one location to another.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
copy [/d] [/v] [/n] [/y | /-y] [/z] [/a | /b] <Source> [/a | /b] [+<Source> [/a | /b] [+ ...]] [<Destination> [/a | /b]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/d|Allows the encrypted files being copied to be saved as decrypted files at the destination.|
|/v|Verifies that new files are written correctly.|
|/n|Uses a short file name, if available, when copying a file with a name longer than eight characters, or with a file name extension longer than three characters.|
|/y|Suppresses prompting to confirm that you want to overwrite an existing destination file.|
|/-y|Prompts you to confirm that you want to overwrite an existing destination file.|
|/z|Copies networked files in restartable mode.|
|/a|Indicates an ASCII text file.|
|/b|Indicates a binary file.|
|\<Source>|Required. Specifies the location from which you want to copy a file or set of files. *Source* can consist of a drive letter and colon, a directory name, a file name, or a combination of these.|
|\<Destination>|Required. Specifies the location to which you want to copy a file or set of files. *Destination* can consist of a drive letter and colon, a directory name, a file name, or a combination of these.|
|/?|Displays help at the command prompt.|

## Remarks

-   You can copy an ASCII text file that uses an end-of-file character (CTRL+Z) to indicate the end of the file.
-   Using **/a**

    When **/a** precedes or follows a list of files on the command line, it applies to all files listed until **copy** encounters **/b**. In this case, **/b** applies to the file preceding **/b**.

    The effect of **/a** depends on its position in the command-line string. When **/a** follows *Source*, **copy** treats the file as an ASCII file and copies data that precedes the first end-of-file character (CTRL+Z).

    When **/a** follows *Destination*, **copy** adds an end-of-file character (CTRL+Z) as the last character of the file.
-   Using **/b**

    **/b** directs the command interpreter to read the number of bytes specified by the file size in the directory. **/b** is the default value for **copy**, unless **copy** combines files.

    When **/b** precedes or follows a list of files on the command line, it applies to all listed files until **copy** encounters **/a**. In this case, **/a** applies to the file preceding **/a**.

    The effect of **/b** depends on its position in the command–line string. When **/b** follows *Source*, **copy** copies the entire file, including any end-of-file character (CTRL+Z).

    When **/b** follows *Destination*, **copy** does not add an end-of-file character (CTRL+Z).
-   Using **/v**

    If a write operation cannot be verified an error message appears. Although recording errors rarely occur with **copy**, you can use **/v** to verify that critical data has been correctly recorded. The **/v** command-line option also slows down the **copy** command, because each sector recorded on the disk must be checked.
-   Using **/y** and **/-y**

    If **/y** is preset in the COPYCMD environment variable, you can override this setting by using **/-y** at the command line. By default, you are prompted when you replace this setting, unless the **copy** command is executed in a batch script.
-   Appending files

    To append files, specify a single file for *Destination*, but multiple files for *Source* (use wildcard characters or *File1*+*File2*+*File3* format).
-   Using **/z**

    If the connection is lost during the copy phase (for example, if the server going offline breaks the connection), **copy /z** resumes after the connection is re-established. **/z** also displays the percentage of the copy operation that is completed for each file.
-   Copying to and from devices

    You can substitute a device name for one or more occurrences of *Source* or *Destination*.
-   Using or omitting **/b** when copying to a device

    When *Destination* is a device (for example, Com1 or Lpt1), **/b** copies data to the device in binary mode. In binary mode, **copy /b** copies all characters (including special characters such as CTRL+C, CTRL+S, CTRL+Z, and ENTER) to the device as data. However, if you omit **/b**, data is copied to the device in ASCII mode. In ASCII mode, special characters might cause files to combine during the copying process.
-   Using the default destination file

    If you do not specify a destination file, a copy is created with the same name, modified date, and modified time as the original file. The new copy is stored in the current directory on the current drive. If the source file is on the current drive and in the current directory and you do not specify a different drive or directory for the destination file, the **copy** command stops and displays the following error message:

    `File cannot be copied onto itself`

    `0 File(s) copied`
-   Combining files

    If you specify more than one file in *Source*, **copy** combines them all into a single file using the file name specified in *Destination*. **Copy** assumes the combined files are ASCII files unless you use the **/b** option.
-   Copying zero-length files

    **Copy** does not copy files that are 0 bytes long. Use **xcopy** to copy these files.
-   Changing the time and date of a file

    If you want to assign the current time and date to a file without modifying the file, use the following syntax:  
    ```
    copy /b <Source> +,,
    ```  
    The commas indicate the omission of the *Destination* parameter.
-   Copying files in subdirectories

    To copy all of a directory's files and subdirectories, use the **xcopy** command.
-   The **copy** command, with different parameters, is available from the Recovery Console.

## <a name="BKMK_examples"></a>Examples

To copy a file called Memo.doc to Letter.doc in the current drive and ensure that an end-of-file character (CTRL+Z) is at the end of the copied file, type:
```
copy memo.doc letter.doc /a
```
To copy a file named Robin.typ from the current drive and directory to an existing directory named Birds that is located on drive C, type:
```
copy robin.typ c:\birds
```
If the Birds directory does not exist, the file Robin.typ is copied into a file named Birds that is located in the root directory on the disk in drive C.

To combine Mar89.rpt, Apr89.rpt, and May89.rpt, which are located in the current directory, and place them in a file named Report (also in the current directory), type:
```
copy mar89.rpt + apr89.rpt + may89.rpt Report
```
When you combine files, **copy** marks the destination file with the current date and time. If you omit *Destination*, the files are combined and stored under the name of the first file in the list. For example, to combine all files in Report when a file named Report already exists, type:
```
copy report + mar89.rpt + apr89.rpt + may89.rpt
```
To combine all files in the current directory that have the.txt file name extension into a single file named Combined.doc, type:
```
copy *.txt Combined.doc 
```
If you want to combine several binary files into one file by using wildcard characters, include **/b**. This prevents Windows from treating CTRL+Z as an end-of-file character. For example, type:
```
copy /b *.exe Combined.exe
```

> [!CAUTION]
> If you combine binary files, the resulting file might be unusable due to internal formatting.

In the following example, **copy** combines each file that has a .txt extension with its corresponding .ref file. The result is a file with the same file name but with a .doc extension. **Copy** combines File1.txt with File1.ref to form File1.doc, and then **copy** combines File2.txt with File2.ref to form File2.doc, and so on. For example, type:
```
copy *.txt + *.ref *.doc
```
To combine all files with the .txt extension, and then combine all files with the .ref extension into one file named Combined.doc, type:
```
copy *.txt + *.ref Combined.doc
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)