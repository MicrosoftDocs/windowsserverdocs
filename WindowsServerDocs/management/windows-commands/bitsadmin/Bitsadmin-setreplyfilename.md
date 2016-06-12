---
title: bitsadmin setreplyfilename
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c26d3342-0533-40b1-a13e-e09678232b25
---
# bitsadmin setreplyfilename
Specify the path of the file that contains the server reply.

## Syntax

```
bitsadmin /SetReplyFileName <Job> <path>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|path|Location to place the server reply|

## remarks
Valid only for upload\-reply jobs.

## <a name="BKMK_examples"></a>Examples
The following example sets the reply filename pathfor the job named *myDownloadJob*.

```
C:\>bitsadmin /SetReplyFileName myDownloadJob c:\reply
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


