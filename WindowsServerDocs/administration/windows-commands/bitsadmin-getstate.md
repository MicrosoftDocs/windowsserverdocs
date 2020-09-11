---
title: bitsadmin getstate
description: Reference article for the bitsadmin getstate command, which retrieves the state of the specified job.
ms.topic: reference
ms.assetid: 1252d6cf-14ca-44df-beb2-930ff011f297
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin getstate

Retrieves the state of the specified job.

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
| Queued | The job is waiting to run. |
| Connecting | BITS is contacting the server. |
| Transferring | BITS is transferring data. |
| Transferred | BITS has successfully transferred all files in the job. |
| Suspended | The job is paused. |
| Error | A non-recoverable error occurred; the transfer will not be retried. |
| Transient_Error | A recoverable error occurred; the transfer retries when the minimum retry delay expires. |
| Acknowledged | The job completed. |
| Canceled | The job was canceled. |

## Examples

To retrieve the state for the job named *myDownloadJob*:

```
bitsadmin /getstate myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
