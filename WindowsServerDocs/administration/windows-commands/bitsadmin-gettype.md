---
title: bitsadmin gettype
description: "Windows Commands topic for **bitsadmin gettype** - Retrieves the job type of the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bec16f04-3e95-4587-889e-3de6ad03c9c8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin gettype

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the job type of the specified job.
## Syntax
```
bitsadmin /gettype <Job>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
## remarks
The type can be DOWNLOAD, UPLOAD, UPLOAD-REPLY, or UNKNOWN.
## <a name="BKMK_examples"></a>Examples
The following example retrieves the job type for the job named *myDownloadJob*.
```
C:\>bitsadmin /gettype myDownloadJob
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
