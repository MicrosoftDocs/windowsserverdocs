---
title: bitsadmin getfilestransferred
description: "Windows Commands topic for **bitsadmin getfilestransferred** - Retrieves the number of files transferred for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e282815c-938b-4ac0-a09d-9baafb656dcb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getfilestransferred



Retrieves the number of files transferred for the specified job.

## Syntax

```
bitsadmin /GetFilesTransferred <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the number of files transferred in the job named *myDownloadJob*.
```
C:\>bitsadmin /GetFilesTransferred myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)