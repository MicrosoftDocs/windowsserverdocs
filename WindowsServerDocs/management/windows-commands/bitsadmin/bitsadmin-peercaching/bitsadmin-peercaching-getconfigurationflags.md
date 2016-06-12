---
title: bitsadmin peercaching and getconfigurationflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 124ddc15-3444-4bd5-96e5-c6bfabe4f9c2
---
# bitsadmin peercaching and getconfigurationflags
Gets the configuration flags that determine if the computer serves content to peers and can download content from peers.

## Syntax

```
bitsadmin /PeerCaching /GetConfigurationFlags <Job> 
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## <a name="BKMK_examples"></a>Examples
The following example gets the configuration flags for the job named *myJob*.

```
C:\> bitsadmin /PeerCaching /GetConfigurationFlags myJob
```

## additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


