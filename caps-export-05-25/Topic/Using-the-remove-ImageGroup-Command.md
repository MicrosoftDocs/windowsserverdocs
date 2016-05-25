---
title: Using the remove-ImageGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b2c9813-5df2-4272-8449-26f3bb16f82b
---
# Using the remove-ImageGroup Command
Removes an image group from a server.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Remove-ImageGroup /ImageGroup:<Image group name> [/Server:<Server name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/ImageGroup:<Image group name>|Specifies the name of the image group to be removed|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
  
## <a name="BKMK_examples"></a>Examples  
To remove the image group, type one of the following:  
  
```  
WDSUTIL /Remove-ImageGroup /ImageGroup:ImageGroup1  
WDSUTIL /Verbose /Remove-ImageGroup /ImageGroup:"My Image Group" /Server:MyWDSServer   
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-ImageGroup Command](../Topic/Using-the-add-ImageGroup-Command.md)  
  
[Using the get-AllImageGroups Command](../Topic/Using-the-get-AllImageGroups-Command.md)  
  
[Using the get-ImageGroup Command](../Topic/Using-the-get-ImageGroup-Command.md)  
  
[Subcommand: set-ImageGroup](../Topic/Subcommand--set-ImageGroup.md)  
  
