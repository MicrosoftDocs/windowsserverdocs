---
title: bitsadmin getdescription
description: "Windows Commands topic for **bitsadmin getdescription** - 
Retrieves the description of the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3974603-ebbe-4d31-8217-040fe2d90c85
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getdescription



Retrieves the description of the specified job.

## Syntax

```
bitsadmin /GetDescription <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the description for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetDescription myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)