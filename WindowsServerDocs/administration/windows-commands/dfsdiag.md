---
title: dfsdiag
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0891e67-0187-4f18-923d-5623e6127f90
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsdiag

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The `dfsdiag` command provides diagnostic information for DFS Namespaces.
## Syntax
```
dfsdiag [ /TestDCs [/Domain:<Domain name>]| /TestSites </Machine:<server name>| /DFSpath:<namespace root or DFS folder> [/Recurse]> [/Full] | /TestDFSConfig /DFSRoot:<namespace> | /TestDFSIntegrity /DFSRoot:<DFS root path> [/Recurse] [/Full] | /TestReferral /DFSpath:<DFS path for getting referrals> [/Full] | /?]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[dfsdiag TestDCs](dfsdiag-testdcs.md)|Checks domain controller configuration.|
|[dfsdiag TestSites](dfsdiag-testsites.md)|Checks site associations.|
|[dfsdiag TestDFSConfig](dfsdiag-testdfsconfig.md)|Checks DFS Namespace configuration.|
|[dfsdiag TestDFSIntegrity](dfsdiag-testdfsintegrity.md)|Checks DFS Namespace integrity.|
|[dfsdiag TestReferral](dfsdiag-testreferral.md)|Checks referral responses.|
|/?|Displays help at the command prompt.|
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
