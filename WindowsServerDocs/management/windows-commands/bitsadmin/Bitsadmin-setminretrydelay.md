---
title: bitsadmin setminretrydelay
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce8674ca-6cc5-4bb2-8dda-7dfbb1cd6830
---
# bitsadmin setminretrydelay
Sets the length of time, in seconds, that the service waits after encountering a transient error before retrying to transfer the file.

## Syntax

```
bitsadmin /SetMinRetrydelay <Job> <Retrydelay>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|Retrydelay|A number represented in seconds.|

## <a name="BKMK_examples"></a>Examples
The following example sets the minimum retry delay for the job named *myDownloadJob* to 35 seconds.

```
C:\>bitsadmin /SetMinRetrydelay myDownloadJob 35
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


