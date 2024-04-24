---
title: tftp
description: Reference article for the tftp command, which transfers files to and from a remote computer.
ms.topic: reference
ms.assetid: 772f19a8-dafe-45cd-878a-f5691f6568ef
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# tftp

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Transfers files to and from a remote computer, typically a computer running UNIX, that is running the Trivial File Transfer Protocol (tftp) service or daemon. tftp is typically used by embedded devices or systems that retrieve firmware, configuration information, or a system image during the boot process from a tftp server.

> [IMPORTANT]
> The tftp protocol doesn't support any authentication or encryption mechanism, and as such can introduce a security risk when present. Installing the tftp client is not recommended for systems connected to the Internet. A tftp server service is no longer provided by Microsoft for security reasons.

## Syntax

```
tftp [-i] [<host>] [{get | put}] <source> [<destination>]
```

### Parameters

| Parameter | Description |
|--|--|
| -i | Specifies binary image transfer mode (also called octet mode). In binary image mode, the file is transferred in one-byte units. Use this mode when transferring binary files. If you don't use the **-i** option, the file is transferred in ASCII mode. This is the default transfer mode. This mode converts the end-of-line (EOL) characters to an appropriate format for the specified computer. Use this mode when transferring text files. If a file transfer is successful, the data transfer rate is displayed. |
| `<host>` | Specifies the local or remote computer. |
| get | Transfers the file *destination* on the remote computer to the file *source* on the local computer. |
| put | Transfers the file *source* on the local computer to the file *destination* on the remote computer. Because the tftp protocol doesn't support user authentication, the user must be logged onto the remote computer, and the files must be writable on the remote computer. |
| `<source>` | Specifies the file to transfer. |
| `<destination>` | Specifies where to transfer the file. |

## Examples

To copy the file *boot.img* from the remote computer *Host1*, type:

```
tftp  -i Host1 get boot.img
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
