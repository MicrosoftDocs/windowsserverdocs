---
title: bitsadmin listfiles
description: Reference article for the bitsadmin listfiles command, which lists the files in the specified job.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# bitsadmin listfiles

Lists the files in the specified job.

## Syntax

```
bitsadmin /listfiles <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the list of files for the job named *myDownloadJob*:

```
bitsadmin /listfiles myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
