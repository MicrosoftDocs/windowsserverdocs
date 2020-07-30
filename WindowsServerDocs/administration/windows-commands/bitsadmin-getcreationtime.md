---
title: bitsadmin getcreationtime
description: Reference article for the bitsadmin getcreationtime command, which retrieves the creation time for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: be409cb5-ce72-41d9-aafa-edd4e230fd14
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getcreationtime

Retrieves the creation time for the specified job.

## Syntax

```
bitsadmin /getcreationtime <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the creation time for the job named *myDownloadJob*:

```
bitsadmin /getcreationtime myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
