---
title: bitsadmin getfilestotal
description: Reference article for the bitsadmin getfilestotal command, which retrieves the number of files in the specified job.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# bitsadmin getfilestotal

Retrieves the number of files in the specified job.

## Syntax

```
bitsadmin /getfilestotal <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the number of files included in the job named *myDownloadJob*:

```
bitsadmin /getfilestotal myDownloadJob
```

## See Also

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
