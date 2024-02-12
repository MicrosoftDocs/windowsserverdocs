---
title: bitsadmin getbytestotal
description: Reference article for the bitsadmin getbytestotal command, which Retrieves the size of the specified job.
ms.topic: reference
ms.assetid: 784e0bfa-7b09-4262-9104-adbc9beb479b
ms.author: jgerend
author: JasonGerend
manager: mtillman
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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
