---
title: bitsadmin getbytestransferred
description: "Windows Commands topic for **bitsadmin getbytestransferred** - Retrieves the number of bytes transferred for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47bbf184-e06f-4be0-b2ba-d32b10d82002
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getbytestransferred



Retrieves the number of bytes transferred for the specified job.

## Syntax

```
bitsadmin /GetBytesTransferred <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the number of bytes transferred for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetBytesTransferred myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)