---
title: bitsadmin complete
description: Reference article for the bitsadmin complete command, which completes the job.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# bitsadmin complete

Completes the job. Use this switch after the job moves to the transferred state. Otherwise, only those files that have been successfully transferred will be available.

## Syntax

```
bitsadmin /complete <job>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |

## Example

To complete the *myDownloadJob* job, after it reaches the `TRANSFERRED` state:

```
bitsadmin /complete myDownloadJob
```

If multiple jobs use *myDownloadJob* as their name, you must use the job's GUID to uniquely identify it for completion.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
