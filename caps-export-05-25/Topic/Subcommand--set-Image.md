---
title: Subcommand: set-Image
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ae03c86-7a13-4e38-9182-32e55fffd504
---
# Subcommand: set-Image
Changes the attributes of an image.  
  
## Syntax  
For boot images:  
  
```  
WDSUTIL /Set-Image /Image:<Image name> [/Server:<Server name>] /ImageType:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>] [/Name:<Name>]   
[/Description:<Description>] [/Enabled:{Yes | No}]  
```  
  
For install images:  
  
```  
WDSUTIL /Set-Image /Image:<Image name> [/Server:<Server name>]  
     /ImageType:Install [/ImageGroup:<Image group name>]  
     [/Filename:<File name>]  
     [/Name:<Name>]  
     [/Description:<Description>]  
     [/UserFilter:<SDDL>]  
     [/Enabled:{Yes | No}]  
     [/UnattendFile:<Unattend file path>]  
         [/OverwriteUnattend:{Yes | No}]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/ImageType:{Boot &#124; Install}|Specifies the type of image.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because you can have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is modified.|  
|\[\/Filename:<File name>\]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|  
|\[\/Name\]|Specifies the name of the image.|  
|\[\/Description:<Description>\]|Sets the description of the image.|  
|\[\/Enabled:{Yes &#124; No}\]|Enables or disables the image.|  
|\[\/ImageGroup:<Image group name>\]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists on the server, you must use this option to specify the image group.|  
|\[\/UserFilter:<SDDL>\]|Sets the user filter on the image. The filter string must be in Security Descriptor Definition Language \(SDDL\) format. Note that, unlike the **\/Security** option for image groups, this option only restricts who can see the image definition, and not the actual image file resources. To restrict access to the file resources, and therefore access to all images within an image group, you will need to set security for the image group itself.|  
|\[\/UnattendFile:<Unattend file path>\]|Sets the full path to the unattend file to be associated with the image. For example: **D:\\Files\\Unattend\\Img1Unattend.xml**|  
|\[\/OverwriteUnattend:{Yes &#124; No}\]|You can specify **\/Overwrite** to overwrite the unattend file if there is already an unattend file associated with the image. Note that the default setting is **No**.|  
  
## <a name="BKMK_examples"></a>Examples  
To set values for a boot image, type one of the following:  
  
```  
WDSUTIL /Set-Image /Image:"WinPE boot image" /ImageType:Boot /Architecture:x86 /Description:"New description"  
  
WDSUTIL /Verbose /Set-Image /Image:"WinPE boot image" /Server:MyWDSServer /ImageType:Boot /Architecture:x86 /Filename:boot.wim   
/Name:"New Name" /Description:"New Description" /Enabled:Yes  
```  
  
To set values for an install image, type one of the following:  
  
```  
WDSUTIL /Set-Image /Image:"Windows Vista with Office" /ImageType:Install /Description:"New description"   
  
WDSUTIL /Verbose /Set-Image /Image:"Windows Vista with Office" /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1   
/Filename:install.wim /Name:"New name" /Description:"New description" /UserFilter:"O:BAG:DUD:AI(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200a9;;;AU)" /Enabled:Yes /UnattendFile:\\server\share\unattend.xml /OverwriteUnattend:Yes  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-Image Command](../Topic/Using-the-add-Image-Command.md)  
  
[Using the copy-Image Command](../Topic/Using-the-copy-Image-Command.md)  
  
[Using the Export-Image Command](../Topic/Using-the-Export-Image-Command.md)  
  
[Using the get-Image Command](../Topic/Using-the-get-Image-Command.md)  
  
[Using the remove-Image Command](../Topic/Using-the-remove-Image-Command.md)  
  
[Using the replace-Image Command](../Topic/Using-the-replace-Image-Command.md)  
  
