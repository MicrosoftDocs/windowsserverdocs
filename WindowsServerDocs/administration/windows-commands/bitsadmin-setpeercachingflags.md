---
title: bitsadmin setpeercachingflags
description: "Windows Commands topic for **bitsadmin setpeercachingflags** - Sets flags that determine if the files of the job can be cached and served to peers and if the job can download content from peers."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f54a127-fb68-49a5-b843-664ec833df67
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setpeercachingflags



Sets flags that determine if the files of the job can be cached and served to peers and if the job can download content from peers.

## Syntax

```
bitsadmin /SetPeerCachingFlags <Job> <value> 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Value|The value is an unsigned integer with the following interpretation for the bits in the binary representation.</br>1 - The job can download content from peers.</br>2 - The files of the job can be cached and served to peers.|

## <a name="BKMK_examples"></a>Examples

The following example sets flags for the job named *myJob* which allows it to download content from peers.
```
C:\>bitsadmin / SetPeerCachingFlags myJob 1 
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)