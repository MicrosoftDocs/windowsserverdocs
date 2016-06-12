---
title: dfsdiag
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0891e67-0187-4f18-923d-5623e6127f90
---
# dfsdiag
The `dfsdiag` command provides diagnostic information for DFS Namespaces.

## Syntax

```
dfsdiag [ /TestDCs [/Domain:<Domain name>]| /TestSites </Machine:<server name>| /DFSpath:<namespace root or DFS folder> [/Recurse]> [/Full] | /TestDFSConfig /DFSRoot:<namespace> | /TestDFSIntegrity /DFSRoot:<DFS root path> [/Recurse] [/Full] | /TestReferral /DFSpath:<DFS path for getting referrals> [/Full] | /?]

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|[dfsdiag TestDCs](dfsdiag/dfsdiag-testdcs.md)|Checks domain controller configuration.|
|[dfsdiag TestSites](dfsdiag/dfsdiag-testsites.md)|Checks site associations.|
|[dfsdiag TestDFSConfig](dfsdiag/dfsdiag-testdfsconfig.md)|Checks DFS Namespace configuration.|
|[dfsdiag TestDFSIntegrity](dfsdiag/dfsdiag-testdfsintegrity.md)|Checks DFS Namespace integrity.|
|[dfsdiag TestReferral](dfsdiag/dfsdiag-testreferral.md)|Checks referral responses.|
|\/?|Displays help at the command prompt.|

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)


