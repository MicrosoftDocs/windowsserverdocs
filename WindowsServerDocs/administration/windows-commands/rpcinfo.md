---
title: rpcinfo
description: Learn how to list the programs on a remote computer.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c342232-a8f0-42ff-8f11-d18c4981f5ca
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# rpcinfo

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Lists programs on remote computers. The **rpcinfo** command-line utility makes a remote procedure call (RPC) to an RPC server and reports what it finds. 

## Syntax
```
rpcinfo [/p [<Node>]] [/b <Program version>] [/t <Node Program> [<version>]] [/u <Node Program> [<version>]]
```

### Parameters
|Parameter|Description|
|-------|--------|
|/p [\<Node>]|lists all programs registered with the port mapper on the specified host. If you do not specify a node (computer) name, the program queries the port mapper on the local host.|
|/b \<Program version>|Requests a response from all network nodes that have the specified program and version registered with the port mapper. You must specify both a program name or number and a version number.|
|/t \<Node Program> [\<version>]|Uses the TCP transport protocol to call the specified program. You must specify both a node (computer) name and a program name. If you do not specify a version, the program calls all versions.|
|/u \<Node Program> [\<version>]|Uses the UDP transport protocol to call the specified program. You must specify both a node (computer) name and a program name. If you do not specify a version, the program calls all versions.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To list all programs registered with the port mapper, type:
```
rpcinfo /p [<Node>]
```
To request a response from network nodes that have a specified program, type:
```
rpcinfo /b <Program version>
```
To use Transmission Control Protocol (TCP) to call a program, type:
```
rpcinfo /t <Node Program> [<version>]
```
Use User Datagram Protocol (UDP) to call a program:
```
rpcinfo /u <Node Program> [<version>]
```

## Additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
