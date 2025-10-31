---
title: bitsadmin getbytestransferred
description: Reference article for the bitsadmin getbytestransferred command, which retrieves the number of bytes transferred for the specified job.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# bitsadmin getbytestransferred

Retrieves the number of bytes transferred for the specified job.

## Syntax

```
bitsadmin /getbytestransferred <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the number of bytes transferred for the job named *myDownloadJob*:

```
bitsadmin /getbytestransferred myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
