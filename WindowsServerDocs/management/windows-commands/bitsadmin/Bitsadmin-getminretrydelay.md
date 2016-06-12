---
title: bitsadmin getminretrydelay
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 54f0abab-c129-40ed-a603-50f464d26011
---
# bitsadmin getminretrydelay
Retrieves the length of time, in seconds, that the service waits after encountering a transient error before trying to transfer the file.

## Syntax

```
bitsadmin /GetMinRetrydelay <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the minimum retry delay for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetMinRetrydelay myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


