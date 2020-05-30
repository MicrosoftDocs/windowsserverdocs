---
title: bitsadmin getdisplayname
description: Reference topic for the bitsadmin getdisplayname command, which retrieves the display name of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: e5c0e76c-4cc6-42d8-ac30-30bf3dc11b9b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getdisplayname

Retrieves the display name of the specified job.

## Syntax

```
bitsadmin /getdisplayname <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the display name for the job named *myDownloadJob*:

```
bitsadmin /getdisplayname myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
