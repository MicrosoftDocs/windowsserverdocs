---
title: bitsadmin getowner
description: "Windows Commands topic for **bitsadmin getowner** - Retrieves the owner of the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5203f84c-a879-4f31-ae3e-7ea74bd63ca5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getowner

Displays the display name or GUID of the owner of the specified job.

## Syntax

```
bitsadmin /GetOwner <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example displays the owner for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetOwner myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)