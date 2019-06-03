---
ms.assetid: fb95c8ee-a418-4520-a12a-7754ae947c3c
title: Fsutil reparsepoint
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil reparsepoint
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7, Windows 2008, Windows Vista

Queries or deletes reparse points.  The **fsutil reparsepoint** command is typically used by support professionals.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil reparsepoint [query] <FileName>
fsutil reparsepoint [delete] <FileName>
```

## Parameters

| Parameter  |                                                                Description                                                                |
|------------|-------------------------------------------------------------------------------------------------------------------------------------------|
|   query    |            Retrieves the reparse point data that is associated with the file or directory identified by the specified handle.             |
|   delete   | Deletes a reparse point from the file or directory that is identified by the specified handle, but does not delete the file or directory. |
| <FileName> |             Specifies the full path to the file including the file name and extension, for example C:\documents\filename.txt.             |

## Remarks

-   Reparse points are NTFS file system objects that have a definable attribute that contains user-defined data, and they are used to extend functionality in the input/output (I/O) subsystem.

-   Reparse points are used for directory junction points and volume mount points. They are also used by file system filter drivers to mark certain files as special to that driver.

-   When a program sets a reparse point, it stores this data, plus a reparse tag, which uniquely identifies the data it is storing. When the file system opens a file with a reparse point, it attempts to find the associated file system filter. If the file system filter is found, the filter processes the file as directed by the reparse data. If no file system filter is found, the File open operation fails.

## <a name="BKMK_examples"></a>Examples
To retrieve reparse point data associated with C:\Server, type:

```
fsutil reparsepoint query c:\server
```

To delete a reparse point from a specified file or directory, use the following format:

```
fsutil reparsepoint delete c:\server
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


