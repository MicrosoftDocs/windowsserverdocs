---
title: bitsadmin getbytestotal
description: Windows Commands topic for bitsadmin getbytestotal, which Retrieves the size of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 784e0bfa-7b09-4262-9104-adbc9beb479b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getbytestotal

Retrieves the size of the specified job

## Syntax

```
bitsadmin /GetBytesTotal <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name=BKMK_examples></a>Examples

The following example retrieves the size of the job named *myDownloadJob*.
```
C:\>bitsadmin /GetBytesTotal myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)