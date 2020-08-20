---
title: bitsadmin getproxybypasslist
description: Reference article for the bitsadmin getproxybypasslist command, which retrieves the proxy bypass list for the specified job.
ms.topic: article
ms.assetid: 50959be3-7014-4bc9-9a7b-68f1ff94a94a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getproxybypasslist

Retrieves the proxy bypass list for the specified job.

## Syntax

```
bitsadmin /getproxybypasslist <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

### Remarks

The bypass list contains the host names or IP addresses, or both, that are not to be routed through a proxy. The list can contain `<local>` to refer to all servers on the same LAN. The list can be semicolon (;) or space-delimited.

## Examples

To retrieve the proxy bypass list for the job named *myDownloadJob*:

```
bitsadmin /getproxybypasslist myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
