---
title: Subcommand: start-MulticastTransmission
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a1b2d459-1ece-49d4-997c-9d206c463b61
---
# Subcommand: start-MulticastTransmission
Starts a Scheduled\-Cast transmission of an image.  
  
## Syntax  
**Windows Server 2008**  
  
```  
WDSUTIL /Start-MulticastTransmission /Image:<Image name> [/Server:<Server name>]/ImageType:Install [/ImageGroup:<Image group name>] [/Filename:<File name>]  
```  
  
**Windows Server 2008 R2**  
  
For boot images:  
  
```  
WDSUTIL [Options] /Start-MulticastTransmission /Image:<Image name>  
        [/Server:<Server name>]  
        /ImageType:Boot  
        /Architecture:{x86 | ia64 | x64}  
        [/Filename:<File name>]  
```  
  
For install images:  
  
```  
WDSUTIL [Options] /Start-MulticastTransmission /Image:<Image name>  
        [/Server:<Server name>]  
        /ImageType:Install  
        [/ImageGroup:<Image Group>]  
        [/Filename:<File name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/ImageType:{Install&#124;Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|The architecture of the boot image that is associated with the transmission to start. Since it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|  
|\[\/ImageGroup:<Image group name>\]|Specifies the image group of the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists on the server, you must use this option to specify the image group name.|  
|\[\/Filename:<File name>\]|Specifies the name of the file that contains the image. If the image cannot be uniquely identified by name, you must use this option to specify the file name.|  
  
## <a name="BKMK_examples"></a>Examples  
To start a multicast transmission, type one of the following:  
  
```  
WDSUTIL /Start-MulticastTransmission /Image:"Vista with Office"  
/ImageType:Install  
WDSUTIL /Start-MulticastTransmission /Server:MyWDSServer /Image:"Vista with Office" /ImageType:Install /ImageGroup:ImageGroup1 /Filename:install.wim  
```  
  
To start a boot image multicast transmission for Windows Server 2008 R2, type:  
  
```  
WDSUTIL /Start-MulticastTransmission /Server:MyWDSServer /Image:"X64 Boot Image" /ImageType:Boot /Architecture:x64  
/Filename:boot.wim\n\  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the get-AllMulticastTransmissions Command](../Topic/Using-the-get-AllMulticastTransmissions-Command.md)  
  
[Using the get-MulticastTransmission Command](../Topic/Using-the-get-MulticastTransmission-Command.md)  
  
[Using the new-MulticastTransmission Command](../Topic/Using-the-new-MulticastTransmission-Command.md)  
  
[Using the remove-MulticastTransmission Command](../Topic/Using-the-remove-MulticastTransmission-Command.md)  
  
