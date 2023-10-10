---
title: copy
description: Reference article for the copy command, which copies one or more files from one location to another.
ms.topic: reference
ms.assetid: 9624d4a1-349a-4693-ad00-1d1d4e59e9ac
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# copy

Copies one or more files from one location to another.

> [!NOTE]
> You can also use the **copy** command, with different parameters, from the Recovery Console. For more information about the recovery console, see [Windows Recovery Environment (Windows RE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
copy [/d] [/v] [/n] [/y | /-y] [/z] [/a | /b] <source> [/a | /b] [+<source> [/a | /b] [+ ...]] [<destination> [/a | /b]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /d | Allows the encrypted files being copied to be saved as decrypted files at the destination. |
| /v | Verifies that new files are written correctly. |
| /n | Uses a short file name, if available, when copying a file with a name longer than eight characters, or with a file name extension longer than three characters. |
| /y | Suppresses prompting to confirm that you want to overwrite an existing destination file. |
| /-y | Prompts you to confirm that you want to overwrite an existing destination file. |
| /z | Copies networked files in restartable mode. |
| /a | Indicates an ASCII text file. |
| /b | Indicates a binary file. |
| `<source>` | Required. Specifies the location from which you want to copy a file or set of files. *Source* can consist of a drive letter and colon, a directory name, a file name, or a combination of these. |
| `<destination>` | Required. Specifies the location to which you want to copy a file or set of files. *Destination* can consist of a drive letter and colon, a directory name, a file name, or a combination of these. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can copy an ASCII text file that uses an end-of-file character (CTRL+Z) to indicate the end of the file.

- If **/a** precedes or follows a list of files on the command line, it applies to all files listed until **copy** encounters **/b**. In this case, **/b** applies to the file preceding **/b**.

    The effect of **/a** depends on its position in the command-line string:
      - If **/a** follows *source*, the **copy** command treats the file as an ASCII file and copies data that precedes the first end-of-file character (CTRL+Z).
      - If **/a** follows *destination*, the **copy** command adds an end-of-file character (CTRL+Z) as the last character of the file.

- If **/b** directs the command interpreter to read the number of bytes specified by the file size in the directory. **/b** is the default value for **copy**, unless **copy** combines files.

- If **/b** precedes or follows a list of files on the command line, it applies to all listed files until **copy** encounters **/a**. In this case, **/a** applies to the file preceding **/a**.

    The effect of **/b** depends on its position in the command–line string:
        - If **/b** follows *source*, the **copy** command copies the entire file, including any end-of-file character (CTRL+Z).
        - If **/b** follows *destination*, the **copy** command doesn't add an end-of-file character (CTRL+Z).

- If a write operation cannot be verified, an error message appears. Although recording errors rarely occur with the **copy** command , you can use **/v** to verify that critical data has been correctly recorded. The **/v** command-line option also slows down the **copy** command, because each sector recorded on the disk must be checked.

- If **/y** is preset in the **COPYCMD** environment variable, you can override this setting by using **/-y** at the command line. By default, you are prompted when you replace this setting, unless the **copy** command is executed in a batch script.

- To append files, specify a single file for *destination*, but multiple files for *source* (use wildcard characters or *file1*+*file2*+*file3* format).

- If the connection is lost during the copy phase (for example, if the server going offline breaks the connection), you can use **copy /z** to resume after the connection is re-established. The **/z** option also displays the percentage of the copy operation that is completed for each file.

- You can substitute a device name for one or more occurrences of *source* or *destination*.

- If *destination* is a device (for example, Com1 or Lpt1), the **/b** option copies data to the device in binary mode. In binary mode, **copy /b** copies all characters (including special characters such as CTRL+C, CTRL+S, CTRL+Z, and ENTER) to the device, as data. However, if you omit **/b**, the data is copied to the device in ASCII mode. In ASCII mode, special characters might cause files to combine during the copying process.

- If you don't specify a destination file, a copy is created with the same name, modified date, and modified time as the original file. The new copy is stored in the current directory on the current drive. If the source file is on the current drive and in the current directory and you do not specify a different drive or directory for the destination file, the **copy** command stops and displays the following error message:

    ```
    File cannot be copied onto itself
    0 File(s) copied
    ```

- If you specify more than one file in *source*, the **copy** command combines them all into a single file using the file name specified in *destination*. The **copy** command assumes the combined files are ASCII files unless you use the **/b** option.

- To copy files that are 0 bytes long, or to copy all of a directory's files and subdirectories, use the [xcopy command](xcopy.md).

- To assign the current time and date to a file without modifying the file, use the following syntax:

    ```
    copy /b <source> +,,
    ```

    Where the commas indicate that the *destination* parameter has been intentionally left out.

## Examples

To copy a file called *memo.doc* to *letter.doc* in the current drive and ensure that an end-of-file character (CTRL+Z) is at the end of the copied file, type:

```
copy memo.doc letter.doc /a
```

To copy a file named *robin.typ* from the current drive and directory to an existing directory named *Birds* that is located on drive C, type:

```
copy robin.typ c:\birds
```

> [!NOTE]
> If the *Birds* directory doesn't exist, the file *robin.typ* is copied into a file named *Birds* that is located in the root directory on the disk in drive C.

To combine *Mar89.rpt*, *Apr89.rpt*, and *May89.rpt*, which are located in the current directory, and place them in a file named *Report* (also in the current directory), type:

```
copy mar89.rpt + apr89.rpt + may89.rpt Report
```

> [!NOTE]
> If you combine files, the **copy** command marks the destination file with the current date and time. If you omit *destination*, the files are combined and stored under the name of the first file in the list.

To combine all files in *Report*, when a file named *Report* already exists, type:

```
copy report + mar89.rpt + apr89.rpt + may89.rpt
```

To combine all files in the current directory that have the .txt file name extension into a single file named *Combined.doc*, type:

```
copy *.txt Combined.doc
```

To combine several binary files into one file by using wildcard characters, include **/b**. This prevents Windows from treating CTRL+Z as an end-of-file character. For example, type:

```
copy /b *.exe Combined.exe
```

> [!CAUTION]
> If you combine binary files, the resulting file might be unusable due to internal formatting.

- Combining each file that has a .txt extension with its corresponding .ref file creates a file with the same file name, but with a .doc extension. The **Copy** command combines *file1.txt* with *file1.ref* to form *file1.doc*, and then the command combines *file2.txt* with *file2.ref* to form *file2.doc*, and so on. For example, type:

```
copy *.txt + *.ref *.doc
```

To combine all files with the .txt extension, and then to combine all files with the .ref extension into one file named *Combined.doc*, type:

```
copy *.txt + *.ref Combined.doc
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [xcopy command](xcopy.md)
