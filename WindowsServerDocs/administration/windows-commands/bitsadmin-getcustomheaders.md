---
title: bitsadmin getcustomheaders
description: Reference article for the bitsadmin getcustomheaders command, which retrieves the custom HTTP headers from the job.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# bitsadmin getcustomheaders

Retrieves the custom HTTP headers from the job.

## Syntax

```
bitsadmin /getcustomheaders <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To get the custom headers for the job named *myDownloadJob*:

```
bitsadmin /getcustomheaders myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
