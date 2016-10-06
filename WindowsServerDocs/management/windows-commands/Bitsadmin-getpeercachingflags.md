---
title: Bitsadmin getpeercachingflags
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c3c9f28-4c04-4c49-a23a-dee5bbcc8981
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016 
---

#Bitsadmin getpeercachingflags

Retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.

## Syntax

```
bitsadmin /GetPeerCachingFlags <Job> 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example retrieves the flags for the job named *myJob*.

```
C:\>bitsadmin /GetPeerCachingFlags myJob
```

## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


