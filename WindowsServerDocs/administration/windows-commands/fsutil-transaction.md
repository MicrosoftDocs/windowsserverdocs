---
title: fsutil transaction
description: Reference article for the fsutil transaction command, which manages NTFS transactions.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: f2eefaaf-2817-4ac7-abac-d2b65fa971dc
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil transaction

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Manages NTFS transactions.

## Syntax

```
fsutil transaction [commit] <GUID>
fsutil transaction [fileinfo] <filename>
fsutil transaction [list]
fsutil transaction [query] [{files | all}] <GUID>
fsutil transaction [rollback] <GUID>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| commit | Marks the end of a successful implicit or explicit specified transaction. |
| `<GUID>` | Specifies the GUID value that represents a transaction. |
| fileinfo  | Displays transaction information for the specified file. |
| `<filename>` | Specifies full path and file name. |
| list | Displays a list of currently running transactions. |
| query | Displays information for the specified transaction.<ul><li>If `fsutil transaction query files` is specified, the file information is displayed only for the specified transaction.</li><li>If `fsutil transaction query all` is specified, all information for the transaction will be displayed.</li></ul> |
| rollback | Rolls back a specified transaction to the beginning. |

### Examples

To display transaction information for file *c:\test.txt*, type:

```
fsutil transaction fileinfo c:\test.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)

- [Transactional NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc730726(v=ws.10))
