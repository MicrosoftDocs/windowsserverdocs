---
title: bitsadmin getmaxdownloadtime
description: Reference article for the bitsadmin getmaxdownloadtime command, which retrieves the download timeout in seconds.
ms.topic: reference
ms.assetid: cdce64f6-7125-489d-be3c-4af1dfc8c46a
ms.author: mosagie
author: meaghanlewis
manager: mtillman
ms.date: 10/16/2017
---
# bitsadmin getmaxdownloadtime



Retrieves the download timeout in seconds.

## Syntax

```
bitsadmin /getmaxdownloadtime <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To get the maximum download time for the job named *myDownloadJob* in seconds:

```
bitsadmin /getmaxdownloadtime myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
