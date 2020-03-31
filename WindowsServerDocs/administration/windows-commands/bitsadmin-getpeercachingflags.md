---
title: bitsadmin getpeercachingflags
description: Windows Commands topic for bitsadmin getpeercachingflags, which retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 3c3c9f28-4c04-4c49-a23a-dee5bbcc8981
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017 
---
# bitsadmin getpeercachingflags

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.

## Syntax

```
bitsadmin /GetPeerCachingFlags <Job> 
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## <a name=BKMK_examples></a>Examples
The following example retrieves the flags for the job named *myJob*.

```
C:\>bitsadmin /GetPeerCachingFlags myJob
```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)


