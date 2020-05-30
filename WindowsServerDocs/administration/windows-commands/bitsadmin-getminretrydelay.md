---
title: bitsadmin getminretrydelay
description: Reference topic for the bitsadmin getminretrydelay command, which retrieves the length of time, in seconds, that the service waits after encountering a transient error before trying to transfer the file.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 54f0abab-c129-40ed-a603-50f464d26011
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getminretrydelay

Retrieves the length of time, in seconds, that the service will wait after encountering a transient error before trying to transfer the file.

## Syntax

```
bitsadmin /getminretrydelay <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the minimum retry delay for the job named *myDownloadJob*:

```
bitsadmin /getminretrydelay myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
