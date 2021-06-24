---
title: cd
description: Reference article for the cd command, which displays the name of or changes the current directory.
ms.topic: reference
ms.assetid: 932d9cc1-3dff-40da-835c-1cb0894874f1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# cd

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the name of the current directory or changes the current directory. If used with only a drive letter (for example, `cd C:`), **cd** displays the names of the current directory in the specified drive. If used without parameters, **cd** displays the current drive and directory.

> [!NOTE]
> This command is the same as the [chdir command](chdir.md).

## Syntax

```
cd [/d] [<drive>:][<path>]
cd [..]
chdir [/d] [<drive>:][<path>]
chdir [..]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /d | Changes the current drive as well as the current directory for a drive. |
| `<drive>:` | Specifies the drive to display or change (if different from the current drive). |
| `<path>` | Specifies the path to the directory that you want to display or change. |
| [..] | Specifies that you want to change to the parent folder. |
| /? | Displays help at the command prompt. |

## Remarks

If command extensions are enabled, the following conditions apply to the **cd** command:

- The current directory string is converted to use the same case as the names on the disk. For example, `cd c:\temp` would set the current directory to C:\Temp if that is the case on the disk.

- Spaces aren't treated as delimiters, so `<path>` can contain spaces without enclosing quotation marks. For example:

  ```
  cd username\programs\start menu
  ```

  is the same as:

  ```
  cd "username\programs\start menu"
  ```

  If extensions are disabled, the quotation marks are required.

- To disable command extensions, type:

  ```
  cmd /e:off
  ```

## Examples

To return to the root directory, the top of the directory hierarchy for a drive:

```
cd\
```

To change the default directory on a drive that is different from the one you are on:

```
cd [<drive>:[<directory>]]
```

To verify the change to the directory, type:

```
cd [<drive>:]
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [chdir command](chdir.md)
