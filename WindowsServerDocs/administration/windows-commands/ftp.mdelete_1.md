---
title: ftp mdelete
description: Reference article for the ftp mdelete command, which deletes files on the remote computer.
ms.topic: reference
ms.assetid: 8a80a8f5-e880-40a8-abc9-29a41836844f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp mdelete

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes files on the remote computer.

## Syntax
```
mdelete <remotefile>[...]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the remote file to delete. |

### Examples

To delete remote files *a.exe* and *b.exe*, type:

```
mdelete a.exe b.exe
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
