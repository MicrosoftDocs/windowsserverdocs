---
title: erase
description: Reference article for the erase command, which deletes one or more files.
ms.topic: reference
ms.assetid: 024a4d0f-8679-4e06-b46f-61fdaf5464bc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# erase

Deletes one or more files. If you use **erase** to delete a file from your disk, you can't retrieve it.

> [!NOTE]
> This command is the same as the [del command](del.md).

## Syntax

```
erase [/p] [/f] [/s] [/q] [/a[:]<attributes>] <names>
del [/p] [/f] [/s] [/q] [/a[:]<attributes>] <names>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<names>` | Specifies a list of one or more files or directories. Wildcards may be used to delete multiple files. If a directory is specified, all files within the directory will be deleted. |
| /p | Prompts for confirmation before deleting the specified file. |
| /f | Forces deletion of read-only files. |
| /s | Deletes specified files from the current directory and all subdirectories. Displays the names of the files as they are being deleted. |
| /q | Specifies quiet mode. You are not prompted for delete confirmation. |
| /a[:]`<attributes>` | Deletes files based on the following file attributes:<ul><li>**r** Read-only files</li><li>**h** Hidden files</li><li>**i** Not content indexed files</li><li>**s** System files</li><li>**a** Files ready for archiving</li><li>**l** Reparse points</li><li>**-** Used as a prefix meaning 'not'</li></ul> |
| /? | Displays help at the command prompt. |

#### Remarks

- If you use the `erase /p` command, you'll see the following message:

    `FileName, Delete (Y/N)?`

    To confirm the deletion, press **Y**. To cancel the deletion and to display the next file name (if you specified a group of files), press **N**. To stop the **erase** command, press CTRL+C.

- If you disable command extension, the **/s** parameter will display the names of any files that weren't found ,instead of displaying the names of files that are being deleted.

- If you specify specific folders in the `<names>` parameter, all of the included files will also be deleted. For example, if you want to delete all of the files in the *\work* folder, type:

  ```
  erase \work
  ```

- You can use wildcards (**&#42;** and **?**) to delete more than one file at a time. However, to avoid deleting files unintentionally, you should use wildcards cautiously. For example, if you type the following command:

  ```
  erase *.*
  ```

  The **erase** command displays the following prompt:

  `Are you sure (Y/N)?`

  To delete all of the files in the current directory, press **Y** and then press ENTER. To cancel the deletion, press **N** and then press ENTER.

  > [!NOTE]
  > Before you use wildcard characters with the **erase** command, use the same wildcard characters with the **dir** command to list all the files that will be deleted.

### Examples

To delete all the files in a folder named Test on drive C, type either of the following:

```
erase c:\test
erase c:\test\*.*
```

To delete all files with the .bat file name extension from the current directory, type:

```
erase *.bat
```

To delete all read-only files in the current directory, type:

```
erase /a:r *.*
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [del command](del.md)
