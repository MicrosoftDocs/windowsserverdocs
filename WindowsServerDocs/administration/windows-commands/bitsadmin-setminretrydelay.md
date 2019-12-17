---
title: bitsadmin setminretrydelay
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce8674ca-6cc5-4bb2-8dda-7dfbb1cd6830
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setminretrydelay

Sets the minimum length of time, in seconds, that BITS waits after encountering a transient error before trying to transfer the file.

## Syntax

```
bitsadmin /SetMinRetryDelay <Job> <RetryDelay>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|RetryDelay|A number represented in seconds.|

## <a name="BKMK_examples"></a>Examples

The following example sets the minimum retry delay for the job named *myDownloadJob* to 35 seconds.
```
C:\>bitsadmin /SetMinRetryDelay myDownloadJob 35
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)