---
title: bitsadmin cancel
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7374b544-6a16-4d3e-872c-dcf4c02ad89d
---
# bitsadmin cancel
removes the job from the transfer queue and deletes all temporary files associated with the job.

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

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


