---
title: bitsadmin takeownership
description: Reference article for the bitsadmin takeownership command, which lets a user with administrative privileges take ownership of the specified job.
ms.topic: reference
ms.assetid: ea0ce7cb-440a-498f-a3ef-8368fa43e399
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin takeownership

Lets a user with administrative privileges take ownership of the specified job.

## Syntax

```
bitsadmin /takeownership <job>
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| job | The job's display name or GUID. |

## Examples

To take ownership of the job named *myDownloadJob*:

```
bitsadmin /takeownership myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
