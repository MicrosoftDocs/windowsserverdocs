---
title: dfsutil
description: Windows Commands topic for dfsutil, which manages DFS Namespaces, servers and clients. dfsutil commands use the original Distributed File System terminology, with updated DFS Namespaces terminology provided as explanation for most commands.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: ef5093a4-0d24-4b21-9d04-59933ad98e2c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsutil

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The dfsutil command manages DFS Namespaces, servers and clients.

>[!NOTE]
>The **DFS Namespaces PowerShell module** provides replacements for some of the Dfsutil parameters, while others still require you to use dfsutil. For more information about the updated PowerShell equivalents, see [DFSN](https://docs.microsoft.com/en-us/powershell/module/dfsn/?view=win10-ps).

## Parameters available in PowerShell

You can use the following parameters from PowerShell:

| Parameter | Description |
| --------- | ----------- |
| root | Displays, creates, removes, imports, exports namespace roots. |
| link | Displays, creates, removes, or moves folders (links). |
| target | Displays, create, remove folder target or namespace server. |
| property | Displays or modifies a folder target or namespace server. |
| server | Displays or modifies namespace configuration. |
| domain | Displays all domain-based namespaces in a domain. |

## Parameters only available in dfsutil

You can use the following parameters only from dfsutil.

| Parameter | Description |
| --------- | ----------- |
| client | Displays or modifies client information or registry keys. |
| diag | Perform diagnostics or view dfsdirs/dfspath. |
| cache | Displays or flushes the client cache. |

For more info about each of these commands, open a command prompt on a server with the DFS Namespaces management tools installed, and then type `dfsutil client /?`, `dfsutil diag /?`, or `dfsutil cache /?`.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)