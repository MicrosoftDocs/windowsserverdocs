---
title: bitsadmin getfilestotal
description: Reference topic for the bitsadmin getfilestotal command, which retrieves the number of files in the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: c5de113e-f29c-4cd3-9392-0e300018d516
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getfilestotal

Retrieves the number of files in the specified job.

## Syntax

```
bitsadmin /getfilestotal <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the number of files included in the job named *myDownloadJob*:

```
bitsadmin /getfilestotal myDownloadJob
```

## See Also

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
