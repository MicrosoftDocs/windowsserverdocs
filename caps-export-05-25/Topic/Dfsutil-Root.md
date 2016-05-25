---
title: Dfsutil Root
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4f02614-9edc-4e2d-8152-1d9ae6af5e49
author: JasonGerend
robots: noindex,nofollow
---
# Dfsutil Root
The **dfsutil root** command displays information about the namespace root. Dfsutil Root commands support creating, removing, importing or exporting namespace roots.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil root <\\server\share> [Verbose] | AddDom | AddStd | Remove | Export | Import | ForceSync | /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<\\\\server\\share>|UNC path to the namespace.|  
|Verbose|Displays additional information while the command runs.|  
|[Dfsutil Root AddDom](../Topic/Dfsutil-Root-AddDom.md)|Creates a new domain\-based namespace.|  
|[Dfsutil Root AddStd](../Topic/Dfsutil-Root-AddStd.md)|Creates a new stand\-alone namespace.|  
|[Dfsutil Root Remove](../Topic/Dfsutil-Root-Remove.md)|Removes the namespace.|  
|[Dfsutil Root Export](../Topic/Dfsutil-Root-Export.md)|Exports the namespace configuration to a file.|  
|[Dfsutil Root Import](assetId:///9cb2ddd0-b237-4301-a310-b711acf06b22)|Imports the namespace from another namespace or a file.|  
|[Dfsutil Root ForceSync](assetId:///01b9e7a4-fcc1-475c-ab59-0da4d419c240)|Perform a Forced sync on the target of a namespace.|  
|\/?|Displays help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsutil root \\contoso.com\DomainNamespace1  
```  
  
To TBD, type:  
  
```  
dfsutil root \\SRV1\StandaloneNameSpace2  
```  
  
To enable verbose logging for this command, type:  
  
```  
dfsutil root \\SRV1\StandaloneNameSpace2 verbose  
```  
  
To view help for this command, type:  
  
```  
Dfsutil root /?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
