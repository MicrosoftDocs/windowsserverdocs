---
title: bitsadmin gettemporaryname
description: Reference topic for the bitsadmin gettemporaryname command, which reports the temporary filename of the given file within the job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 68925edc-a801-4292-a812-7471c4f60fdd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin gettemporaryname

Reports the temporary filename of the given file within the job.

## Syntax

```
bitsadmin /gettemporaryname <job> <file_index>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| file_index | Starts from 0. |

## Examples

To report the temporary filename of file 2 for the job named *myDownloadJob*:

```
bitsadmin /gettemporaryname myDownloadJob 1
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
