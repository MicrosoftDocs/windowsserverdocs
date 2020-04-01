---
title: bitsadmin getowner
description: Windows Commands topic for bitsadmin getowner, which retrieves the owner of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
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

## <a name=BKMK_examples></a>Examples

The following example displays the owner for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetOwner myDownloadJob
```

## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)