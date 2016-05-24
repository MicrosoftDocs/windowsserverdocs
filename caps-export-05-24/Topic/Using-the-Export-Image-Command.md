---
title: Using the Export-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9b8b467-0f2d-4754-8998-55503a262778
---
# Using the Export-Image Command
Exports an existing image from the image store to another Windows Image \(.wim\) file.  
  
## Syntax  
For boot images:  
  
```  
WDSUTIL [Options] /Export-Image /Image:<Image name> [/Server:<Server name>]  
     /ImageType:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>]  
     /DestinationImage  
         /Filepath:<File path and name>  
         [/Name:<Name>]  
         [/Description:<Description>]  
     [/Overwrite:{Yes | No}]  
```  
  
For install images:  
  
```  
WDSUTIL [Options] /Export-Image /Image:<Image name> [/Server:<Server name>]  
     /ImageType:Install [/ImageGroup:<Image group name>]  
     [/Filename:<File name>]  
     /DestinationImage  
         /Filepath:<File path and name>  
         [/Name:<Name>]  
         [/Description:<Description>]  
     [/Overwrite:{Yes | No | Append}]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image to be exported.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/ImageType:{Boot &#124; Install}|Specifies the type of image to be exported.|  
|\[\/ImageGroup:<Image group name>\]|Specifies the image group containing the image to be exported. If no image group name is specified and only one image group exists on the server, that image group will be used by default. If more than one image group exists on the server, the image group must be specified.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be exported. Because it is possible to have the same image name for boot images in different architectures, specifying the architecture value ensures that the correct image will be returned.|  
|\[\/Filename:<Filename>\]|If the image cannot be uniquely identified by name, the file name must be specified.|  
|\/DestinationImage|Specifies the settings for the destination image. You can specify these settings using the following options:<br /><br />-   \/FilePath:<File path and name> \- Specifies the full file path for the new image.<br />-   \[\/Name:<Name>\] \- Sets the display name of the image. If no name is specified, the display name of the source image will be used.<br />-   \[\/Description: <Description>\] \- Sets the description of the image.|  
|\[\/Overwrite:{Yes &#124; No &#124; Append}\]|Determines whether the file specified in the **\/DestinationImage** option will be overwritten if an existing file with that name already exists at the \/FilePath.<br /><br />-   **Yes** causes the existing file to be overwritten.<br />-   **No** \(the default option\) causes an error to occur if a file with the same name already exists.<br />-   **Append** causes the generated image to be appended as a new image within the existing .wim file.|  
  
## <a name="BKMK_examples"></a>Examples  
To export a boot image, type one of the following:  
  
```  
WDSUTIL /Export-Image /Image:"WinPE boot image" /ImageType:Boot /Architecture:x86 /DestinationImage /FilePath:"C:\temp\boot.wim"  
WDSUTIL /Verbose /Progress /Export-Image /Image:"WinPE boot image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /Filename:boot.wim   
/DestinationImage /FilePath:"\\Server\Share\ExportImage.wim" /Name:"Exported WinPE image" /Description:"WinPE Image from WDS server" /Overwrite:Yes  
```  
  
To export an install image, type one of the following:  
  
```  
WDSUTIL /Export-Image /Image:"Windows Vista with Office" /ImageType:Install /DestinationImage /FilePath:"C:\Temp\Install.wim"  
WDSUTIL /Verbose /Progress /Export-Image /Image:"Windows Vista with Office" /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1   
/Filename:install.wim /DestinationImage /FilePath:\\server\share\export.wim /Name:"Exported Windows image" /Description:"Windows Vista image from WDS server" /Overwrite:Append  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-Image Command](../Topic/Using-the-add-Image-Command.md)  
  
[Using the copy-Image Command](../Topic/Using-the-copy-Image-Command.md)  
  
[Using the get-Image Command](../Topic/Using-the-get-Image-Command.md)  
  
[Using the remove-Image Command](../Topic/Using-the-remove-Image-Command.md)  
  
[Using the replace-Image Command](../Topic/Using-the-replace-Image-Command.md)  
  
[Subcommand: set-Image](../Topic/Subcommand--set-Image.md)  
  
