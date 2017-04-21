---
title: bitsadmin setvalidationstate
description: "Windows Commands topic for **bitsadmin setvalidationstate** - Sets the content validation state of the given file within the job."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8fc8e8c-171c-4681-8057-6986b018e576
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin setvalidationstate

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the content validation state of the given file within the job.

## Syntax

```
bitsadmin /SetValidationState <Job> <file index> <true|false> 
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|File index|starts from 0|
|True&#124;False|Set to TRUE if the file content is valid, otherwise set to FALSE|

## <a name="BKMK_examples"></a>Examples
The following example sets the content validation state of file 2 to TRUE for the job named *myJob*.

```
C:\>bitsadmin /SetValidationState myJob 2 TRUE 
```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)


