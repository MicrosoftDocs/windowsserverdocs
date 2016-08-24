---
title: Bitsadmin setminretrydelay
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce8674ca-6cc5-4bb2-8dda-7dfbb1cd6830author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin setminretrydelay
Sets the length of time, in seconds, that the service waits after encountering a transient error before retrying to transfer the file.
## Syntax
```
bitsadmin /SetMinRetryDelay <Job> <RetryDelay>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|RetryDelay|A number represented in seconds.|
## <a name="BKMK_examples"></a>Examples
The following example sets the minimum retry delay for the job named *myDownloadJob* to 35 seconds.
```
C:\>bitsadmin /SetMinRetryDelay myDownloadJob 35
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
