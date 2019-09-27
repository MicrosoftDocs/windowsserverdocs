---
title: bitsadmin getreplyfilename
description: "Windows Commands topic for **bitsadmin getreplyfilename** - Gets the path of the file that contains the server reply."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85447184-1732-4816-a365-2e3599551bf8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getreplyfilename

Gets the path of the file that contains the server reply.

**BITS 1.2 and earlier**: Not supported.

## Syntax

```
bitsadmin /GetReplyFileName <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

Valid only for upload-reply jobs.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the reply filename for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetReplyFileName myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)