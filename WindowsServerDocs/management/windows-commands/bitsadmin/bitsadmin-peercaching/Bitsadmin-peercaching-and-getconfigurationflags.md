---
title: Bitsadmin peercaching and getconfigurationflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 124ddc15-3444-4bd5-96e5-c6bfabe4f9c2
---
# Bitsadmin peercaching and getconfigurationflags
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
C:\> Bitsadmin /PeerCaching /GetConfigurationFlags myJob
```

## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)


