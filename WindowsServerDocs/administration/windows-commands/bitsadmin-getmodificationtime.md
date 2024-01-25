---
title: bitsadmin getmodificationtime
description: Reference article for the bitsadmin getmodificationtime command, which retrieves the last time the job was modified or data was successfully transferred.
ms.topic: reference
ms.assetid: e543945e-92c4-491e-8c2d-344f8a3e342d
ms.author: jgerend
author: JasonGerend
manager: mtillman
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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
