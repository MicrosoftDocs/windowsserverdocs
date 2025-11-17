---
title: bitsadmin getcompletiontime
description: Reference article for the bitsadmin getcompletiontime command, which retrieves the time that the job finished transferring data.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# bitsadmin getcompletiontime

Retrieves the time that the job finished transferring data.

## Syntax

```
bitsadmin /getcompletiontime <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the time that the job named *myDownloadJob* finished transferring data:

```
bitsadmin /getcompletiontime myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
