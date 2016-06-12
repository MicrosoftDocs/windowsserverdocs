---
title: bitsadmin getfilestotal
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c5de113e-f29c-4cd3-9392-0e300018d516
---
# bitsadmin getfilestotal
Retrieves the number of files in the specified job.

## Syntax

```
bitsadmin /GetFilesTotal <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the number of files included in the job named *myDownloadJob*.

```
C:\>bitsadmin /GetFilesTotal myDownloadJob
```

## See Also
[Command-Line Syntax Key](../commandline-syntax-key.md)


