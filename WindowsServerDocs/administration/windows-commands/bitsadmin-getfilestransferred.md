---
title: bitsadmin getfilestransferred
description: Reference article for the bitsadmin getfilestransferred command, which retrieves the number of files transferred for the specified job.
ms.topic: reference
ms.assetid: e282815c-938b-4ac0-a09d-9baafb656dcb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getfilestransferred

Retrieves the number of files transferred for the specified job.

## Syntax

```
bitsadmin /getfilestransferred <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To retrieve the number of files transferred in the job named *myDownloadJob*:

```
bitsadmin /getfilestransferred myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
