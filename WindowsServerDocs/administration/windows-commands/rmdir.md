---
title: rmdir
description: Reference article for the rmdir command, which deletes a directory.
ms.topic: reference
ms.assetid: e4d7162b-7132-413c-a416-6eb3dc032a26
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# rmdir

Deletes a directory.

The **rmdir** command can also run from the Windows Recovery Console, using different parameters. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

> [!NOTE]
> This command is the same as the [rd command](rd.md).

## Syntax

```
rmdir [<drive>:]<path> [/s [/q]]
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:]<path>` | Specifies the location and the name of the directory that you want to delete. *Path* is required. If you include a backslash (\) at the beginning of the specified *path*, then the *path* starts at the root directory (regardless of the current directory). |
| /s | Deletes a directory tree (the specified directory and all its subdirectories, including all files). |
| /q | Specifies quiet mode. Does not prompt for confirmation when deleting a directory tree. The **/q** parameter works only if **/s** is also specified.<p>**CAUTION:** When you run in quiet mode, the entire directory tree is deleted without confirmation. Make sure that important files are moved or backed up before using the **/q** command-line option. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can't delete a directory that contains files, including hidden or system files. If you attempt to do so, the following message appears:

    `The directory is not empty`

    Use the **dir /a** command to list all files (including hidden and system files). Then use the **attrib** command with **-h** to remove hidden file attributes, **-s** to remove system file attributes, or **-h -s** to remove both hidden and system file attributes. After the hidden and file attributes have been removed, you can delete the files.

- You can't use the **rmdir** command to delete the current directory. If you attempt to delete the current directory, the following error message appears:

    `The process can't access the file because it is being used by another process.`

    If you receive this error message, you must change to a different directory (not a subdirectory of the current directory), and then try again.

## Examples

To change to the parent directory so you can safely remove the desired directory, type:

```
cd ..
```

To remove a directory named *test* (and all its subdirectories and files) from the current directory, type:

```
rmdir /s test
```

To run the previous example in quiet mode, type:

```
rmdir /s /q test
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
