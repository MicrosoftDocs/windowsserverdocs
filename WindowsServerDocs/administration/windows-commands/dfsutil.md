---
title: dfsutil
description: Reference article for the dfsutil command, which manages DFS Namespaces, servers and clients.
ms.topic: reference
ms.assetid: ef5093a4-0d24-4b21-9d04-59933ad98e2c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# dfsutil

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The dfsutil command manages DFS Namespaces, servers, and clients.

## Functionality available in PowerShell

The [DFSN](/powershell/module/dfsn/) PowerShell module provides equivalent functionality to the following dfsutil parameters.

| Parameter | Description |
| --------- | ----------- |
| root | Displays, creates, removes, imports, exports namespace roots. |
| link | Displays, creates, removes, or moves folders (links). |
| target | Displays, create, remove folder target or namespace server. |
| property | Displays or modifies a folder target or namespace server. |
| server | Displays or modifies namespace configuration. |
| domain | Displays all domain-based namespaces in a domain. |

## Functionality available only in dfsutil

The following functionality is available only as dfsutil parameters:

| Parameter | Description |
| --------- | ----------- |
| client | Displays or modifies client information or registry keys. |
| diag | Perform diagnostics or view dfsdirs/dfspath. |
| cache | Displays or flushes the client cache. |

For more info about each of these commands, open a command prompt on a server with the DFS Namespaces management tools installed, and then type `dfsutil client /?`, `dfsutil diag /?`, or `dfsutil cache /?`.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
