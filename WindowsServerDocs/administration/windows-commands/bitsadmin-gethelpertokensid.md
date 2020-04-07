---
title: bitsadmin gethelpertokensid
description: Windows Commands topic for **bitsadmin gethelpertokensid**, which returns the SID of a BITS transfer job's helper token, if one is set.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 03/01/2019
---

# bitsadmin gethelpertokensid

Returns the SID of a BITS transfer job's [helper token](https://docs.microsoft.com/windows/win32/bits/helper-tokens-for-bits-transfer-jobs), if one is set.

> [!NOTE]
> This command isn't supported by BITS 3.0 and earlier.

## Syntax

```
bitsadmin /gethelpertokensid <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
