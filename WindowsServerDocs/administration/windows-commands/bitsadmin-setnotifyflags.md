---
title: bitsadmin setnotifyflags
description: Reference article for the bitsadmin setnotifyflags command, which sets the event notification flags for the specified job.
ms.topic: reference
ms.assetid: d5763d95-94a6-45ca-9e03-891c20047e06
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setnotifyflags

Sets the event notification flags for the specified job.

## Syntax

```
bitsadmin /setnotifyflags <job> <notifyflags>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| notifyflags | Can include one or more of the following notification flags, including:<ul><li>**1.** Generates an event when all files in the job have been transferred.</li><li>**2.** Generates an event when an error occurs.</li><li>**3.** Generates an event when all files have completed transfer or when an error occurs.</li><li>**4.** Disables notifications.</li></ul> |

## Examples

To set the notification flags to generate an event when an error occurs, for a job named *myDownloadJob*:

```
bitsadmin /setnotifyflags myDownloadJob 2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
