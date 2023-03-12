---
title: bitsadmin suspend
description: "Windows Commands topic for **bitsadmin suspend** - 
Suspends the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9d42500-7bea-4aa8-a9f0-c22f6ed3e73b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin suspend

> Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Suspends the specified job.

## Syntax

```
bitsadmin /Suspend <Job>
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## Remarks

To restart the job, use the [bitsadmin resume](bitsadmin-resume.md) switch.

## <a name="BKMK_examples"></a>Examples

The following example suspends the job named *myDownloadJob*.

```
C:\>bitsadmin /Suspend myDownloadJob
```

#### additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
