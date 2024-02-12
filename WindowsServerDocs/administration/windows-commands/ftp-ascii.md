---
title: ftp ascii
description: Reference article for the ftp ascii command, which sets the file transfer type to ASCII.
ms.topic: reference
ms.assetid: 523be48e-eab0-4237-8fb5-ca222824f0b6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp ascii

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the file transfer type to ASCII. The **ftp** command supports both ASCII (default) and binary image file transfer types, but we recommend using ASCII when transferring text files. In ASCII mode, character conversions to and from the network standard character set are performed. For example, end-of-line characters are converted as necessary, based on the target operating system.

## Syntax

```
ascii
```

### Examples

To set the file transfer type to ASCII, type:

```
ascii
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
