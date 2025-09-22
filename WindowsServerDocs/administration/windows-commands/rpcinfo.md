---
title: rpcinfo
description: Reference article for the rpcinfo command, which lists the programs on a remote computer.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/11/2018
---

# rpcinfo



Lists programs on remote computers. The **rpcinfo** command-line utility makes a remote procedure call (RPC) to an RPC server and reports what it finds.

## Syntax

```
rpcinfo [/p [<node>]] [/b <program version>] [/t <node program> [<version>]] [/u <node program> [<version>]]
```

### Parameters

| Parameter | Description |
|--|--|
| /p `[<node>]` | lists all programs registered with the port mapper on the specified host. If you do not specify a node (computer) name, the program queries the port mapper on the local host. |
| /b `<program version>` | Requests a response from all network nodes that have the specified program and version registered with the port mapper. You must specify both a program name or number and a version number. |
| /t `<node program> [\<version>]` | Uses the TCP transport protocol to call the specified program. You must specify both a node (computer) name and a program name. If you do not specify a version, the program calls all versions. |
| /u `<node program> [\<version>]` | Uses the UDP transport protocol to call the specified program. You must specify both a node (computer) name and a program name. If you do not specify a version, the program calls all versions. |
| /? | Displays help at the command prompt. |

## Examples

To list all programs registered with the port mapper, type:

```
rpcinfo /p [<node>]
```

To request a response from network nodes that have a specified program, type:

```
rpcinfo /b <program version>
```

To use Transmission Control Protocol (TCP) to call a program, type:

```
rpcinfo /t <node program> [<version>]
```

Use User Datagram Protocol (UDP) to call a program:

```
rpcinfo /u <node program> [<version>]
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
