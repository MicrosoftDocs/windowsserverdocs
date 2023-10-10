---
title: bitsadmin cache and setexpirationtime
description: Reference article for the bitsadmin cache and setexpirationtime command, which sets the cache expiration time.
ms.topic: reference
ms.assetid: 00ea6e4e-b707-4b31-88dd-b61a78565c8d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin cache and setexpirationtime

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the cache expiration time.

## Syntax

```
bitsadmin /cache /setexpirationtime secs
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| secs | The number of seconds until the cache expires. |

## Examples

To set the cache to expire in 60 seconds:

```
bitsadmin /cache / setexpirationtime 60
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin cache command](bitsadmin-cache.md)
