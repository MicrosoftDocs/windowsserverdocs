---
title: dir
description: Reference article for the dir command, which displays a list of a directory's files and subdirectories.
ms.topic: reference
ms.assetid: edcbf69b-eaa4-466e-b210-3dd8892f4d93
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# dir

Displays a list of a directory's files and subdirectories. If used without parameters, this command displays the disk's volume label and serial number, followed by a list of directories and files on the disk (including their names and the date and time each was last modified). For files, this command displays the name extension and the size in bytes. This command also displays the total number of files and directories listed, their cumulative size, and the free space (in bytes) remaining on the disk.

The **dir** command can also run from the Windows Recovery Console, using different parameters. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
dir [<drive>:][<path>][<filename>] [...] [/p] [/q] [/w] [/d] [/a[[:]<attributes>]][/o[[:]<sortorder>]] [/t[[:]<timefield>]] [/s] [/b] [/l] [/n] [/x] [/c] [/4] [/r]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[<drive>:][<path>]` | Specifies the drive and directory for which you want to see a listing. |
| `[<filename>]` | Specifies a particular file or group of files for which you want to see a listing. |
| /p | Displays one screen of the listing at a time. To see the next screen, press any key. |
| /q | Displays file ownership information. |
| /w | Displays the listing in wide format, with as many as five file names or directory names on each line. |
| /d | Displays the listing in the same format as **/w**, but the files are sorted by column. |
| /a[[:]`<attributes>`] | Displays only the names of those directories and files with your specified attributes. If you don't use this parameter, the command displays the names of all files except hidden and system files. If you use this parameter without specifying any *attributes*, the command displays the names of all files, including hidden and system files. The list of possible *attributes* values are:<ul><li>**d** - Directories</li><li>**h** - Hidden files</li><li>**s** - System files</li><li>**l** - Reparse points</li><li>**r** - Read-only files</li><li>**a** - Files ready for archiving</li><li>**i** - Not content indexed files</li></ul>You can use any combination of these values, but don't separate your values using spaces. Optionally you can use a colon (:) separator, or you can use a hyphen (-) as a prefix to mean, "not". For example, using the **-s** attribute won't show the system files. |
| /o[[:]`<sortorder>`] | Sorts the output according to *sortorder*, which can be any combination of the following values:<ul><li>**n** - Alphabetically by name</li><li>**e** - Alphabetically by extension</li><li>**g** - Group directories first</li><li>**s** - By size, smallest first</li><li>**d** - By date/time, oldest first</li><li>Use the **-** prefix to reverse the sort order</li></ul>Multiple values are processed in the order in which you list them. Don't separate multiple values with spaces, but you can optionally use a colon (:).<p>If *sortorder* isn't specified, **dir /o** lists the directories alphabetically, followed by the files, which are also sorted alphabetically. |
| /t[[:]`<timefield>`] | Specifies which time field to display or to use for sorting. The available *timefield* values are:<ul><li>**c** - Creation</li><li>**a** - Last accessed</li><li>**w** - Last written</li></ul> |
| /s | Lists every occurrence of the specified file name within the specified directory and all subdirectories. |
| /b | Displays a bare list of directories and files, with no additional information. The **/b** parameter overrides **/w**. |
| /l | Displays unsorted directory names and file names, using lowercase. |
| /n | Displays a long list format with file names on the far right of the screen. |
| /x | Displays the short names generated for non-8dot3 file names. The display is the same as the display for **/n**, but the short name is inserted before the long name. |
| /c | Displays the thousand separator in file sizes. This is the default behavior. Use **/-c** to hide separators. |
| /4 | Displays years in four-digit format. |
| /r | Display alternate data streams of the file. |
| /? | Displays help at the command prompt. |

#### Remarks

- To use multiple *filename* parameters, separate each file name with a space, comma, or semicolon.

- You can use wildcard characters (**&#42;** or **?**), to represent one or more characters of a file name and to display a subset of files or subdirectories.

- You can use the wildcard character, **&#42;**, to substitute for any string of characters, for example:

  - `dir *.txt` lists all files in the current directory with extensions that begin with .txt, such as .txt, .txt1, .txt_old.

  - `dir read *.txt` lists all files in the current directory that begin with read and with extensions that begin with .txt, such as .txt, .txt1, or .txt_old.

  - `dir read *.*` lists all files in the current directory that begin with read with any extension.

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

  You might expect that typing `dir t97\*` would return the file t97.txt. However, typing `dir t97\*` returns both files, because the asterisk wildcard matches the file t.txt2 to t97.txt by using its short name map *T97B4~1.TXT*. Similarly, typing `del t97\*` would delete both files.

- You can use the question mark (?) as a substitute for a single character in a name. For example, typing `dir read???.txt` lists any files in the current directory with the .txt extension that begin with read and are followed by up to three characters. This includes Read.txt, Read1.txt, Read12.txt, Read123.txt, and Readme1.txt, but not Readme12.txt.

- If you use **/a** with more than one value in *attributes*, this command displays the names of only those files with all the specified attributes. For example, if you use **/a** with **r** and **-h** as attributes (by using either `/a:r-h` or `/ar-h`), this command will only display the names of the read-only files that aren't hidden.

- If you specify more than one *sortorder* value, this command sorts the file names by the first criterion, then by the second criterion, and so on. For example, if you use **/o** with the **e** and **-s** parameters for *sortorder* (by using either `/o:e-s` or `/oe-s`), this command sorts the names of directories and files by extension, with the largest first, and then displays the final result. The alphabetic sorting by extension causes file names with no extensions to appear first, then directory names, and then file names with extensions.

- If you use the redirection symbol (`>`) to send this command's output to a file, or if you use a pipe (`|`) to send this command's output to another command, you must use `/a:-d` and **/b** to only list the file names. You can use *filename* with **/b** and **/s** to specify that this command is to search the current directory and its subdirectories for all file names that match *filename*. This command lists only the drive letter, directory name, file name, and file name extension (one path per line), for each file name it finds. Before you use a pipe to send this command's output to another command, you should set the *TEMP* environment variable in your Autoexec.nt file.

## Examples

To display all directories one after the other, in alphabetical order, in wide format, and pausing after each screen, make sure that the root directory is the current directory, and then type:

```
dir /s/w/o/p
```

The output lists the root directory, the subdirectories, and the files in the root directory, including extensions. This command also lists the subdirectory names and the file names in each subdirectory in the tree.

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

If dir.doc does not exist, **dir** creates it, unless the **Records** directory does not exist. In that case, the following message appears:

```
File creation error
```

To display a list of all the file names with the .txt extension in all directories on drive C, type:

```
dir c:\*.txt /w/o/s/p
```

The **dir** command displays, in wide format, an alphabetized list of the matching file names in each directory, and it pauses each time the screen fills until you press any key to continue.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
