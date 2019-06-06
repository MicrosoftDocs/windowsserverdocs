---
title: bitsadmin getfilestotal
description: "Windows Commands topic for **bitsadmin getfilestotal** - 
Retrieves the number of files in the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c5de113e-f29c-4cd3-9392-0e300018d516
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getfilestotal



Retrieves the number of files in the specified job.

## Syntax

```
bitsadmin /GetFilesTotal <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the number of files included in the job named *myDownloadJob*.
```
C:\>bitsadmin /GetFilesTotal myDownloadJob
```

# #

[Command-Line Syntax Key](command-line-syntax-key.md)
See Also