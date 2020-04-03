---
title: bitsadmin getmaxdownloadtime
description: Windows Commands topic for bitsadmin getmaxdownloadtime, which retrieves the download timeout in seconds.
ms.prod: windows-servemr
ms.technology: manage-windows-commands
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

### Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## <a name=BKMK_examples></a>Examples
The following example gets maximum download time for the job named *myDownloadJob* in seconds.

```
C:\>bitsadmin /GetMaxDownloadtime myDownloadJob
```

## Additional References
[Command-Line Syntax Key](command-line-syntax-key.md)


