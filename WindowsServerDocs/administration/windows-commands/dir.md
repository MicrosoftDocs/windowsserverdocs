---
title: dir
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: edcbf69b-eaa4-466e-b210-3dd8892f4d93
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# dir



Displays a list of a directory's files and subdirectories. If used without parameters, **dir** displays the disk's volume label and serial number, followed by a list of directories and files on the disk (including their names and the date and time each was last modified). For files, **dir** displays the name extension and the size in bytes. **Dir** also displays the total number of files and directories listed, their cumulative size, and the free space (in bytes) remaining on the disk.

For examples of how to use this command, see [Examples](#examples).

## Syntax

```
dir [<Drive>:][<Path>][<FileName>] [...] [/p] [/q] [/w] [/d] [/a[[:]<Attributes>]][/o[[:]<SortOrder>]] [/t[[:]<TimeField>]] [/s] [/b] [/l] [/n] [/x] [/c] [/4]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:][<Path>]|Specifies the drive and directory for which you want to see a listing.|
|[\<FileName>]|Specifies a particular file or group of files for which you want to see a listing.|
|/p|Displays one screen of the listing at a time. To see the next screen, press any key on the keyboard.|
|/q|Displays file ownership information.|
|/w|Displays the listing in wide format, with as many as five file names or directory names on each line.|
|/d|Displays the listing in the same format as **/w**, but the files are sorted by column.|
|/a[[:]\<Attributes>]|Displays only the names of those directories and files with the attributes that you specify. If you omit **/a**, **dir** displays the names of all files except hidden and system files. If you use **/a** without specifying *Attributes*, **dir** displays the names of all files, including hidden and system files.</br>The following list describes each of the values that you can use for *Attributes*. Using a colon (:) is optional. Use any combination of these values, and do not separate the values with spaces.</br>**d** Directories</br>**h** Hidden files</br>**s** System files</br>**l** Reparse points</br>**r** Read-only files</br>**a** Files ready for archiving</br>**i** Not content indexed files</br>**-** Prefix meaning "not"|
|/o[[:]\<SortOrder>]|Sorts the output according to *SortOrder*, which can be any combination of the following values:</br>**n** By name (alphabetical)</br>**e** By extension (alphabetical)</br>**g** Group directories first</br>**s** By size (smallest first)</br>**d** By date/time (oldest first)</br>**-** Prefix to reverse order</br>Note: Using a colon is optional. Multiple values are processed in the order in which you list them. Do not separate multiple values with spaces.</br>If *SortOrder* is not specified, **dir /o** lists the directories in alphabetic order, followed by the files, which are also sorted in alphabetic order.|
|/t[[:]\<TimeField>]|Specifies which time field to display or use for sorting. The following list describes each of the values you can use for *TimeField*:</br>**c** Creation</br>**a** Last access</br>**w** Last written|
|/s|Lists every occurrence of the specified file name within the specified directory and all subdirectories.|
|/b|Displays a bare list of directories and files, with no additional information. **/b** overrides **/w**.|
|/l|Displays unsorted directory names and file names in lowercase.|
|/n|Displays a long list format with file names on the far right of the screen.|
|/x|Displays the short names generated for non-8dot3 file names. The display is the same as the display for **/n**, but the short name is inserted before the long name.|
|/c|Displays the thousand separator in file sizes. This is the default behavior. Use **/-c** to hide separators.|
|/4|Displays years in four-digit format.|
|/?|Displays help at the command prompt.|

## Remarks

- To use multiple *FileName* parameters, separate each file name with a space, comma, or semicolon.
- You can use wildcard characters (**&#42;** or **?**), to represent one or more characters of a file name and to display a subset of files or subdirectories.

  **Asterisk (\*):** Use the asterisk as a substitute for any string of characters, for example:  
  - **dir \*.txt** lists all files in the current directory with extensions that begin with .txt, such as .txt, .txt1, .txt_old.
  - **dir read\*.txt** lists all files in the current directory that begin with "read" and with extensions that begin with .txt, such as .txt, .txt1, or .txt_old.
  - **dir read\*.\*** lists all files in the current directory that begin with "read" with any extension.

  The asterisk wildcard always uses short file name mapping, so you might get unexpected results. For example, the following directory contains two files (t.txt2 and t97.txt): 
 
  ```
  C:\test>dir /x
  Volume in drive C has no label.
  Volume Serial Number is B86A-EF32
    
  Directory of C:\test
    
  11/30/2004  01:40 PM <DIR>  .
  11/30/2004  01:40 PM <DIR> ..
  11/30/2004  11:05 AM 0 T97B4~1.TXT t.txt2
  11/30/2004  01:16 PM 0 t97.txt
  ```  

  You might expect that typing **dir t97\\*** would return the file t97.txt. However, typing **dir t97\\*** returns both files, because the asterisk wildcard matches the file t.txt2 to t97.txt by using its short name map T97B4~1.TXT. Similarly, typing **del t97\\*** would delete both files.

  **Question mark (?):** Use the question mark as a substitute for a single character in a name. For example, typing **dir read???.txt** lists any files in the current directory with the .txt extension that begin with "read" and are followed by up to three characters. This includes Read.txt, Read1.txt, Read12.txt, Read123.txt, and Readme1.txt, but not Readme12.txt.
- Specifying file display attributes

  If you use **/a** with more than one value in *Attributes*, **dir** displays the names of only those files with all the specified attributes. For example, if you use **/a** with **r** and **-h** as attributes (by using either **/a:r-h** or **/ar-h**), **dir** will only display the names of the read-only files that are not hidden.
- Specifying file name sorting

  If you specify more than one *SortOrder* value, **dir** sorts the file names by the first criterion, then by the second criterion, and so on. For example, if you use **/o** with the **e** and **-s** values for *SortOrder* (by using either **/o:e-s** or **/oe-s**), **dir** sorts the names of directories and files by extension, with the largest first, and then displays the final result. The alphabetic sorting by extension causes file names with no extensions to appear first, then directory names, and then file names with extensions.
- Using redirection symbols and pipes

  When you use the redirection symbol (**>**) to send **dir** output to a file or a pipe (**|**) to send **dir** output to another command, use **/a:-d** and **/b** to list the file names only. You can use *FileName* with **/b** and **/s** to specify that **dir** is to search the current directory and its subdirectories for all file names that match *FileName*. **Dir** lists only the drive letter, directory name, file name, and file name extension (one path per line), for each file name it finds. Before you use a pipe to send **dir** output to another command, you should set the TEMP environment variable in your Autoexec.nt file.
- The **dir** command, with different parameters, is available from the Recovery Console.

## Examples

To display all directories one after the other, in alphabetical order, in wide format, and pausing after each screen, make sure that the root directory is the current directory, and then type:

```
dir /s/w/o/p
```

**Dir** lists the root directory, the subdirectories, and the files in the root directory, including extensions. Then, **dir** lists the subdirectory names and file names in each subdirectory in the tree.

To alter the preceding example so that **dir** displays the file names and extensions, but omits the directory names, type:

```
dir /s/w/o/p/a:-d
```

To print a directory listing, type:

```
dir > prn
```

When you specify **prn**, the directory list is sent to the printer that is attached to the LPT1 port. If your printer is attached to a different port, you must replace **prn** with the name of the correct port.

You can also redirect output of the **dir** command to a file by replacing **prn** with a file name. You can also type a path. For example, to direct **dir** output to the file dir.doc in the Records directory, type:

```
dir > \records\dir.doc
```

If dir.doc does not exist, **dir** creates it, unless the Records directory does not exist. In that case, the following message appears:

`File creation error`

To display a list of all the file names with the .txt extension in all directories on drive C, type:

```
dir c:\*.txt /w/o/s/p
```

**Dir** displays, in wide format, an alphabetized list of the matching file names in each directory, and it pauses each time the screen fills until you press any key to continue.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
