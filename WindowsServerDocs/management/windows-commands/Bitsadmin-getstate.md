---
title: Bitsadmin getstate
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1252d6cf-14ca-44df-beb2-930ff011f297author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin getstate
Retrieves the state of the specified job.
## Syntax
```
bitsadmin /GetState <Job>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## Remarks
The possible states are:
|||
|-|-|
|QUEUED|The job is waiting to run.|
|CONNECTING|BITS is contacting the server.|
|TRANSFERRING|BITS is transferring data.|
|SUSPENDED|The job is paused.|
|ERROR|A non-recoverable error occurred; the transfer will not be retried.|
|TRANSIENT_ERROR|A recoverable error occurred; the transfer retries when the minimum retry delay expires.|
|ACKNOWLEDGED|The job was completed.|
|CANCELED|The job was canceled.|
## <a name="BKMK_examples"></a>Examples
The following example retrieves the state for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetState myDownloadJob
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
