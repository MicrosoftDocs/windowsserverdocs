---
title: bitsadmin getmodificationtime
description: "Windows Commands topic for **bitsadmin getmodificationtime** - Retrieves the last time the job was modified or data was successfully transferred."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e543945e-92c4-491e-8c2d-344f8a3e342d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getmodificationtime



Retrieves the last time the job was modified or data was successfully transferred.

## Syntax

```
bitsadmin /GetModificationTime <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example retrieves the last modified time for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetModificationTime myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)