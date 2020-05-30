---
title: bitsadmin sethelpertoken
description: Reference topic for the bitsadmin sethelpertoken command, which sets the current command prompt's primary token (or an arbitrary local user account's token, if specified) as a BITS transfer job's helper token.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin sethelpertoken

Sets the current command prompt's primary token (or an arbitrary local user account's token, if specified) as a BITS transfer job's [helper token](https://docs.microsoft.com/windows/win32/bits/helper-tokens-for-bits-transfer-jobs).

> [!NOTE]
> This command isn't supported by BITS 3.0 and earlier.

## Syntax

```
bitsadmin /sethelpertoken <job> [<user_name@domain> <password>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| `<username@domain>` `<password>` | Optional. The local user account credentials for which token to use. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
