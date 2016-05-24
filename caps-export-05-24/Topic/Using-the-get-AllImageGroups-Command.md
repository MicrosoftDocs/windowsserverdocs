---
title: Using the get-AllImageGroups Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ca06533-bcf5-4590-ac8e-263d6c9874f8
---
# Using the get-AllImageGroups Command
Retrieves information about all image groups on a server and all images in those image groups.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Get-AllImageGroups [/Server:<Server name>] [/Detailed]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\[\/Detailed\]|Returns the image metadata from each image. If this parameter is not used, the default behavior is to return only the image name, description, and file name for each image.|  
  
## <a name="BKMK_examples"></a>Examples  
To view information about the image groups, type one of the following:  
  
```  
WDSUTIL /Get-AllImageGroups  
WDSUTIL /Verbose /Get-AllImageGroups /Server:MyWDSServer /Detailed  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-ImageGroup Command](../Topic/Using-the-add-ImageGroup-Command.md)  
  
[Using the get-ImageGroup Command](../Topic/Using-the-get-ImageGroup-Command.md)  
  
[Using the remove-ImageGroup Command](../Topic/Using-the-remove-ImageGroup-Command.md)  
  
[Subcommand: set-ImageGroup](../Topic/Subcommand--set-ImageGroup.md)  
  
