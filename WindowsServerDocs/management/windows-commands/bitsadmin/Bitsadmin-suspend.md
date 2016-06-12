---
title: bitsadmin suspend
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9d42500-7bea-4aa8-a9f0-c22f6ed3e73b
---
# bitsadmin suspend
Suspends the specified job.

## Syntax

```
bitsadmin /Suspend <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks
To restart the job, use the [bitsadmin resume](bitsadmin-resume.md) command.

## <a name="BKMK_examples"></a>Examples
The following example suspends the job named *myDownloadJob*.

```
C:\>bitsadmin /Suspend myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


