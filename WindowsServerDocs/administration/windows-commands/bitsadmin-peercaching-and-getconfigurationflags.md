---
title: bitsadmin peercaching and getconfigurationflags
description: "Windows Commands topic for **bitsadmin peercaching and getconfigurationflags** - Gets the configuration flags that determine if the computer serves content to peers and can download content from peers."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 124ddc15-3444-4bd5-96e5-c6bfabe4f9c2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin peercaching and getconfigurationflags



Gets the configuration flags that determine if the computer serves content to peers and can download content from peers.

## Syntax

```
bitsadmin /PeerCaching /GetConfigurationFlags <Job> 
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples

The following example gets the configuration flags for the job named *myJob*.
```
C:\> Bitsadmin /PeerCaching /GetConfigurationFlags myJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)