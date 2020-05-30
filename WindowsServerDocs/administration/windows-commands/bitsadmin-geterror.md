---
title: bitsadmin geterror
description: Reference topic for the bitsadmin geterror command, which retrieves detailed error information for the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: cbe5bca1-d2dd-4ce6-903f-f85de4a2ec6a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin geterror

Retrieves detailed error information for the specified job.

## Syntax

```
bitsadmin /geterror <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the error information for the job named *myDownloadJob*:

```
bitsadmin /geterror myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
