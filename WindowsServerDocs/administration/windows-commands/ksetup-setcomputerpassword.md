---
title: ksetup setcomputerpassword
description: Reference article for the ksetup setcomputerpassword command, which sets the password for the local computer.
ms.topic: reference
ms.assetid: e307d8f6-3b93-4c24-ac04-f31549f7dc7d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup setcomputerpassword

Sets the password for the local computer. This command affects the computer account only and requires a restart for the password change to take effect.

> [!IMPORTANT]
> The computer account password isn't displayed in the registry or as output from the **ksetup** command.

## Syntax

```
ksetup /setcomputerpassword <password>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<password>` | Specifies the supplied password to set the computer account on the local computer. The password can only be set by using an account with administrative privileges, and the password must be from 1 to 156 alphanumeric or special characters. |

### Examples

To change the computer account password on the local computer from *IPops897* to *IPop$897!*, type:

```
ksetup /setcomputerpassword IPop$897!
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)
