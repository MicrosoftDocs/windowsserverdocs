---
title: Dfsutil Root AddStd
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95d2ea1e-2467-405a-9f85-987a4660fcb4
author: JasonGerend
---
# Dfsutil Root AddStd
The **dfsutil root addstd** command creates a new stand\-alone namespace.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil root addstd <\\server\share> [<Comment>] | /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<\\\\server\\share>|UNC path to the namespace on the namespace server.|  
|<Comment>|Specifies an administrator comment for the namespace.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
Create the share on the namespace server before running this command.  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsutil root addstd \\SRV1\StandaloneNamesapce1 "Standalone Root"  
```  
  
To TBD, type:  
  
```  
dfsutil root addstd \\SRV2\StandaloneNamesapce2  
```  
  
To view help for this command, type:  
  
```  
dfsutil root addstd /?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil Root](../Topic/Dfsutil-Root.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
