---
title: Using the remove-MulticastTransmission Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9a7f5c31-bfbf-425d-9129-a6f9173fe83d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the remove-MulticastTransmission Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Disables multicast transmitting for an image. Unless you specify **/force**, existing clients will complete the image transfer but new clients will not be allowed to join.
## Syntax
**Windows Server 2008**
```
wdsutil /remove-MulticastTransmissiomedia:<Image name> [/Server:<Server name>mediatype:InstallmediaGroup:<Image Group>] [/Filename:<File name>] [/force]
```
**Windows Server 2008 R2**
for boot images:
```
wdsutil [Options] /remove-MulticastTransmissiomedia:<Image name>
\x20    [/Server:<Server name>]
\x20  mediatype:Boot
\x20    /Architecture:{x86 | ia64 | x64}
\x20    [/Filename:<File name>]
```
for install images:
```
wdsutil [Options] /remove-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediatype:Install
       mediaGroup:<Image Group
        [/Filename:<File name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
mediatype:{Install&#124;Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image that is associated with the transmission to start. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify the image group name.|
|[/Filename:<File name>]|Specifies the file name. If the source image cannot be uniquely identified by name, you must use this option to specify the file name.|
|[/force]|removes the transmission and terminates all clients. Unless you specify a value for the **/force** option, existing clients can complete the image transfer but new clients are not able to join.|
## <a name="BKMK_examples"></a>Examples
To stop a namespace (current clients will complete the transmission, but new clients will not be able to join), type:
```
wdsutil /remove-MulticastTransmissiomedia:"Vista with Office"
/Imagetype:Install
```
```
wdsutil /remove-MulticastTransmissiomedia:"x64 Boot Image"
/Imagetype:Boot /Architecture:x64
```
To force termination of all clients, type:
```
wdsutil /remove-MulticastTransmission /Server:MyWDSServer
/Image:"Vista with Officemediatype:InstalmediaGroup:ImageGroup1
/Filename:install.wim /force
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the get-AllMulticastTransmissions Command](using-the-get-allmulticasttransmissions-command.md)
[Using the get-MulticastTransmission Command](using-the-get-multicasttransmission-command.md)
[Using the new-MulticastTransmission Command](using-the-new-multicasttransmission-command.md)
[Subcommand: start-MulticastTransmission](subcommand-start-multicasttransmission.md)
