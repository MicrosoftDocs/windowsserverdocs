---
title: bitsadmin setcustomheaders
description: "Windows Commands topic for **bitsadmin setcustomheaders** - add a custom HTTP header to a GET request."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed926410-80d0-46ed-9a90-f752c164bb9a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017 
---

# bitsadmin setcustomheaders



Add a custom HTTP header to a GET request.

## Syntax

```
bitsadmin /SetCustomHeaders <Job> <Header1> <Header2> <. . .>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Header1 Header2 . . .|The custom headers for the job|

## Remarks

-   This switch is used to add a custom HTTP header to a GET request sent to an HTTP server.

## <a name="BKMK_examples"></a>Examples

The following example adds a custom HTTP header for the job named *myDownloadJob*.
```
C:\>bitsadmin / SetCustomHeaders myDownloadJob "Accept-encoding:deflate/gzip"
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)