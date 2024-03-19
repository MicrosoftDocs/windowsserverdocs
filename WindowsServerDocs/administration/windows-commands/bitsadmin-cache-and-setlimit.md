---
title: bitsadmin cache and setlimit
description: Reference article for the bitsadmin cache and setlimit command, which sets the cache size limit.
ms.topic: reference
ms.assetid: 46578835-d5ce-423b-be4d-62ddb9e1908d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin cache and setlimit

Sets the cache size limit.

## Syntax

```
bitsadmin /cache /setlimit percent
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| percent | The cache limit defined as a percentage of the total hard disk space. |

## Examples

To set the cache size limit to 50%:

```
bitsadmin /cache /setlimit 50
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin cache command](bitsadmin-cache.md)
