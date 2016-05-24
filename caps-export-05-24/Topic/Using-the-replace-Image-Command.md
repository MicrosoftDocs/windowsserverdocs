---
title: Using the replace-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68ded3df-e309-420f-9f5d-caeb609385a5
---
# Using the replace-Image Command
Replaces an existing image with a new version of that image.  
  
## Syntax  
For boot images:  
  
```  
WDSUTIL [Options] /Replace-Image /Image:<Image name> [/Server:<Server name>]  
     /ImageType:Boot  
     /Architecture:{x86 | ia64 | x64}  
     [/Filename:<File name>]  
     /ReplacementImage  
         /ImageFile:<wim file path>  
         [/Name:<Image name>]  
         [/Description:<Image description>]  
```  
  
For install images:  
  
```  
WDSUTIL [Options] /Replace-Image /Image:<Image name> [/Server:<Server name>]  
     /ImageType:Install  
     [/ImageGroup:<Image group name>]  
     [/Filename:<File name>]  
     /ReplacementImage  
         /ImageFile:<wim file path>  
         [/SourceImage:<Source image name>]  
         [/Name:<Image name>]  
         [/Description:<Image description>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image to be replaced.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/ImageType:{Boot &#124; Install}|Specifies the type of image to be replaced.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be replaced. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is replaced.|  
|\[\/Filename:<File name>\]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|  
|\/ReplacementImage|Specifies the settings for the replacement image. You set these settings using the following options:<br /><br />-   \/ImageFile: <file path> \- Specifies the name and location \(full path\) of the new .wim file.<br />-   \[\/SourceImage: <image name>\] \- Specifies the image to be used if the .wim file contains multiple images. This option applies only to install images.<br />-   \[\/Name:<Image name>\] – Sets the display name of the image.<br />-   \[\/Description:<Image description>\] \- Sets the description of the image.|  
  
## <a name="BKMK_examples"></a>Examples  
To replace a boot image, type one of the following:  
  
```  
WDSUTIL /Replace-Image /Image:"WinPE Boot Image" /ImageType:Boot /Architecture:x86 /ReplacementImage /ImageFile:"C:\MyFolder\Boot.wim"  
WDSUTIL /Verbose /Progress /Replace-Image /Image:"WinPE Boot Image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /Filename:boot.wim   
/ReplacementImage /ImageFile:\\MyServer\Share\Boot.wim /Name:"My WinPE Image" /Description:"WinPE Image with drivers"  
```  
  
To replace an install image, type one of the following:  
  
```  
WDSUTIL /Replace-Image /Image:"Windows Vista Home" /ImageType:Install /ReplacementImage /ImageFile:"C:\MyFolder\Install.wim"  
WDSUTIL /Verbose /Progress /Replace-Image /Image:"Windows Vista Pro" /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1   
/Filename:Install.wim /ReplacementImage /ImageFile:\\MyServer\Share \Install.wim /SourceImage:"Windows Vista Ultimate" /Name:"Windows Vista Desktop" /Description:"Windows Vista Ultimate with standard business applications."  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-Image Command](../Topic/Using-the-add-Image-Command.md)  
  
[Using the copy-Image Command](../Topic/Using-the-copy-Image-Command.md)  
  
[Using the Export-Image Command](../Topic/Using-the-Export-Image-Command.md)  
  
[Using the get-Image Command](../Topic/Using-the-get-Image-Command.md)  
  
[Using the replace-Image Command](../Topic/Using-the-replace-Image-Command.md)  
  
[Subcommand: set-Image](../Topic/Subcommand--set-Image.md)  
  
