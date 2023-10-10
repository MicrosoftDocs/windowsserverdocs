---
title: shrink
description: Reference article for the DiskPart shrink command, which reduces the size of the selected volume by the amount you specify.
ms.topic: reference
ms.assetid: ec87cc7c-9846-465e-a10d-4ee10db4f4e6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# shrink

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Diskpart shrink command reduces the size of the selected volume by the amount you specify. This command makes free disk space available from the unused space at the end of the volume.

A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.

> [!NOTE]
> This command works on basic volumes, and on simple or spanned dynamic volumes. It doesn't work on original equipment manufacturer (OEM) partitions, Extensible Firmware Interface (EFI) system partitions, or recovery partitions.

## Syntax

```
shrink [desired=<n>] [minimum=<n>] [nowait] [noerr]
shrink querymax [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| desired=`<n>` | Specifies the desired amount of space in megabytes (MB) to reduce the size of the volume by. |
| minimum=`<n>` | Specifies the minimum amount of space in MB to reduce the size of the volume by. |
| querymax | Returns the maximum amount of space in MB by which the volume can be reduced. This value may change if applications are currently accessing the volume. |
| nowait | Forces the command to return immediately while the shrink process is still in progress. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- You can reduce the size of a volume only if it is formatted using the NTFS file system or if it does not have a file system.

- If a desired amount isn't specified, the volume is reduced by the minimum amount (if specified).

- If a minimum amount isn't specified, the volume is reduced by the desired amount (if specified).

- If neither a minimum amount nor a desired amount is specified, the volume is reduced by as much as possible.

- If a minimum amount is specified, but not enough free space is available, the command fails.

## Examples

To reduce the size of the selected volume by the largest possible amount between 250 and 500 megabytes, type:

```
shrink desired=500 minimum=250
```

To display the maximum number of MB that the volume can be reduced by, type:

```
shrink querymax
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Resize-Partition](/powershell/module/storage/resize-partition?view=win10-ps&preserve-view=true)
