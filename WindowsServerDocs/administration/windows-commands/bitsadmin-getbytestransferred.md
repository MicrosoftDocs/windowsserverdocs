---
title: bitsadmin getbytestransferred
description: Reference topic for the bitsadmin getbytestransferred command, which retrieves the number of bytes transferred for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 47bbf184-e06f-4be0-b2ba-d32b10d82002
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getbytestransferred

Retrieves the number of bytes transferred for the specified job.

## Syntax

```
bitsadmin /getbytestransferred <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the number of bytes transferred for the job named *myDownloadJob*:

```
bitsadmin /getbytestransferred myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
