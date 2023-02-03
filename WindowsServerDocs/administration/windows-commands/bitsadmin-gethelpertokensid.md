---
title: bitsadmin gethelpertokensid
description: Reference article for the bitsadmin gethelpertokensid command, which returns the SID of a BITS transfer job's helper token, if one is set.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 03/01/2019
---

# bitsadmin gethelpertokensid

Returns the SID of a BITS transfer job's [helper token](/windows/win32/bits/helper-tokens-for-bits-transfer-jobs), if one is set.

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

## Examples

To retrieve the SID of a BITS transfer job named *myDownloadJob*:

```
bitsadmin /gethelpertokensid myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
