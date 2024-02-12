---
title: bitsadmin setminretrydelay
description: Reference article for the bitsadmin setminretrydelay command, which sets the minimum length of time, in seconds, that BITS waits after encountering a transient error before trying to transfer the file.
ms.topic: reference
ms.assetid: ce8674ca-6cc5-4bb2-8dda-7dfbb1cd6830
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setminretrydelay

Sets the minimum length of time, in seconds, that BITS waits after encountering a transient error before trying to transfer the file.

## Syntax

```
bitsadmin /setminretrydelay <job> <retrydelay>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| retrydelay | Minimum length of time for BITS to wait after an error during transfer, in seconds. |

## Examples

To set the minimum retry delay to 35 seconds for the job named *myDownloadJob*:

```
bitsadmin /setminretrydelay myDownloadJob 35
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
