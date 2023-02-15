---
title: fsutil reparsepoint
description: Reference article for the fsutil reparsepoint command, which queries or deletes reparse points.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: fb95c8ee-a418-4520-a12a-7754ae947c3c
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil reparsepoint

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Queries or deletes reparse points.  The **fsutil reparsepoint** command is typically used by support professionals.

Reparse points are NTFS file system objects that have a definable attribute, which contains user-defined data. They're used to:

- Extend functionality in the input/output (I/O) subsystem.

- Act as directory junction points and volume mount points.

- Mark certain files as special to a file system filter driver.

## Syntax

```
fsutil reparsepoint [query] <filename>
fsutil reparsepoint [delete] <filename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| query | Retrieves the reparse point data that is associated with the file or directory identified by the specified handle. |
| delete | Deletes a reparse point from the file or directory that is identified by the specified handle, but does not delete the file or directory. |
| `<filename>` | Specifies the full path to the file including the file name and extension, for example *C:\documents\filename.txt*. |

#### Remarks

- When a program sets a reparse point, it stores this data, plus a reparse tag, which uniquely identifies the data it is storing. When the file system opens a file with a reparse point, it attempts to find the associated file system filter. If the file system filter is found, the filter processes the file as directed by the reparse data. If no file system filter is found, the **File open** operation fails.

### Examples

To retrieve reparse point data associated with *c:\server*, type:

```
fsutil reparsepoint query c:\server
```

To delete a reparse point from a specified file or directory, use the following format:

```
fsutil reparsepoint delete c:\server
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
