---
title: bitsadmin getcompletiontime
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7a4b3c1c-9832-4724-86b2-cce3c01bfa28
---
# bitsadmin getcompletiontime
Retrieves the time that the job finished transferring data.

## Syntax

```
bitsadmin /Getcompletiontime <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the time that the job named *myDownloadJob* finished transferring data.

```
C:\>bitsadmin /Getcompletiontime myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


