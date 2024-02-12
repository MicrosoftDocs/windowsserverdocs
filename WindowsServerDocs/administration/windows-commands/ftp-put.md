---
title: ftp put
description: Reference article for the ftp put command, which copies a local file to the remote computer using the current file transfer type.
ms.topic: reference
ms.assetid: 95cc1e3f-523d-4374-98b8-16e6c276b2ca
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 03/30/2020
---

# ftp put

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies a local file to the remote computer using the current file transfer type.

> [!NOTE]
> This command is the same as the [ftp send command](ftp-send_1.md).

## Syntax

```
put <localfile> [<remotefile>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<localfile>` | Specifies the local file to copy. |
| `[<remotefile>]` | Specifies the name to use on the remote computer. If you don't specify a *remotefile*, the file is give the *localfile* name.|

### Examples

To copy the local file *test.txt* and name it *test1.txt* on the remote computer, type:

```
put test.txt test1.txt
```

To copy the local file *program.exe* to the remote computer, type:

```
put program.exe
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
