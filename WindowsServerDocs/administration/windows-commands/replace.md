---
title: replace
description: Reference article for the replace command, which can replace existing or add new files to a directory.
ms.topic: reference
ms.assetid: 6143661e-d90f-4812-b265-6669b567dd1f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# replace

Replace existing files in a directory. If used with the **/a** option, this command adds new files to a directory instead of replacing existing files.

## Syntax

```
replace [<drive1>:][<path1>]<filename> [<drive2>:][<path2>] [/a] [/p] [/r] [/w]
replace [<drive1>:][<path1>]<filename> [<drive2>:][<path2>] [/p] [/r] [/s] [/w] [/u]
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive1>:][<path1>]<filename>` | Specifies the location and name of the source file or set of files. The *filename* option is required, and can include wildcard characters (**&#42;** and **?**). |
| `[<drive2>:][<path2>]` | Specifies the location of the destination file. You can't specify a file name for files you replace. If you don't specify a drive or path, this command uses the current drive and directory as the destination. |
| /a | Adds new files to the destination directory instead of replacing existing files. You can't use this command-line option with the **/s** or **/u** command-line option. |
| /p | Prompts you for confirmation before replacing a destination file or adding a source file. |
| /r | Replaces Read-only and unprotected files. If you attempt to replace a Read-only file, but you don't specify **/r**, an error results and stops the replacement operation. |
| /w | Waits for you to insert a disk before the search for source files begins. If you don't specify **/w**, this command begins replacing or adding files immediately after you press ENTER. |
| /s | Searches all subdirectories in the destination directory and replaces matching files. You can't use **/s** with the **/a** command-line option. The command doesn't search subdirectories that are specified in *Path1*. |
| /u | Replaces only those files on the destination directory that are older than those in the source directory. You can't use **/u** with the **/a** command-line option. |
| /? | Displays help at the command prompt. |

#### Remarks

- As this command adds or replaces files, the file names appear on the screen. After this command is done, a summary line is displayed in one of the following formats:

  ```
  nnn files added
  nnn files replaced
  no file added
  no file replaced
  ```

- If you're using floppy disks and you need to switch disks while running this command, you can specify the **/w** command-line option so that this command waits for you to switch the disks.

- You can't use this command to update hidden files or system files.

- The following table shows each exit code and a brief description of its meaning:

  | Exit code | Description |
  |--|--|
  | 0 | This command successfully replaced or added the files. |
  | 1 | This command encountered an incorrect version of MS-DOS. |
  | 2 | This command couldn't find the source files. |
  | 3 | This command couldn't find the source or destination path. |
  | 5 | The user doesn't have access to the files that you want to replace. |
  | 8 | There is insufficient system memory to carry out the command. |
  | 11 | The user used the wrong syntax on the command line. |

> [!NOTE]
> You can use the ERRORLEVEL parameter on the **if** command line in a batch program to process exit codes that are returned by this command.

## Examples

To update all the versions of a file named *Phones.cli* (which appear in multiple directories on drive C:), with the latest version of the *Phones.cli* file from a floppy disk in drive A:, type:

```
replace a:\phones.cli c:\ /s
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
