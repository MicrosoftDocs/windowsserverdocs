---
title: Using the remove-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce5e2384-2264-4b22-92af-74eec8c10ae0
---
# Using the remove-Image Command
Deletes an image from a server.  
  
## Syntax  
For boot images:  
  
```  
WDSUTIL [Options] /Remove-Image /Image:<Image name> [/Server:<Server name>] /ImageType:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<Filename>]  
```  
  
For install images:  
  
```  
WDSUTIL [Options] /Remove-Image /Image:<Image name> [/Server:<Server name>] /ImageType:Install [/ImageGroup:<Image group name>] [/Filename:<Filename>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/ImageType:{Boot &#124; Install}|Specifies the type of image.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture value ensures that the correct image will be removed.|  
|\[\/ImageGroup:<Image group name>\]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists, you must use this option to specify the image group.|  
|\[\/Filename:<File name>\]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|  
  
## <a name="BKMK_examples"></a>Examples  
To remove a boot image, type:  
  
```  
WDSUTIL /Remove-Image /Image:"WinPE Boot Image" /ImageType:Boot /Architecture:x86  
```  
  
```  
WDSUTIL /Verbose /Remove-Image /Image:"WinPE Boot Image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /Filename:boot.wim  
```  
  
To remove an install image, type:  
  
```  
WDSUTIL /Remove-Image /Image:"Windows Vista with Office" /ImageType:Install  
```  
  
```  
WDSUTIL /Verbose /Remove-Image /Image:"Windows Vista with Office" /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1 /Filename:install.wim  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-Image Command](../Topic/Using-the-add-Image-Command.md)  
  
[Using the copy-Image Command](../Topic/Using-the-copy-Image-Command.md)  
  
[Using the Export-Image Command](../Topic/Using-the-Export-Image-Command.md)  
  
[Using the get-Image Command](../Topic/Using-the-get-Image-Command.md)  
  
[Using the replace-Image Command](../Topic/Using-the-replace-Image-Command.md)  
  
[Subcommand: set-Image](../Topic/Subcommand--set-Image.md)  
  
