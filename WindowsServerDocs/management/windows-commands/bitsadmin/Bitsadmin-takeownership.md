---
title: bitsadmin takeownership
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea0ce7cb-440a-498f-a3ef-8368fa43e399
---
# bitsadmin takeownership
Lets a user with administrative privileges take ownership of the specified job.

## Syntax

```
bitsadmin /takeownership <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example takes ownership of the job named *myDownloadJob*.

```
C:\>bitsadmin /takeownership myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


