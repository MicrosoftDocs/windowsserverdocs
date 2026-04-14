---
title: ftp append
description: Reference article for the ftp append command, which appends a local file to a file on the remote computer using the current file type setting.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# ftp append



Appends a local file to a file on the remote computer using the current file type setting.

## Syntax

```
append <localfile> [remotefile]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<localfile>` | Specifies the local file to add. |
| [remotefile] | Specifies the file on the remote computer to which `<localfile>` is added. If you don't use this parameter, the `<localfile>` name is used in place of the remote file name. |

### Examples

To append *file1.txt* to *file2.txt* on the remote computer, type:

```
append file1.txt file2.txt
```

To append the local *file1.txt* to a file named *file1.txt* on the remote computer.

```
append file1.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
