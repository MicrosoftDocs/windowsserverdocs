---
title: bitsadmin get priority
description: "Windows Commands topic for **bitsadmin get priority** - 
Retrieves the priority of the specified job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ff958003-fcc8-4ad8-a9c7-868a48d9bdeb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin get priority

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the priority of the specified job.
## Syntax
```
bitsadmin /GetPriority <Job>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
## remarks
-   The priority is either foregROUND, HIGH, NORMAL, LOW, or UNKNOWN.
## <a name="BKMK_examples"></a>Examples
The following example retrieves the priority for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetPriority myDownloadJob
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
