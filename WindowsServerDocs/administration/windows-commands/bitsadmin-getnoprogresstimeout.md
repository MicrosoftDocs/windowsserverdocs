---
title: bitsadmin getnoprogresstimeout
description: Reference article for the bitsadmin getnoprogresstimeout command, which retrieves the length of time, in seconds, that the service will try to transfer the file after a transient error occurs.
ms.topic: reference
ms.assetid: 9cd9b19b-cbb4-4352-8419-978080f016b6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getnoprogresstimeout

Retrieves the length of time, in seconds, that the service will try to transfer the file after a transient error occurs.

## Syntax

```
bitsadmin /getnoprogresstimeout <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the progress time out value for the job named *myDownloadJob*:

```
bitsadmin /getnoprogresstimeout myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
