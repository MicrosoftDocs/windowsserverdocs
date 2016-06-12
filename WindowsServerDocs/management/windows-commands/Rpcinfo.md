---
title: rpcinfo
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c342232-a8f0-42ff-8f11-d18c4981f5ca
---
# rpcinfo
lists programs on remote computers. The **rpcinfo** command\-line utility makes a remote procedure call \(RPC\) to an RPC server and reports what it finds. for examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
rpcinfo [/p [<Node>]] [/b <Program version>] [/t <Node Program> [<version>]] [/u <Node Program> [<version>]]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/p \[<Node>\]|lists all programs registered with the port mapper on the specified host. if you do not specify a node \(computer\) name, the program queries the port mapper on the local host.|
|\/b <Program version>|Requests a response from all network nodes that have the specified program and version registered with the port mapper. You must specify both a program name or number and a version number.|
|\/t <Node Program> \[<version>\]|Uses the TCP transport protocol to call the specified program. You must specify both a node \(computer\) name and a program name. if you do not specify a version, the program calls all versions.|
|\/u <Node Program> \[<version>\]|Uses the UDP transport protocol to call the specified program. You must specify both a node \(computer\) name and a program name. if you do not specify a version, the program calls all versions.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To list all programs registered with the port mapper, type:

```
rpcinfo /p [<Node>]
```

To request a response from network nodes that have a specified program, type:

```
rpcinfo /b <Program version>
```

To use Transmission Control Protocol \(TCP\) to call a program, type:

```
rpcinfo /t <Node Program> [<version>]
```

Use User Datagram Protocol \(UDP\) to call a program:

```
rpcinfo /u <Node Program> [<version>]
```

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)


