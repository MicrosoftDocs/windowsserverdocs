---
title: Dfsutil Link
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec462af0-2f81-4671-99c2-cd3d8523e44a
author: JasonGerend
robots: noindex,nofollow
---
# Dfsutil Link
The **dfsutil link** command displays the information about the link\(folder\) and link\(folder\) targets.Link commands are used to create a new link, delete a link or move the links.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil link <DfsPath> | add | Remove | move | /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<DfsPath>|UNC path of the link.|  
|[Dfsutil Link Add](assetId:///76205257-121c-40d3-8030-9dc575aa809f)|Creates a new folder.|  
|[Dfsutil Link Remove](assetId:///d168f210-0ca3-422e-b5fa-8c56b15d751e)|Removes the specified folder.|  
|[Dfsutil Link Move](assetId:///5d17b72d-68ee-4b8a-90a1-cead0b21ee9f)|Moves the folder to another location in the namespace.|  
|\/?||  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsutil link \\contoso.com\DomainNamespace1\Link1  
```  
  
To TBD, type:  
  
```  
dfsutil link \\SRV1\StandaloneNamespace1\Link1  
```  
  
To view help for this command, type:  
  
```  
Dfsutil link /?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
