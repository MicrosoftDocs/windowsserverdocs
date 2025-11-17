---
title: dfsdiag
description: Reference article for the dfsdiag command, which provides diagnostic information for DFS Namespaces.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# dfsdiag

Provides diagnostic information for DFS Namespaces.

## Syntax

```
dfsdiag /testdcs [/domain:<domain name>]
dfsdiag /testsites </machine:<server name>| /DFSPath:<namespace root or DFS folder> [/recurse]> [/full]
dfsdiag /testdfsconfig /DFSRoot:<namespace>
dfsdiag /testdfsintegrity /DFSRoot:<DFS root path> [/recurse] [/full]
dfsdiag /testreferral /DFSpath:<DFS path to get referrals> [/full]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [dfsdiag testdcs](dfsdiag-testdcs.md) | Checks domain controller configuration. |
| [dfsdiag testsites](dfsdiag-testsites.md) | Checks site associations. |
| [dfsdiag testdfsconfig](dfsdiag-testdfsconfig.md) | Checks DFS Namespace configuration. |
| [dfsdiag testdfsintegrity](dfsdiag-testdfsintegrity.md) | Checks DFS Namespace integrity. |
| [dfsdiag testreferral](dfsdiag-testreferral.md) | Checks referral responses. |
| /? | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
