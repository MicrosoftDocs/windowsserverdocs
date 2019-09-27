---
title: bitsadmin peercaching and setconfigurationflags
description: "Windows Commands topic for **bitsadmin peercaching and setconfigurationflags** - 
Sets the configuration flags that determine if the computer can serve content to peers and can download content from peers."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ff0a2b49-66e3-4d40-824c-6a3816055d2e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin peercaching and setconfigurationflags



Sets the configuration flags that determine if the computer can serve content to peers and can download content from peers.

## Syntax

```
bitsadmin /PeerCaching /SetConfigurationFlags <Job> <Value>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|Value|The value is an unsigned integer with the following interpretation for the bits in the binary representation:</br>-   Allow the job's data to be downloaded from a peer: Set the least significant bit</br>-   Allow the job's data to be served to peers: Set the 2nd bit from the right.|

## <a name="BKMK_examples"></a>Examples

The following example specifies the job's data to be downloaded from peers for the job named *myJob*.
```
C:\> Bitsadmin /PeerCaching /SetConfigurationFlags myJob 1
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)