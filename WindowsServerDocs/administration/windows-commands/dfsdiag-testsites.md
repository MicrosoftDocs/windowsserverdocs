---
title: dfsdiag TestSites
description: Reference topic for dfsdiag TestSites, which checks the configuration of active directory Domain Services (AD DS) sites by verifying that servers that act as namespace servers or folder (link) targets have the same site associations on all domain controllers. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 39a0d415-7eb7-4a26-861b-7ff00c45dcda
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsdiag TestSites

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of active directory Domain Services (AD DS) sites by verifying that servers that act as namespace servers or folder (link) targets have the same site associations on all domain controllers.

## Syntax  
  
```  
dfsdiag /TestSites </Machine:<server name>| /DFSpath:<namespace root or DFS folder> [/Recurse]> [/Full]  
```  
  
#### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|\/Machine:<server name>|The name of the server on which to verify the site association.|  
|\/DFSpath:<namespace root or DFS folder>|The namespace root or Distributed File System (DFS) folder (link) with targets for which to verify the site association.|  
|\/Recurse|Enumerates and verifies the site associations for all folder targets under the specified namespace root.|  
|\/Full|verifies that AD DS and the registry of the server contain the same site association information.|  
  
## Examples  
  
```  
dfsdiag /TestSites /Machine:MyServer  
```  
 
```  
dfsdiag /TestSites /DFSpath:\\Contoso.com\Namespace1\Folder1 /Full  
```  
  
```  
dfsdiag /TestSites /DFSpath:\\Contoso.com\Namespace2 /Recurse /Full  
```  
  
## Additional References  
  
-   - [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [dfsdiag](dfsdiag.md)  
  

