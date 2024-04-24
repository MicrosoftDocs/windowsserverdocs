---
title: wdsutil new-multicasttransmission
description: Reference article for wdsutil new-multicasttransmission, which creates a new multicast transmission for an image.
ms.topic: reference
ms.assetid: c1f1dc46-dd50-4eb9-9f72-cf0e5d71bd3d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil new-multicasttransmission

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a new multicast transmission for an image. This command is equivalent to creating a transmission by using the Windows Deployment Services mmc snap-in (right-click the **Multicast Transmissions** node, and then click **create Multicast Transmission**). You should use this command when you have both the Deployment Server role service and the Transport Server role service installed (which is the default installation). If you have only the Transport Server role service installed, use [wdsutilnew-Namespace command](wdsutil-new-namespace.md).

## Syntax

For install images transmissions:

```
wdsutil [Options] /New-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
        /FriendlyName:<Friendly name>
        [/Description:<Description>]
        /Transmissiontype: {AutoCast | ScheduledCast}
            [/time:<YYYY/MM/DD:hh:mm>]
            [/Clients:<Num of Clients>]
      imagetype:Install
       ImageGroup:<Image Group>]
        [/Filename:<File name>]
```

For boot image transmissions (only supported for Windows Server 2008 R2):

```
wdsutil [Options] /New-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
        /FriendlyName:<Friendly name>
        [/Description:<Description>]
        /Transmissiontype: {AutoCast | ScheduledCast}
            [/time:<YYYY/MM/DD:hh:mm>]
            [/Clients:<Num of Clients>]
      imagetype:Boot
        /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```

### Parameters

|Parameter|Description|
|-------|--------|
| /image:\<Image name\>|Specifies the name of the image to be transmitted using multicasting.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/FriendlyName:\<Friendly name\>|Specifies the friendly name of the transmission.|
|[/Description:\<Description\>]|Specifies the description of the transmission.|
| /imagetype:{Boot\|Install}|Specifies the type of image to be transmitted using multicasting. Note **Boot** is only supported for Windows Server 2008 R2.|
| /ImageGroup:\<Image group name\>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify the image group name.|
|[/Filename:\<File name\>]|Specifies the file name. If the source image cannot be uniquely identified by name, you must use this option to specify the file name.|
|/Transmissiontype:{AutoCast \| ScheduledCast}|Specifies whether to start the transmission automatically (AutoCast) or based on the specified start criteria (ScheduledCast).<p><ul><li>**Auto-Cast**. This transmission type indicates that as soon as an applicable client requests an install image, a multicast transmission of the selected image begins. As other clients request the same image, they are joined to the transmission that is already started.</li><li>**Scheduled-Cast**. This transmission type sets the start criteria for the transmission based on the number of clients that are requesting an image and/or a specific day and time. You can specify the following options:<p><ul><li>[/time: \<time\>] - Sets the time that the transmission should start by using the following format: YYYY/MM/DD:hh:mm.</li><li>[/Clients: \<Number of clients\>] - Sets the minimum number of clients to wait for before the transmission starts.</li></ul></li></ul>|
|/Architecture:{x86 \| ia64 \| x64}|Specifies the architecture of the boot image to transmit using multicasting. Because it is possible to have the same name for boot images of different architectures, you should specify the architecture to ensure the correct image is used.|
|[/Filename:\<File name\>]|Specifies the file name. If the source image cannot be uniquely identified by name, you must specify the file name.|

## Examples

To create an Auto-Cast transmission of a boot image in Windows Server 2008 R2, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:WDS Boot Transmission
/Image:X64 Boot imagetype:Boot /Architecture:x64 /Transmissiontype:AutoCast
```

To create an Auto-Cast transmission of an install image, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:WDS AutoCast Transmission
/Image:Vista with Officeimage imagetype:Install /Transmissiontype:AutoCast
```

To create a Scheduled-Cast transmission of an install image, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:WDS SchedCast Transmission /Server:MyWDSServer Image:Vista with Office imagetype:Install
/Transmissiontype:ScheduledCast /time:2006/11/20:17:00 /Clients:100
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-allmulticasttransmissions command](wdsutil-get-allmulticasttransmissions.md)
- [wdsutil get-multicasttransmission command](wdsutil-get-multicasttransmission.md)
- [wdsutil remove-multicasttransmission command](wdsutil-remove-multicasttransmission.md)
- [wdsutil start-multicasttransmission command](wdsutil-start-multicasttransmission.md)
