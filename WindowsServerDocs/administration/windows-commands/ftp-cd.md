---
title: ftp cd
description: Reference topic for the ftp cd command, which changes the working directory on the remote computer.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: a574855a-31b4-45c6-bce2-581c7231c99b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ftp cd

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the working directory on the remote computer.

## Syntax

```
cd <remotedirectory>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| <remotedirectory> | Specifies the directory on the remote computer to which you want to change. |

### Examples

To change the directory on the remote computer to *Docs*, type:

```
cd Docs
```

To change the directory on the remote computer to *May Videos*, type:

```
cd  May Videos
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](https://docs.microsoft.com/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
