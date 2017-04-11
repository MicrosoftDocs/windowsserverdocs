---
title: bitsadmin takeownership
description: "Windows Commands topic for **bitsadmin takeownership** - Lets a user with administrative privileges take ownership of the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea0ce7cb-440a-498f-a3ef-8368fa43e399
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin takeownership

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Lets a user with administrative privileges take ownership of the specified job.
## Syntax
```
bitsadmin /takeownership <Job>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
## <a name="BKMK_examples"></a>Examples
The following example takes ownership of the job named *myDownloadJob*.
```
C:\>bitsadmin /takeownership myDownloadJob
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
