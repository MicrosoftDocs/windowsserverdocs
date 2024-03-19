---
title: dfsdiag testsites
description: Reference article for dfsdiag testsites, which checks the configuration of active directory Domain Services (AD DS) sites by verifying that servers that act as namespace servers or folder (link) targets have the same site associations on all domain controllers.
ms.topic: reference
ms.assetid: 39a0d415-7eb7-4a26-861b-7ff00c45dcda
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# dfsdiag testsites

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of active directory Domain Services (AD DS) sites by verifying that servers that act as namespace servers or folder (link) targets have the same site associations on all domain controllers.

## Syntax

```
dfsdiag /testsites </machine:<server name>| /DFSpath:<namespace root or DFS folder> [/recurse]> [/full]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `/machine:<server name>` | The name of the server on which to verify the site association. |
| `/DFSpath:<namespace root or DFS folder>` | The namespace root or Distributed File System (DFS) folder (link) with targets for which to verify the site association. |
| /recurse | Enumerates and verifies the site associations for all folder targets under the specified namespace root. |
| /full | Verifies that AD DS and the registry of the server contain the same site association information. |

## Examples

To check the site associations on *machine\MyServer*, type:

```
dfsdiag /testsites /machine:MyServer
```

To check a Distributed File System (DFS) folder to verify the site association, along with verifying that AD DS and the registry of the server contain the same site association information, type:

```
dfsdiag /TestSites /DFSpath:\\contoso.com\namespace1\folder1 /full
```

To check a namespace root to verify the site association, along with enumerating and verifying the site associations for all folder targets under the specified namespace root, and verifying that AD DS and the registry of the server contain the same site association information, type:

```
dfsdiag /testsites /DFSpath:\\contoso.com\namespace2 /recurse /full
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [dfsdiag command](dfsdiag.md)
