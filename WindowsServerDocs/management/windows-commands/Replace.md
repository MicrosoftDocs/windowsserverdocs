---
title: replace
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6143661e-d90f-4812-b265-6669b567dd1f
---
# replace
replaces files. if used with the **\/a** option, **replace** adds new files to a directory instead of replacing existing files.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
replace [<Drive1>:][<path1>]<FileName> [<Drive2>:][<path2>] [/a] [/p] [/r] [/w] 
replace [<Drive1>:][<path1>]<FileName> [<Drive2>:][<path2>] [/p] [/r] [/s] [/w] [/u] 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[<Drive1>:\]\[<path1>\]<FileName>|Specifies the location and name of the source file or set of files. *FileName* is required, and can include wildcard characters \(**\*** and **?**\).|
|\[<Drive2>:\]\[<path2>\]|Specifies the location of the destination file. You cannot specify a file name for files you replace. if you do not specify a drive or path, **replace** uses the current drive and directory as the destination.|
|\/a|adds new files to the destination directory instead of replacing existing files. You cannot use this command\-line option with the **\/s** or **\/u** command\-line option.|
|\/p|prompts you for confirmation before replacing a destination file or adding a source file.|
|\/r|replaces Read\-only and unprotected files. if you attempt to replace a Read\-only file, but you do not specify **\/r**, an error results and stops the replacement operation.|
|\/w|Waits for you to insert a disk before the search for source files begins. if you do not specify **\/w**, **replace** begins replacing or adding files immediately after you press ENTER.|
|\/s|Searches all subdirectories in the destination directory and replaces matching files. You cannot use **\/s** with the **\/a** command\-line option. The **replace** command does not search subdirectories that are specified in *path1*.|
|\/u|replaces only those files on the destination directory that are older than those in the source directory. You cannot use **\/u** with the **\/a** command\-line option.|
|\/?|Displays help at the command prompt.|

## remarks

-   As **replace** adds or replaces files, the file names are displayed on the screen. After **replace** is finished, a summary line is displayed in one of the following formats:

    ```
    nnn files added
    nnn files replaced
    no file added
    no file replaced
    ```

-   if you are using floppy disks and you need to switch disks during the **replace** operation, you can specify the **\/w** command\-line option so that **replace** will wait for you to switch the disks.

-   You cannot use **replace** to update hidden files or system files.

-   The following table shows each exit code and a brief description of its meaning:

    |exit code|Description|
    |-------------|---------------|
    |0|The **replace** command successfully replaced or added the files.|
    |1|The **replace** command encountered an incorrect version of MS\-DOS.|
    |2|The **replace** command could not find the source files.|
    |3|The **replace** command could not find the source or destination path.|
    |5|The user does not have access to the files that you want to replace.|
    |8|There is insufficient system memory to carry out the command.|
    |11|The user used the wrong syntax on the command line.|

> [!NOTE]
> You can use the ERRORLEVEL parameter on the **if** command line in a batch program to process exit codes that are returned by **replace**.

## <a name="BKMK_examples"></a>Examples
To update all the versions of a file named Phones.cli \(which appear in multiple directories on drive C\), with the latest version of the Phones.cli file from a floppy disk in drive A, type:

`replace a:\phones.cli c:\ /s`

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


