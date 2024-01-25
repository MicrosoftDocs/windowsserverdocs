---
title: bitsadmin getowner
description: Reference article for the bitsadmin getowner command, which retrieves the owner of the specified job.
ms.topic: reference
ms.assetid: 5203f84c-a879-4f31-ae3e-7ea74bd63ca5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getowner

Displays the display name or GUID of the owner of the specified job.

## Syntax

```
bitsadmin /getowner <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To display the owner for the job named *myDownloadJob*:

```
bitsadmin /getowner myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
