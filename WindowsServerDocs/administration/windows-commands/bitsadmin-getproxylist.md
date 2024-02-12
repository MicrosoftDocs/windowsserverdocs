---
title: bitsadmin getproxylist - Retrieves the proxy list for the specified job.
description: Reference article for the bitsadmin getproxylist command, which retrieves the proxy list for the specified job.
ms.topic: reference
ms.assetid: eebfa727-d8f1-4ae3-9382-6d8ffe8c3df3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getproxylist

Retrieves the comma-delimited list of proxy servers to use for the specified job.

## Syntax

```
bitsadmin /getproxylist <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the proxy list for the job named *myDownloadJob*:

```
bitsadmin /getproxylist myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
