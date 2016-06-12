---
title: bitsadmin getmodificationtime
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e543945e-92c4-491e-8c2d-344f8a3e342d
---
# bitsadmin getmodificationtime
Retrieves the last time the job was modified or data was successfully transferred.

## Syntax

```
bitsadmin /GetModificationtime <Job>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the last modified time for the job named *myDownloadJob*.

```
C:\>bitsadmin /GetModificationtime myDownloadJob
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


