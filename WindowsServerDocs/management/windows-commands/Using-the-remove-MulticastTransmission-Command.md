---
title: Using the remove-MulticastTransmission Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a7f5c31-bfbf-425d-9129-a6f9173fe83d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the remove-MulticastTransmission Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Disables multicast transmitting for an image. Unless you specify **/Force**, existing clients will complete the image transfer but new clients will not be allowed to join.
## Syntax
**Windows Server 2008**
```
WDSUTIL /Remove-MulticastTransmissiomedia:<Image name> [/Server:<Server name>mediaType:InstallmediaGroup:<Image Group>] [/Filename:<File name>] [/Force]
```
**Windows Server 2008 R2**
For boot images:
```
WDSUTIL [Options] /Remove-MulticastTransmissiomedia:<Image name>
\x20    [/Server:<Server name>]
\x20  mediaType:Boot
\x20    /Architecture:{x86 | ia64 | x64}
\x20    [/Filename:<File name>]
```
For install images:
```
WDSUTIL [Options] /Remove-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediaType:Install
       mediaGroup:<Image Group
        [/Filename:<File name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
mediaType:{Install&#124;Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image that is associated with the transmission to start. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify the image group name.|
|[/Filename:<File name>]|Specifies the file name. If the source image cannot be uniquely identified by name, you must use this option to specify the file name.|
|[/Force]|Removes the transmission and terminates all clients. Unless you specify a value for the **/Force** option, existing clients can complete the image transfer but new clients are not able to join.|
## <a name="BKMK_examples"></a>Examples
To stop a namespace (current clients will complete the transmission, but new clients will not be able to join), type:
```
WDSUTIL /Remove-MulticastTransmissiomedia:"Vista with Office"
/ImageType:Install
```
```
WDSUTIL /Remove-MulticastTransmissiomedia:"x64 Boot Image"
/ImageType:Boot /Architecture:x64
```
To force termination of all clients, type:
```
WDSUTIL /Remove-MulticastTransmission /Server:MyWDSServer
/Image:"Vista with OfficemediaType:InstalmediaGroup:ImageGroup1
/Filename:install.wim /Force
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-AllMulticastTransmissions Command](Using-the-get-AllMulticastTransmissions-Command.md)
[Using the get-MulticastTransmission Command](Using-the-get-MulticastTransmission-Command.md)
[Using the new-MulticastTransmission Command](Using-the-new-MulticastTransmission-Command.md)
[Subcommand: start-MulticastTransmission](Subcommand--start-MulticastTransmission.md)
