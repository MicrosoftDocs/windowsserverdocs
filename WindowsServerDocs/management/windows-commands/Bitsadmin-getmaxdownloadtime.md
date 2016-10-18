---
title: Bitsadmin getmaxdownloadtime
description: "Windows Commands topic for **Bitsadmin getmaxdownloadtime** -- Retrieves the download timeout in seconds."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cdce64f6-7125-489d-be3c-4af1dfc8c46a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016 
---

#Bitsadmin getmaxdownloadtime

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Retrieves the download timeout in seconds.

## Syntax

```
bitsadmin /GetMaxDownloadTime <Job> 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## Remarks

-   N\/A

## <a name="BKMK_examples"></a>Examples
The following example gets maximum download time for the job named *myDownloadJob* in seconds.

```
C:\>bitsadmin /GetMaxDownloadTime myDownloadJob
```

## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


