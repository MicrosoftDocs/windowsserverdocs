---
title: bitsadmin getstate
description: Reference article for the bitsadmin getstate command, which retrieves the state of the specified job.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# bitsadmin getstate

Applies to: Windows Server (All supported versions)

The `bitsadmin /getstate` command retrieves the state of a specified job.

## Syntax

```
bitsadmin /getstate <job>
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| job | The job's display name or GUID. |

#### Output

The returned output values can be:

| State | Description |
| --------------- | ----------- |
| `Queued` | The job is waiting to run. |
| `Connecting` | BITS is contacting the server. |
| `Transferring` | BITS is transferring data. |
| `Transferred` | BITS has successfully transferred all files in the job. |
| `Suspended` | The job is paused. |
| `Error` | A nonrecoverable error occurred; the transfer isn't retried. |
| `Transient_Error` | A recoverable error occurred; the transfer retries when the minimum retry delay expires. |
| `Acknowledged` | The job completed. |
| `Canceled` | The job was canceled. |

## Examples

To retrieve the state for the job named *myDownloadJob*:

```
bitsadmin /getstate myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
