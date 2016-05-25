---
title: Dfsdiag TestSites
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39a0d415-7eb7-4a26-861b-7ff00c45dcda
author: JasonGerend
---
# Dfsdiag TestSites
Checks the configuration of Active Directory Domain Services \(AD DS\) sites by verifying that servers that act as namespace servers or folder \(link\) targets have the same site associations on all domain controllers.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
DFSDiag /TestSites </Machine:<server name>| /DFSPath:<namespace root or DFS folder> [/Recurse]> [/Full]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Machine:<server name>|The name of the server on which to verify the site association.|  
|\/DFSPath:<namespace root or DFS folder>|The namespace root or Distributed File System \(DFS\) folder \(link\) with targets for which to verify the site association.|  
|\/Recurse|Enumerates and verifies the site associations for all folder targets under the specified namespace root.|  
|\/Full|Verifies that AD DS and the registry of the server contain the same site association information.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
DFSDiag /TestSites /Machine:MyServer  
```  
  
To TBD, type:  
  
```  
DFSDiag /TestSites /DFSPath:\\Contoso.com\Namespace1\Folder1 /Full  
```  
  
To TBD, type:  
  
```  
DFSDiag /TestSites /DFSPath:\\Contoso.com\Namespace2 /Recurse /Full  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
-   [Dfsdiag](Dfsdiag.md)  
  

