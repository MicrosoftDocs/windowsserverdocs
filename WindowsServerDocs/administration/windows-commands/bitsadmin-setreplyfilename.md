---
title: bitsadmin setreplyfilename
description: Windows Commands topic for bitsadmin setreplyfilename, which specifies the path of the file that contains the server reply.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: c26d3342-0533-40b1-a13e-e09678232b25
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setreplyfilename

Specifies the path of the file that contains the server reply.

**BITS 1.2 and earlier**: Not supported.

## Syntax

```
bitsadmin /SetReplyFileName <Job> <Path>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Path|Location to place the server reply|

## Remarks

Valid only for upload-reply jobs.

## <a name=BKMK_examples></a>Examples

The following example sets the reply filename pathfor the job named *myDownloadJob*.
```
C:\>bitsadmin /SetReplyFileName myDownloadJob c:\reply
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)