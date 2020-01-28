---
title: bitsadmin getstate
description: "Windows Commands topic for bitsadmin getstate"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1252d6cf-14ca-44df-beb2-930ff011f297
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getstate


Retrieves the state of the specified job.

## Syntax

```
bitsadmin /GetState <Job>
```

## Parameters

| Parameter | Description |
| --------- | ----------- |
|    Job    | The job's display name or GUID |

## Remarks

The possible states are:

|      State      | Description |
| --------------- | ----------- |
| QUEUED          | The job is waiting to run. |
| CONNECTING      | BITS is contacting the server. |
| TRANSFERRING    | BITS is transferring data. |
| TRANSFERRED     | BITS has successfully transferred all files in the job. |
| SUSPENDED       | The job is paused. |
| ERROR           | A non-recoverable error occurred; the transfer will not be retried. |
| TRANSIENT_ERROR | A recoverable error occurred; the transfer retries when the minimum retry delay expires. |
| ACKNOWLEDGED    | The job was completed. |
| CANCELED        | The job was canceled. |

## <a name="BKMK_examples"></a>Examples

The following example retrieves the state for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetState myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
