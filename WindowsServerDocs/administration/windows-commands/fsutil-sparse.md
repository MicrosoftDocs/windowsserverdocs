---
title: fsutil sparse
description: Reference article for the fsutil sparse command, which manages sparse files.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 77545920-2d13-4f35-a4d1-14dbec8340dc
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil sparse

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Manages sparse files. A sparse file is a file with one or more regions of unallocated data in it.

A program sees these unallocated regions as containing bytes with a zero value and that there's no disk space representing these zeros. When a sparse file is read, allocated data is returned as stored, and unallocated data is returned, by default, as zeros, in accordance with the C2 security requirement specification. Sparse file support allows data to be deallocated from anywhere in the file.

## Syntax

```
fsutil sparse [queryflag] <filename>
fsutil sparse [queryrange] <filename>
fsutil sparse [setflag] <filename>
fsutil sparse [setrange] <filename> <beginningoffset> <length>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| queryflag | Queries sparse. |
| queryrange | Scans a file and searches for ranges that may contain nonzero data. |
| setflag | Marks the indicated file as sparse. |
| setrange | Fills a specified range of a file with zeros. |
| `<filename>` | Specifies the full path to the file including the file name and extension, for example *C:\documents\filename.txt*. |
| `<beginningoffset>` | Specifies the offset within the file to mark as sparse. |
| `<length>` | Specifies the length of the region in the file to be marked as sparse (in bytes). |

#### Remarks

- All meaningful or nonzero data is allocated, whereas all non-meaningful data (large strings of data that is composed of zeros) is not allocated.

- In a sparse file, large ranges of zeroes may not require disk allocation. Space for nonzero data is allocated as needed when the file is written.

- Only compressed or sparse files can have zeroed ranges known to the operating system.

- If the file is sparse or compressed, NTFS may de-allocate disk space within the file. This sets the range of bytes to zeroes without extending the file size.

### Examples

To mark a file named *sample.txt* in the *c:\temp* directory as sparse, type:

```
fsutil sparse setflag c:\temp\sample.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
