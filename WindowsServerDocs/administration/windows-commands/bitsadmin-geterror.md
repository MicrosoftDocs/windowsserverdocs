---
title: bitsadmin geterror
description: Reference article for the bitsadmin geterror command, which retrieves detailed error information for the specified job.
ms.topic: reference
ms.assetid: cbe5bca1-d2dd-4ce6-903f-f85de4a2ec6a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin geterror

Retrieves detailed error information for the specified job.

## Syntax

```
bitsadmin /geterror <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the error information for the job named *myDownloadJob*:

```
bitsadmin /geterror myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
