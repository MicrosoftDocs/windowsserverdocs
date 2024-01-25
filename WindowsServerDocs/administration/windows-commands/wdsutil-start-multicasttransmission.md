---
title: wdsutil start-multicasttransmission
description: Reference article for Subcommand start-MulticastTransmission, which starts a Scheduled-Cast transmission of an image.
ms.topic: reference
ms.assetid: a1b2d459-1ece-49d4-997c-9d206c463b61
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# wdsutil start-multicasttransmission

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Starts a Scheduled-Cast transmission of an image.

## Syntax
**Windows Server 2008**
```
wdsutil /start-MulticastTransmissiomedia:<Image name> [/Server:<Server namemediatype:InstallmediaGroup:<Image group name>] [/Filename:<File name>]
```
**Windows Server 2008 R2**
for boot images:
```
wdsutil [Options] /start-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediatype:Boot
        /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```
for install images:
```
wdsutil [Options] /start-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
      mediatype:Install
       mediaGroup:<Image Group>]
        [/Filename:<File name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
media:\<Image name\>|Specifies the name of the image.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:{Install\|Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|
|/Architecture:{x86 \| ia64 \| x64}|The architecture of the boot image that is associated with the transmission to start. Since it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|
|\mediaGroup:\<Image group name\>]|Specifies the image group of the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists on the server, you must use this option to specify the image group name.|
|[/Filename:\<File name\>]|Specifies the name of the file that contains the image. If the image cannot be uniquely identified by name, you must use this option to specify the file name.|

## Examples
To start a multicast transmission, type one of the following:
```
wdsutil /start-MulticastTransmissiomedia:Vista with Office
/Imagetype:Install
wdsutil /start-MulticastTransmission /Server:MyWDSServemedia:Vista with Officemediatype:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```
To start a boot image multicast transmission for Windows Server 2008 R2, type:
```
wdsutil /start-MulticastTransmission /Server:MyWDSServemedia:X64 Boot Imagemediatype:Boot /Architecture:x64
/Filename:boot.wim\n\
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-allmulticasttransmissions command](wdsutil-get-allmulticasttransmissions.md)
- [wdsutil get-multicasttransmission command](wdsutil-get-multicasttransmission.md)
- [wdsutil new-multicasttransmission command](wdsutil-new-multicasttransmission.md)
- [wdsutil remove-multicasttransmission command](wdsutil-remove-multicasttransmission.md)
