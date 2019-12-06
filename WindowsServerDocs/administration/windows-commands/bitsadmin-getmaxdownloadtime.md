---
title: bitsadmin getmaxdownloadtime
description: "Windows Commands topic for **bitsadmin getmaxdownloadtime** - Retrieves the download timeout in seconds."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cdce64f6-7125-489d-be3c-4af1dfc8c46a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017 
---
# bitsadmin getmaxdownloadtime

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the download timeout in seconds.

## Syntax

```
bitsadmin /GetMaxDownloadtime <Job> 
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## Remarks

-   N\/A

## <a name="BKMK_examples"></a>Examples
The following example gets maximum download time for the job named *myDownloadJob* in seconds.

```
C:\>bitsadmin /GetMaxDownloadtime myDownloadJob
```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)


