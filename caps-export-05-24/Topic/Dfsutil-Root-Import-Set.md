---
title: Dfsutil Root Import Set
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 354b42d9-46f5-4c33-8262-d606f1326b09
---
# Dfsutil Root Import Set
The **dfsutil root import set** command  imports folders, folder targets and configuration information for a namespace from a file or another namespace and overwrites existing folders and folder targets.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
dfsutil root import set <\\srcserver\share>|<filename> <\\destserver\share> [NoBackup] [Verbose] | /?  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<\\\\srcserver\\share>|UNC path to the namespace from which you want to import the configuration.|  
|<\\\\destserver\\share>|UNC path to the namespace to which you want to import the configuration.|  
|<filename>|Name of the xml file from which you want to import the namespace configuration.|  
|NoBackup|Does not create backup file to restore overwritten folders and folder targets.|  
|Verbose|Displays detailed status of the import process.|  
|\/?|Displays help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
dfsutil root import set \\contoso.com\Namespace1 \\contoso.com\Namespace2  
```  
  
To TBD, type:  
  
```  
dfsutil root import set C:\dir\docroot.txt \\SRV1\StandaloneNamespace NoBackup  
```  
  
To enable verbose logging for this command, type:  
  
```  
dfsutil root import set verbose \\contoso.com\Namespace1 \\contoso.com\Namespace2  
```  
  
To view help for this command, type:  
  
```  
dfsutil root import set /?  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsutil Root Import](assetId:///9cb2ddd0-b237-4301-a310-b711acf06b22)  
  
-   [Dfsutil Root](../Topic/Dfsutil-Root.md)  
  
-   [Dfsutil](../Topic/Dfsutil.md)  
  
