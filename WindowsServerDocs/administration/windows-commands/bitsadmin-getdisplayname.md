---
title: bitsadmin getdisplayname
description: Reference article for the bitsadmin getdisplayname command, which retrieves the display name of the specified job.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# bitsadmin getdisplayname

Retrieves the display name of the specified job.

## Syntax

```
bitsadmin /getdisplayname <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the display name for the job named *myDownloadJob*:

```
bitsadmin /getdisplayname myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
