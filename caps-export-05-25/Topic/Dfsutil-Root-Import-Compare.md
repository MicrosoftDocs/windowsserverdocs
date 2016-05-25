---
title: Dfsutil Root Import Compare
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 10928e05-e635-48a1-b60d-ab8393640e55
author: JasonGerend
---
# Dfsutil Root Import Compare
The **dfsutil root import compare** command compares a namespace on one server with the namespace configuration on another server or in a file.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil root import compare <\\srcserver\share>|<filename> <\\destserver\share> [Verbose] /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<\\\\srcserver\\share>|UNC path to the namespace on the first namespace server that you want to compare.|  
|<\\\\destserver\\share>|UNC path to the namespace on the second namespace server that you want to compare.|  
|<filename>|Name of the XML file that contains the namespace configuration that you want to compare.|  
|Verbose|Displays detailed status of the import process|  
|\/?|Displays help at the command prompt.|  
  
## Remarks <optional section>  
<Insert command specific to remarks here.>  
  
## Scripting <optional section>  
<Here is where you discuss using the command within a script. You should also provide an FWLink to the Script Center.>  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsutil root import compare \\contoso.com\NameSpace1 \\contoso.com\NameSpace2  
```  
  
To TBD, type:  
  
```  
dfsutil root import compare C:\dir1\docroot.txt \\SRV1\StandaloneNamespace1  
```  
  
To enable verbose logging for this command, type:  
  
```  
dfsutil root import compare \\contoso.com\NameSpace1 \\contoso.com\NameSpace2 /v  
```  
  
To view help for this command, type:  
  
```  
dfsutil root import compare /?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil Root Import](assetId:///9cb2ddd0-b237-4301-a310-b711acf06b22)  
  
-   [Dfsutil Root](../Topic/Dfsutil-Root.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
