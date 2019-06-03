---
ms.assetid: 77545920-2d13-4f35-a4d1-14dbec8340dc
title: Fsutil sparse
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil sparse
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Manages sparse files.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil sparse [queryflag] <FileName>
fsutil sparse [queryrange] <FileName>
fsutil sparse [setflag] <FileName>
fsutil sparse [setrange] <FileName> <BeginningOffset> <Length>
```

## Parameters

|     Parameter     |                                                    Description                                                    |
|-------------------|-------------------------------------------------------------------------------------------------------------------|
|     queryflag     |                                                  Queries sparse.                                                  |
|    queryrange     |                        Scans a file and searches for ranges that may contain nonzero data.                        |
|      setflag      |                                        Marks the indicated file as sparse.                                        |
|     setrange      |                                   Fills a specified range of a file with zeros.                                   |
|    <FileName>     | Specifies the full path to the file including the file name and extension, for example C:\documents\filename.txt. |
| <BeginningOffset> |                              Specifies the offset within the file to mark as sparse.                              |
|     <Length>      |                 Specifies the length of the region in the file to be marked as sparse (in bytes).                 |

## Remarks

-   A sparse file is a file with one or more regions of unallocated data in it. A program will see these unallocated regions as containing bytes with the value zero, but no disk space is used to represent these zeros. All meaningful or nonzero data is allocated, whereas all nonmeaningful data (large strings of data that is composed of zeros) is not allocated. When a sparse file is read, allocated data is returned as stored, and unallocated data is returned, by default, as zeros, in accordance with the C2 security requirement specification. Sparse file support allows data to be deallocated from anywhere in the file.

-   In a sparse file, large ranges of zeroes may not require disk allocation. Space for nonzero data will be allocated as needed when the file is written.

-   Only compressed or sparse files can have zeroed ranges known to the operating system.

-   If the file is sparse or compressed, NTFS may deallocate disk space within the file. This sets the range of bytes to zeroes without extending the file size.

## <a name="BKMK_examples"></a>Examples
To mark a file named Sample.txt in the C:\Temp directory as sparse, type:

```
fsutil sparse setflag c:\temp\sample.txt 
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


