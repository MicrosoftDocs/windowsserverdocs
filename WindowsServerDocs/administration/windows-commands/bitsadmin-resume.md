---
title: bitsadmin resume
description: Reference article for the bitsadmin resume command, which activates a new or suspended job in the transfer queue.
ms.topic: reference
ms.assetid: 7c7540a9-a11a-4910-923a-2a2a61cbf11d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin resume

Activates a new or suspended job in the transfer queue. If you resumed your job by mistake, or simply need to suspend your job, you can use the [bitsadmin suspend](bitsadmin-suspend.md) switch to suspend the job.

## Syntax

```
bitsadmin /resume <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

## Examples

To resume the job named *myDownloadJob*:

```
bitsadmin /resume myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin suspend command](bitsadmin-suspend.md)

- [bitsadmin command](bitsadmin.md)
