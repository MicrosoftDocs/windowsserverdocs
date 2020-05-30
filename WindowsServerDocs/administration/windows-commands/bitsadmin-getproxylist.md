---
title: bitsadmin getproxylist - Retrieves the proxy list for the specified job.
description: Reference topic for the bitsadmin getproxylist command, which retrieves the proxy list for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: eebfa727-d8f1-4ae3-9382-6d8ffe8c3df3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
