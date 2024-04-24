---
title: ftp type
description: Reference article for the ftp type command, which sets or displays the file transfer type.
ms.topic: reference
ms.assetid: 6e96dcd4-08f8-4e7b-90b7-1e1761fea4c7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp type

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets or displays the file transfer type. The **ftp** command supports both ASCII (default) and binary image file transfer types:

- We recommend using ASCII when transferring text files. In ASCII mode, character conversions to and from the network standard character set are performed. For example, end-of-line characters are converted as necessary, based on the target operating system.

- We recommend using binary when transferring executable files. In binary mode, files are transferred in one-byte units.

## Syntax

```
type [<typename>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[<typename>]` | Specifies the file transfer type. If you don't specify this parameter, the current type is displayed.|

### Examples

To set the file transfer type to ASCII, type:

```
type ascii
```

To set the transfer file type to binary, type:

```
type binary
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
