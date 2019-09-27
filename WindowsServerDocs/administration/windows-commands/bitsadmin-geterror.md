---
title: bitsadmin geterror
description: "Windows Commands topic for **bitsadmin geterror** - Retrieves detailed error information for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cbe5bca1-d2dd-4ce6-903f-f85de4a2ec6a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin geterror



Retrieves detailed error information for the specified job.

## Syntax

```
bitsadmin /GetError <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the error information for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetError myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)