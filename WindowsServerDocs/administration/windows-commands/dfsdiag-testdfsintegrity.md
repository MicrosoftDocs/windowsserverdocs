---
title: dfsdiag TestDFSIntegrity
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 173ee832-26e1-4ec8-a23a-38a7d6229ac3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsdiag TestDFSIntegrity

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the integrity of the Distributed File System \(DFS\) namespace by performing the following tests:  
  
-   Checks for DFS metadata corruption or inconsistencies between domain controllers.  
  
-   Validates the configuration of access\-based enumeration to ensure that it is consistent between DFS metadata and the namespace server share.  
  
-   Detects overlapping DFS folders \(links\), duplicate folders, and folders with overlapping folder targets.  
  
  
  
## Syntax  
  
```  
dfsdiag /TestDFSIntegrity /DFSRoot:<DFS root path> [/Recurse] [/Full]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|\/DFSRoot:<DFS root path>|The DFS namespace to diagnose.|  
|\/Recurse|Performs the testing including the namespace interlinks.|  
|\/Full|verifies the consistency of share and NTFS Acls and client side configuration on all folder targets. It also verifies that the online property is set.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsdiag /TestDFSIntegrity /DFSRoot:\\Contoso.com\MyNamespace /Recurse /Full  
```  
  
## additional references  
  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [dfsdiag](dfsdiag.md)  
  

