---
title: bitsadmin setminretrydelay
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce8674ca-6cc5-4bb2-8dda-7dfbb1cd6830
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin setminretrydelay

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the length of time, in seconds, that the service waits after encountering a transient error before retrying to transfer the file.
## Syntax
```
bitsadmin /SetMinRetrydelay <Job> <Retrydelay>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|Retrydelay|A number represented in seconds.|
## <a name="BKMK_examples"></a>Examples
The following example sets the minimum retry delay for the job named *myDownloadJob* to 35 seconds.
```
C:\>bitsadmin /SetMinRetrydelay myDownloadJob 35
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
