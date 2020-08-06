---
title: dfsdiag testdfsconfig
description: Reference article for the dfsdiag testdfsconfig, which checks the configuration of a Distributed File System (DFS) namespace.
ms.topic: article
ms.assetid: 106aeeb9-ea79-4e6e-829c-eca06309bab2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# dfsdiag testdfsconfig

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of a Distributed File System (DFS) namespace by performing the following actions:

- Verifies that the DFS Namespace service is running and that its  startup type is set to **Automatic** on all namespace servers.

- Verifies that the DFS registry configuration is consistent among namespace servers.

- Validates the following dependencies on clustered namespace servers:

  - Namespace root resource dependency on network name resource.

  - Network name resource dependency on IP address resource.

  - Namespace root resource dependency on physical disk resource.

## Syntax

```
dfsdiag /testdfsconfig /DFSroot:<namespace>
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| /DFSroot:`<namespace>` | The namespace (DFS root) to diagnose. |

## Examples

To verify the configuration of Distributed File System (DFS) namespaces in *contoso.com\MyNamespace*, type:

```
dfsdiag /testdfsconfig /DFSroot:\contoso.com\MyNamespace
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [dfsdiag command](dfsdiag.md)
