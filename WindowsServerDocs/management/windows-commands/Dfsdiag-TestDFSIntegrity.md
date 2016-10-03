---
title: Dfsdiag TestDFSIntegrity
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 173ee832-26e1-4ec8-a23a-38a7d6229ac3 JasonGerend
---
# Dfsdiag TestDFSIntegrity
Checks the integrity of the Distributed File System \(DFS\) namespace by performing the following tests:  
  
-   Checks for DFS metadata corruption or inconsistencies between domain controllers.  
  
-   Validates the configuration of access\-based enumeration to ensure that it is consistent between DFS metadata and the namespace server share.  
  
-   Detects overlapping DFS folders \(links\), duplicate folders, and folders with overlapping folder targets.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
DFSDiag /TestDFSIntegrity /DFSRoot:<DFS root path> [/Recurse] [/Full]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/DFSRoot:<DFS root path>|The DFS namespace to diagnose.|  
|\/Recurse|Performs the testing including the namespace interlinks.|  
|\/Full|Verifies the consistency of share and NTFS ACLs and client side configuration on all folder targets. It also verifies that the Online property is set.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
DFSDiag /TestDFSIntegrity /DFSRoot:\\Contoso.com\MyNamespace /Recurse /Full  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
-   [Dfsdiag](Dfsdiag.md)  
  

