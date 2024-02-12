---
title: bitsadmin setmaxdownloadtime
description: Reference article for the bitsadmin setmaxdownloadtime command, which sets the download timeout in seconds.
ms.topic: reference
ms.assetid: 16b96cf1-5738-415c-9b9d-c4ea8d5e4fec
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setmaxdownloadtime

Sets the download timeout in seconds.

## Syntax

```
bitsadmin /setmaxdownloadtime <job> <timeout>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| timeout | The length for the download timeout, in seconds. |

## Examples

To set the timeout for the job named *myDownloadJob* to 10 seconds.

```
bitsadmin /setmaxdownloadtime myDownloadJob 10
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
