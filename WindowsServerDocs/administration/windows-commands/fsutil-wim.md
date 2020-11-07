---
title: fsutil wim
description: Reference article for the fsutil wim command, which provides functions to discover and manage Windows Image (WIM)-backed files.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 6c6ff819-f349-4aea-b0be-1f637f631736
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil wim

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows 10

Provides functions to discover and manage Windows Image (WIM)-backed files.

## Syntax

```
fsutil wim [enumfiles] <drive name> <data source>
fsutil wim [enumwims] <drive name>
fsutil wim [queryfile] <filename>
fsutil wim [removewim] <drive name> <data source>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| enumfiles | Enumerates WIM backed files. |
| `<drive name>` | Specifies the drive name. |
| `<data source>` | Specifies the data source. |
| enumwims | Enumerates backing WIM files. |
| queryfile | Queries if the file is backed by WIM, and if so, displays details about the WIM file. |
| `<filename>` | Specifies the filename. |
| removewim | Removes a WIM from backing files. |

### Examples

To enumerate the files for drive C: from data source 0, type:

```
fsutil wim enumfiles C: 0
```

To enumerate backing WIM files for drive C:, type:

```
fsutil wim enumwims C:
```

To see if a file is backed by WIM, type:

```
fsutil wim C:\Windows\Notepad.exe
```

To remove the WIM from backing files for volume C: and data source 2, type:

```
fsutil wim removewims C: 2
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
