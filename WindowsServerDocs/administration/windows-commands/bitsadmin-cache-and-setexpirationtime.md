---
title: bitsadmin cache and setexpirationtime
description: Reference article for the bitsadmin cache and setexpirationtime command, which sets the cache expiration time.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# bitsadmin cache and setexpirationtime



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
