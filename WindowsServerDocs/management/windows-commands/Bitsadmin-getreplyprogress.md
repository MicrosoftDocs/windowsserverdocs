---
title: Bitsadmin getreplyprogress
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f7cb0b4-ad95-44fd-a35d-0ddf5fc0b0d0
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin getreplyprogress
Retrieves the size and progress of the server reply.
## Syntax
```
bitsadmin /GetReplyProgress <Job>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## Remarks
Valid only for upload-reply jobs.
## <a name="BKMK_examples"></a>Examples
The following example retrieves the reply progress for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetReplyProgress myDownloadJob
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
