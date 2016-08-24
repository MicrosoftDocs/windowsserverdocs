---
title: Bitsadmin setreplyfilename
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c26d3342-0533-40b1-a13e-e09678232b25author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin setreplyfilename
Specify the path of the file that contains the server reply.
## Syntax
```
bitsadmin /SetReplyFileName <Job> <Path>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|Path|Location to place the server reply|
## Remarks
Valid only for upload-reply jobs.
## <a name="BKMK_examples"></a>Examples
The following example sets the reply filename pathfor the job named *myDownloadJob*.
```
C:\>bitsadmin /SetReplyFileName myDownloadJob c:\reply
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
