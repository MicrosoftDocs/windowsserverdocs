---
title: bitsadmin getbytestotal
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 784e0bfa-7b09-4262-9104-adbc9beb479b
---
# bitsadmin getbytestotal
Retrieves the size of the specified job

## Syntax

```
bitsadmin /GetBytesTotal <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the size of the job named *myDownloadJob*.

```
C:\>bitsadmin /GetBytesTotal myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


