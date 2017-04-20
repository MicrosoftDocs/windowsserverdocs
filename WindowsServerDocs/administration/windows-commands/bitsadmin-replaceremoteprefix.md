---
title: bitsadmin replaceremoteprefix
description: "Windows Commands topic for **bitsadmin replaceremoteprefix** - All files in the job whose remote URL begins with *OldPrefix* are changed to use *NewPrefix*."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d0e0abb1-bdb4-4c74-abbc-16c809f5fd81
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin replaceremoteprefix

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

All files in the job whose remote URL begins with *OldPrefix* are changed to use *NewPrefix*.
## Syntax
```
bitsadmin /replaceremotePrefix <Job> <OldPrefix> <NewPrefix
```
## Parameters
|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|
|OldPrefix|Existing URL prefix|
|NewPrefix|New URL prefix|
## <a name="BKMK_examples"></a>Examples
The following example changes all files in job named *myDownloadJob* whose remote URL begins with *http://stageserver* to *http://prodserver*.
```
C:\>bitsadmin /replaceremotePrefix myDownloadJob http://stageserver http://prodserver
```
## additional information
[Command-Line Syntax Key](command-line-syntax-key.md)
