---
title: bitsadmin replaceremoteprefix
description: "Windows Commands topic for **bitsadmin replaceremoteprefix** - All files in the job whose remote URL begins with *OldPrefix* are changed to use *NewPrefix*."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d0e0abb1-bdb4-4c74-abbc-16c809f5fd81
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin replaceremoteprefix

All files in the job whose remote URL begins with *OldPrefix* are changed to use *NewPrefix*.

## Syntax

```
bitsadmin /ReplaceRemotePrefix <Job> <OldPrefix> <NewPrefix
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|OldPrefix|Existing URL prefix|
|NewPrefix|New URL prefix|

## Examples

The following example changes all files in job named *myDownloadJob* whose remote URL begins with *http://stageserver* to *http://prodserver*.

```
C:\>bitsadmin /ReplaceRemotePrefix myDownloadJob http://stageserver http://prodserver
```

## Additional information

[Command-Line Syntax Key](command-line-syntax-key.md)