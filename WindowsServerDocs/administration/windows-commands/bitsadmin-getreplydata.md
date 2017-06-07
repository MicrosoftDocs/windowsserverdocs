---
title: bitsadmin getreplydata
description: "Windows Commands topic for **bitsadmin getreplydata** - Retrieves the server's reply data in hexadecimal format."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 819f97d5-b255-4b2d-9f63-0daa73915434
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# bitsadmin getreplydata

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the server's reply data in hexadecimal format.

## Syntax

```
bitsadmin /GetReplyData <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

Valid only for upload-reply jobs.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the reply data for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetReplyData myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)