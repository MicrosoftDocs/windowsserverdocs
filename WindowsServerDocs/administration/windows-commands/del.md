---
title: del
description: Reference article for the del command, which deletes one or more files.
ms.topic: reference
ms.assetid: 346eede2-2085-44f5-9936-6877b5d5a833
ms.author: jgerend
author: JasonGerend
ms.date: 6/22/2022
---

# del

Deletes one or more files. This command performs the same actions as the **erase** command.

The **del** command can also run from the Windows Recovery Console, using different parameters. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

> [!WARNING]
> If you use **del** to delete a file from your disk, you can't retrieve it.

## Syntax

```
del [/p] [/f] [/s] [/q] [/a[:]<attributes>] <names>
erase [/p] [/f] [/s] [/q] [/a[:]<attributes>] <names>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<names>` | Specifies a list of one or more files or directories. Wildcards may be used to delete multiple files. If a directory is specified, all files within the directory will be deleted. |
| /p | Prompts for confirmation before deleting the specified file. |
| /f | Forces deletion of read-only files. |
| /s | Deletes specified files from the current directory and all subdirectories. Displays the names of the files as they are being deleted. |
| /q | Specifies quiet mode. You are not prompted for delete confirmation. |
| /a[:]`<attributes>` | Deletes files based on the following file attributes:<ul><li>**r** Read-only files</li><li>**h** Hidden files</li><li>**i** Not content indexed files</li><li>**s** System files</li><li>**a** Files ready for archiving</li><li>**l** Reparse points</li><li>**-** Used as a prefix meaning 'not'</li></ul>. |
| /? | Displays help at the command prompt. |

#### Remarks

- If you use the `del /p` command, you'll see the following message:

    `FileName, Delete (Y/N)?`

    To confirm the deletion, press **Y**. To cancel the deletion and to display the next file name (if you specified a group of files), press **N**. To stop the **del** command, press CTRL+C.

- If you disable command extension, the **/s** parameter will display the names of any files that weren't found ,instead of displaying the names of files that are being deleted.

- If you specify specific folders in the `<names>` parameter, all of the included files will also be deleted. For example, if you want to delete all of the files in the *\work* folder, type:

  ```
  del \work
  ```

- You can use wildcards (**&#42;** and **?**) to delete more than one file at a time. However, to avoid deleting files unintentionally, you should use wildcards cautiously. For example, if you type the following command:

  ```
  del *.*
  ```

  The **del** command displays the following prompt:

  `Are you sure (Y/N)?`

  To delete all of the files in the current directory, press **Y** and then press ENTER. To cancel the deletion, press **N** and then press ENTER.

  > [!NOTE]
  > Before you use wildcard characters with the **del** command, use the same wildcard characters with the **dir** command to list all the files that will be deleted.

## Examples

To delete all the files in a folder named Test on drive C, type either of the following:

```
del c:\test
del c:\test\*.*
```

To delete all the files in a folder where the folder has a space in its name, the full path needs to be wrapped in double quotes. Type either of the following:

```
del "c:\test folder\"
del "c:\test folder\*.*"
```

To delete all files with the .bat file name extension from the current directory, type:

```
del *.bat
```

To delete all read-only files in the current directory, type:

```
del /a:r *.*
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
