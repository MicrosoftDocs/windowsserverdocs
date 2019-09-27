---
title: dfsdiag TestSites
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39a0d415-7eb7-4a26-861b-7ff00c45dcda
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsdiag TestSites

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of active directory Domain Services \(AD DS\) sites by verifying that servers that act as namespace servers or folder \(link\) targets have the same site associations on all domain controllers.  
  
  
  
## Syntax  
  
```  
dfsdiag /TestSites </Machine:<server name>| /DFSpath:<namespace root or DFS folder> [/Recurse]> [/Full]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|\/Machine:<server name>|The name of the server on which to verify the site association.|  
|\/DFSpath:<namespace root or DFS folder>|The namespace root or Distributed File System \(DFS\) folder \(link\) with targets for which to verify the site association.|  
|\/Recurse|Enumerates and verifies the site associations for all folder targets under the specified namespace root.|  
|\/Full|verifies that AD DS and the registry of the server contain the same site association information.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsdiag /TestSites /Machine:MyServer  
```  
  
To TBD, type:  
  
```  
dfsdiag /TestSites /DFSpath:\\Contoso.com\Namespace1\Folder1 /Full  
```  
  
To TBD, type:  
  
```  
dfsdiag /TestSites /DFSpath:\\Contoso.com\Namespace2 /Recurse /Full  
```  
  
## additional references  
  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [dfsdiag](dfsdiag.md)  
  

