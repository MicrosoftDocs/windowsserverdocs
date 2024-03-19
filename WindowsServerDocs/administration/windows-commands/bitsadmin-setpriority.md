---
title: bitsadmin setpriority
description: Reference article for the bitsadmin setpriority command, which sets the priority of the specified job.
ms.topic: reference
ms.assetid: 90788363-01a2-4d7c-a560-a3eba45b5e9e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setpriority

Sets the priority of the specified job.

## Syntax

```
bitsadmin /setpriority <job> <priority>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| priority | Sets the priority of the job, including:<ul><li>FOREGROUND</li><li>HIGH</li><li>NORMAL</li><li>LOW</li></ul> |

## Examples

To set the priority for the job named *myDownloadJob* to normal:

```
bitsadmin /setpriority myDownloadJob NORMAL
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
