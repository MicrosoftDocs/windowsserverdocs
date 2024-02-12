---
title: wdsutil get-multicasttransmission
description: Reference article for wdsutil get-multicasttransmission, which displays information about the multicast transmission for a specified image.
ms.topic: reference
ms.assetid: b733737b-1e81-43d4-a058-d6985a613bef
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-multicasttransmission

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about the multicast transmission for a specified image.

## Syntax

**Windows Server 2008**

```
wdsutil [Options] /Get-MulticastTransmissiomedia:<Image name> [/Server:<Server name>mediatype:InstallmediaGroup:<Image group name>]
[/Filename:<File name>] [/Show:Clients]
```

**Windows Server 2008 R2**

for boot image transmissions:

```
wdsutil [Options] /Get-MulticastTransmissiomedia:<Image name>
    [/Server:<Server name>]
    [/details:Clients]
  mediatype:Boot
    /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```

for install image transmissions:

```
wdsutil [Options] /Get-MulticastTransmissiomedia:<Image name>
         [/Server:<Server name>]
         [/details:Clients]
       mediatype:Install
    mediaGroup:<Image Group>]
     [/Filename:<File name>]
```

### Parameters

|Parameter|Description|
|-------|--------|
media:\<Image name\>|Displays the multicast transmission that is associated with this image.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|/imagetype:Install|Specifies the image type. Note that this option must be set to **Install**.|
|/imagegroup:\<Image group name\>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify an image group.|
|/Architecture:{x86 \| ia64 \| x64}|Specifies the architecture of the boot image that is associated with the transmission. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure                                   that the correct image is used.|
|[/Filename:\<File name\>]|Specifies the file that contains the image. If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|[/Show:Clients]<p>or<p>[/details:Clients]|Displays information about client computers that are connected to the multicast transmission.|

## Examples

**Windows Server 2008**

To view information about the transmission for an image named  Vista with Office, type one of the following:

```
wdsutil /Get-MulticastTransmission:Vista with Office imagetype:Install
wdsutil /Get-MulticastTransmission /Server:MyWDSServer image:Vista with Office imagetype:Install imageGroup:ImageGroup1 /Filename:install.wim /Show:Clients
```

**Windows Server 2008 R2**

To view information about the transmission for an image named  Vista with Office, type one of the following:

```
wdsutil /Get-MulticastTransmission:Vista with Office
 /Imagetype:Install
```

```
wdsutil /Get-MulticastTransmission /Server:MyWDSServer image:Vista with Office imagetype:Install ImageGroup:ImageGroup1 /Filename:install.wim /details:Clients
```

```
wdsutil /Get-MulticastTransmission /Server:MyWDSServer:X64 Boot Imagetype:Boot /Architecture:x64 /Filename:boot.wim /details:Clients
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-allmulticasttransmissions command](wdsutil-get-allmulticasttransmissions.md)
- [wdsutil new-multicasttransmission command](wdsutil-new-multicasttransmission.md)
- [wdsutil remove-multicasttransmission command](wdsutil-remove-multicasttransmission.md)
- [wdsutil start-multicasttransmission command](wdsutil-start-multicasttransmission.md)
