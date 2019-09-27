---
title: bitsadmin getnotifyinterface
description: "Windows Commands topic for **bitsadmin getnotifyinterface** - Determines if another program has registered a COM callback interface for the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40bf9dd8-b167-406a-80a6-a5a6f1b8cf7f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getnotifyinterface

Determines whether another program has registered a COM callback interface (the notify interface) for the specified job.

## Syntax

```
bitsadmin /GetNotifyInterface <Job>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## Remarks

Displays REGISTERED or UNREGISTERED.

> [!NOTE]
> It is not possible to determine the program that registered the callback interface.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the notify interface for the job named *myDownloadJob*.
```
C:\>bitsadmin /GetNotifyInterface myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)