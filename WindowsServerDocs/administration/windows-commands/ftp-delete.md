---
title: ftp delete
description: Reference article for the ftp delete command, which deletes files on remote computers.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 067c45f3-e4e8-4450-b8b6-836994f6adfe
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ftp delete

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes files on remote computers.

## Syntax

```
delete <remotefile>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the file to delete. |

### Examples

To delete the *test.txt* file on the remote computer, type:

```
delete test.txt
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](https://docs.microsoft.com/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
