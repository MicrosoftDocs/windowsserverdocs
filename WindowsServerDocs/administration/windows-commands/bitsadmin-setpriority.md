---
title: bitsadmin setpriority
description: "Windows Commands topic for **bitsadmin setpriority** - 
Sets the priority of the specified job."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 90788363-01a2-4d7c-a560-a3eba45b5e9e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setpriority



Sets the priority of the specified job.

## Syntax

```
bitsadmin /SetPriority <Job> <Priority>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Priority|One of the following values:</br>-   FOREGROUND</br>-   HIGH</br>-   NORMAL</br>-   LOW|

## <a name="BKMK_examples"></a>Examples

The following example sets the priority for the job named *myDownloadJob* to normal.
```
C:\>bitsadmin /SetPriority myDownloadJob NORMAL
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)