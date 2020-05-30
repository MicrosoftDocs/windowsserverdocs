---
title: bitsadmin getmodificationtime
description: Reference topic for the bitsadmin getmodificationtime command, which retrieves the last time the job was modified or data was successfully transferred.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: e543945e-92c4-491e-8c2d-344f8a3e342d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getmodificationtime

Retrieves the last time the job was modified or data was successfully transferred.

## Syntax

```
bitsadmin /getmodificationtime <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the last modified time for the job named *myDownloadJob*:

```
bitsadmin /getmodificationtime myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
