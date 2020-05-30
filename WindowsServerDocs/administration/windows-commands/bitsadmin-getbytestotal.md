---
title: bitsadmin getbytestotal
description: Reference topic for the bitsadmin getbytestotal command, which Retrieves the size of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 784e0bfa-7b09-4262-9104-adbc9beb479b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getbytestotal

Retrieves the size of the specified job.

## Syntax

```
bitsadmin /getbytestotal <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the size of the job named *myDownloadJob*:

```
bitsadmin /getbytestotal myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
