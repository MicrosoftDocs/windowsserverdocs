---
title: bitsadmin geterrorcount
description: "Windows Commands topic for **bitsadmin geterrorcount** - Retrieves a count of the number of times the specified job generated a transient error."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8840ae78-52b0-4c7e-b592-0547359a237e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin geterrorcount



Retrieves a count of the number of times the specified job generated a transient error.

## Syntax

```
bitsadmin /GetErrorCount <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves error count information for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetErrorCount myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)