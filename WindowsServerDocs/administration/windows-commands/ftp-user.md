---
title: ftp user
description: Reference article for the ftp user command, which specifies a user to the remote computer.
ms.topic: reference
ms.assetid: 0a77bfeb-27a9-4f2f-a3c4-2fef529fb569
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp user

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Specifies a user to the remote computer.

## Syntax

```
user <username> [<password>] [<account>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<username>` | Specifies a user name with which to log on to the remote computer. |
| `[<password>]` | Specifies the password for *username*. If a password is not specified but is required, the **ftp** command prompts for the password. |
| `[<account>]` | Specifies an account with which to log on to the remote computer. If an *account* isn't specified but is required, the **ftp** command prompts for the account. |

### Examples

To specify *User1* with the password *Password1*, type:

```
user User1 Password1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
