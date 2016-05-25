---
title: Dfsutil Diag
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bd59960-d535-4512-9ae5-b9ffc1661f6d
author: JasonGerend
robots: noindex,nofollow
---
# Dfsutil Diag
The **dfsutil diag** command performs diagnostics on a DFS namespace.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil diag | clean <\\server\share> [Verbose] |unmapdomroot <\\domain\root>  <\\rootreplica\share> [Verbose] | viewdfsdirs <drive> [removereparse] [Verbose] | viewdfspath <DfsPath> | /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|[Dfsutil Diag UnMapDomRoot](assetId:///b90ff744-e051-453b-91bd-5dd4d45156fc)|Deletes obsolete references to a domain\-based root target.|  
|[Dfsutil Diag Clean](assetId:///ef3dcae6-839d-4be9-84c0-19f5a325b30b)|Removes reference to an obsolete root from host machine.|  
|[Dfsutil Diag Viewdfsdirs](assetId:///8cb83576-477d-48cd-8eb0-fd29473636e5)|List\/Remove all DFS reparse directories in a volume.|  
|[Dfsutil Diag Viewdfspath](assetId:///c46a8ca7-7ce6-4fdd-b6be-e8902763e146)|Resolves a DfsPath to a destination UNC path.|  
|\/?|Displays help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
Dfsutil diag  
```  
  
To view help for this command, type:  
  
```  
dfsutil diag/?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
