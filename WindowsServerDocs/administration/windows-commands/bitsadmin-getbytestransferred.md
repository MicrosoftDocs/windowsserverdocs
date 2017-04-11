---
title: bitsadmin getbytestransferred
description: "Windows Commands topic for **bitsadmin getbytestransferred** - Retrieves the number of bytes transferred for the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47bbf184-e06f-4be0-b2ba-d32b10d82002
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin getbytestransferred

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the number of bytes transferred for the specified job.
## Syntax
```
bitsadmin /GetBytesTransferred <Job>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
## <a name="BKMK_examples"></a>Examples
The following example retrieves the number of bytes transferred for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetBytesTransferred myDownloadJob
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
