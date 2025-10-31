---
title: dfsdiag testdfsintegrity
description: Reference article for the dfsdiag testdfsintegrity command, which checks the integrity of the Distributed File System (DFS) namespace.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# dfsdiag testdfsintegrity



Checks the integrity of the Distributed File System (DFS) namespace by performing the following tests:

- Checks for DFS metadata corruption or inconsistencies between domain controllers.

- Validates the configuration of access-based enumeration to ensure that it is consistent between DFS metadata and the namespace server share.

- Detects overlapping DFS folders (links), duplicate folders, and folders with overlapping folder targets.

## Syntax

```
dfsdiag /testdfsintegrity /DFSroot: <DFS root path> [/recurse] [/full]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /DFSroot: `<DFS root path>` | The DFS namespace to diagnose. |
| /recurse | Performs the testing, including any namespace interlinks. |
| /full | Verifies the consistency of the share and NTFS ACLs, along with the client side configuration on all folder targets. It also verifies that the online property is set. |

## Examples

To verify the integrity and consistency of the Distributed File System (DFS) namespaces in *contoso.com\MyNamespace*, including any interlinks, type:

```
dfsdiag /testdfsintegrity /DFSRoot:\contoso.com\MyNamespace /recurse /full
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [dfsdiag command](dfsdiag.md)
