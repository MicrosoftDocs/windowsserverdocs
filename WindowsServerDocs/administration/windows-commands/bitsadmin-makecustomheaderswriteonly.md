---
title: bitsadmin makecustomheaderswriteonly
description: Reference article for the bitsadmin makecustomheaderswriteonly command, which make a job's Custom HTTP Headers write-only.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 03/01/2019
---

# bitsadmin makecustomheaderswriteonly

Make a job's Custom HTTP Headers write-only.

> [!IMPORTANT]
> This action can't be undone.

## Syntax

```
bitsadmin /makecustomheaderswriteonly <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To make Custom HTTP Headers write-only for the job named *myDownloadJob*:

```
bitsadmin /makecustomheaderswriteonly myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
