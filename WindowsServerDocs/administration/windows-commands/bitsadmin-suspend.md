---
title: bitsadmin suspend
description: Reference article for the bitsadmin suspend command, which suspends the specified job.
ms.topic: reference
ms.assetid: f9d42500-7bea-4aa8-a9f0-c22f6ed3e73b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bitsadmin suspend

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Suspends the specified job. If you suspended your job by mistake, you can use the [bitsadmin resume](bitsadmin-resume.md) switch to restart the job.

## Syntax

```
bitsadmin /suspend <job>
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| job | The job's display name or GUID. |

## Example

To suspend the job named *myDownloadJob*:


```
bitsadmin /suspend myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin resume command](bitsadmin-resume.md)

- [bitsadmin command](bitsadmin.md)
