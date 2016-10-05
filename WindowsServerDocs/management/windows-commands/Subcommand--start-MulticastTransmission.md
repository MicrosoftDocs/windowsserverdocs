---
title: Subcommand: start-MulticastTransmission
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a1b2d459-1ece-49d4-997c-9d206c463b61
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Subcommand: start-MulticastTransmission
Starts a Scheduled-Cast transmission of an image.
## Syntax
**Windows Server 2008**
```
WDSUTIL /Start-MulticastTransmissiomedia:<Image name> [/Server:<Server namemediaType:InstallmediaGroup:<Image group name>] [/Filename:<File name>]
```
**Windows Server 2008 R2**
For boot images:
```
WDSUTIL [Options] /Start-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediaType:Boot
        /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```
For install images:
```
WDSUTIL [Options] /Start-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediaType:Install
       mediaGroup:<Image Group>]
        [/Filename:<File name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediaType:{Install&#124;Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|The architecture of the boot image that is associated with the transmission to start. Since it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|
|\mediaGroup:<Image group name>]|Specifies the image group of the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists on the server, you must use this option to specify the image group name.|
|[/Filename:<File name>]|Specifies the name of the file that contains the image. If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
## <a name="BKMK_examples"></a>Examples
To start a multicast transmission, type one of the following:
```
WDSUTIL /Start-MulticastTransmissiomedia:"Vista with Office"
/ImageType:Install
WDSUTIL /Start-MulticastTransmission /Server:MyWDSServemedia:"Vista with OfficemediaType:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```
To start a boot image multicast transmission for Windows Server 2008 R2, type:
```
WDSUTIL /Start-MulticastTransmission /Server:MyWDSServemedia:"X64 Boot ImagemediaType:Boot /Architecture:x64
/Filename:boot.wim\n\
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the get-AllMulticastTransmissions Command](Using-the-get-AllMulticastTransmissions-Command.md)
[Using the get-MulticastTransmission Command](Using-the-get-MulticastTransmission-Command.md)
[Using the new-MulticastTransmission Command](Using-the-new-MulticastTransmission-Command.md)
[Using the remove-MulticastTransmission Command](Using-the-remove-MulticastTransmission-Command.md)
