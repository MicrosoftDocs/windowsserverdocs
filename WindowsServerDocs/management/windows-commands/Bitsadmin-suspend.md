---
title: Bitsadmin suspend
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9d42500-7bea-4aa8-a9f0-c22f6ed3e73bauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin suspend
Suspends the specified job.
## Syntax
```
bitsadmin /Suspend <Job>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## Remarks
To restart the job, use the [Bitsadmin resume](Bitsadmin-resume.md) command.
## <a name="BKMK_examples"></a>Examples
The following example suspends the job named *myDownloadJob*.
```
C:\>bitsadmin /Suspend myDownloadJob
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
