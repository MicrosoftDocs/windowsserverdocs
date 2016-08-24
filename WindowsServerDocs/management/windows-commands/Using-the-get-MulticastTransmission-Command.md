---
title: Using the get-MulticastTransmission Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b733737b-1e81-43d4-a058-d6985a613befauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the get-MulticastTransmission Command
Displays information about the multicast transmission for a specified image.
## Syntax
**Windows Server 2008**
```
WDSUTIL [Options] /Get-MulticastTransmissiomedia:<Image name> [/Server:<Server name>mediaType:InstallmediaGroup:<Image group name>] 
[/Filename:<File name>] [/Show:Clients]
```
**Windows Server 2008 R2**
For boot image transmissions:
```
WDSUTIL [Options] /Get-MulticastTransmissiomedia:<Image name>
    [/Server:<Server name>]
    [/Details:Clients]
  mediaType:Boot
    /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```
For install image transmissions:
```
WDSUTIL [Options] /Get-MulticastTransmissiomedia:<Image name>
         [/Server:<Server name>]
         [/Details:Clients]
       mediaType:Install
    mediaGroup:<Image Group>]
     [/Filename:<File name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Displays the multicast transmission that is associated with this image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
mediaType:Install|Specifies the image type. Note that this option must be set to **Install**.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify an image group.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image that is associated with the transmission. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure                                   that the correct image is used.|
|[/Filename:<File name>]|Specifies the file that contains the image. If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|[/Show:Clients]<br /><br />or<br /><br />[/Details:Clients]|Displays information about client computers that are connected to the multicast transmission.|
## <a name="BKMK_examples"></a>Examples
**Windows Server 2008**
To view information about the transmission for an image named “Vista with Office,�? type one of the following:
```
WDSUTIL /Get-MulticastTransmissiomedia:"Vista with OfficemediaType:Install
WDSUTIL /Get-MulticastTransmission /Server:MyWDSServemedia:"Vista with OfficemediaType:InstalmediaGroup:ImageGroup1 /Filename:install.wim /Show:Clients
```
**Windows Server 2008 R2**
To view information about the transmission for an image named “Vista with Office,�? type one of the following:
```
WDSUTIL /Get-MulticastTransmissiomedia:"Vista with Office"
 /ImageType:Install
```
```
WDSUTIL /Get-MulticastTransmission /Server:MyWDSServemedia:"Vista with OfficemediaType:InstalmediaGroup:ImageGroup1 /Filename:install.wim /Details:Clients
```
```
WDSUTIL /Get-MulticastTransmission /Server:MyWDSServemedia:"X64 Boot ImagemediaType:Boot /Architecture:x64 /Filename:boot.wim /Details:Clients
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-AllMulticastTransmissions Command](Using-the-get-AllMulticastTransmissions-Command.md)
[Using the new-MulticastTransmission Command](Using-the-new-MulticastTransmission-Command.md)
[Using the remove-MulticastTransmission Command](Using-the-remove-MulticastTransmission-Command.md)
[Subcommand: start-MulticastTransmission](Subcommand--start-MulticastTransmission.md)
