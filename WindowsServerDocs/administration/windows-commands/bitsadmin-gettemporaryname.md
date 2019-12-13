---
title: bitsadmin gettemporaryname
description: "Windows Commands topic for **bitsadmin gettemporaryname** - Reports the temporary filename of the given file within the job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68925edc-a801-4292-a812-7471c4f60fdd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin gettemporaryname



Reports the temporary filename of the given file within the job.

## Syntax

```
bitsadmin /GetTemporaryName <Job> <file index> 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|File index|Starts from 0|

## <a name="BKMK_examples"></a>Examples

The following example reports the temporary filename of file 2 for the job named *myJob*.
```
C:\>bitsadmin /GetTemporaryName myJob 1 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)