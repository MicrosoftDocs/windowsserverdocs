---
title: bitsadmin getmaxdownloadtime
description: Reference article for the bitsadmin getmaxdownloadtime command, which retrieves the download timeout in seconds.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
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
