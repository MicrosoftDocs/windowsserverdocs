---
title: bitsadmin info
description: Reference article for the bitsadmin info command, which displays summary information about the specified job.
ms.topic: reference
ms.assetid: 5c306677-0d64-41c0-8276-5bba7750cecb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin info

Displays summary information about the specified job.

## Syntax

```
bitsadmin /info <job> [/verbose]
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |
| /verbose | Optional. Provides detailed information about each job. |

## Examples

To retrieve information about the job named *myDownloadJob*:

```
bitsadmin /info myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin info](bitsadmin-info.md)
