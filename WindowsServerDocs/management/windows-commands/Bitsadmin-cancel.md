---
title: Bitsadmin cancel
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7374b544-6a16-4d3e-872c-dcf4c02ad89dauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin cancel
Removes the job from the transfer queue and deletes all temporary files associated with the job.
## Syntax
```
bitsadmin /cancel <Job>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## <a name="BKMK_examples"></a>Examples
The following example removes the *myDownloadJob* job from the transfer queue.
```
C:\>bitsadmin /cancel myDownloadJob
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
