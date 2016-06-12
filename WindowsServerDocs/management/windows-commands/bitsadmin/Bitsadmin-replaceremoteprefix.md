---
title: bitsadmin replaceremoteprefix
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d0e0abb1-bdb4-4c74-abbc-16c809f5fd81
---
# bitsadmin replaceremoteprefix
All files in the job whose remote URL begins with *OldPrefix* are changed to use *NewPrefix*.

## Syntax

```
bitsadmin /replaceremotePrefix <Job> <OldPrefix> <NewPrefix
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
|OldPrefix|Existing URL prefix|
|NewPrefix|New URL prefix|

## <a name="BKMK_examples"></a>Examples
The following example changes all files in job named *myDownloadJob* whose remote URL begins with *http:\/\/stageserver* to *http:\/\/prodserver*.

```
C:\>bitsadmin /replaceremotePrefix myDownloadJob http://stageserver http://prodserver
```

## additional information
[Command-Line Syntax Key](../commandline-syntax-key.md)


