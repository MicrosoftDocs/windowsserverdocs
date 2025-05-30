---
title: bitsadmin getsecurityflags
description: Reference article for the bitsadmin getsecurityflags command, which reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.
ms.topic: reference
ms.assetid: c2e73519-34f4-487b-af11-97d5d08ef9bb
ms.author: mosagie
author: meaghanlewis
manager: mtillman
ms.date: 10/16/2017
---
# bitsadmin getsecurityflags



Reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.

## Syntax

```
bitsadmin /getsecurityflags <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the security flags from a job named *myDownloadJob*:

```
bitsadmin /getsecurityflags myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
