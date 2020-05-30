---
title: bitsadmin getcompletiontime
description: Reference topic for the bitsadmin getcompletiontime command, which retrieves the time that the job finished transferring data.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 7a4b3c1c-9832-4724-86b2-cce3c01bfa28
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
