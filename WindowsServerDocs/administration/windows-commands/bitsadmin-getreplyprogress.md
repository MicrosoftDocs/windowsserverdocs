---
title: bitsadmin getreplyprogress
description: "Windows Commands topic for **bitsadmin getreplyprogress** - Retrieves the size and progress of the server reply."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f7cb0b4-ad95-44fd-a35d-0ddf5fc0b0d0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getreplyprogress

Retrieves the size and progress of the server reply.

**BITS 1.2 and earlier**: Not supported.

## Syntax

```
bitsadmin /GetReplyProgress <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

Valid only for upload-reply jobs.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the reply progress for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetReplyProgress myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)