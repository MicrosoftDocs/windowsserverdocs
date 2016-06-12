---
title: Using the new-MulticastTransmission Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c1f1dc46-dd50-4eb9-9f72-cf0e5d71bd3d
---
# Using the new-MulticastTransmission Command
creates a new multicast transmission for an image. This command is equivalent to creating a transmission by using the Windows deployment Services mmc snap\-in \(right\-click the **Multicast Transmissions** node, and then click **create Multicast Transmission**\). You should use this command when you have both the deployment Server role service and the Transport Server role service installed \(which is the default installation\). if you have only the Transport Server role service installed, use [Using the new-Namespace Command](using-newnamespace-command.md).

## Syntax
for install images transmissions:

```
wdsutil [Options] /New-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
        /FriendlyName:<Friendly name>
        [/Description:<Description>]
        /Transmissiontype: {AutoCast | ScheduledCast}
            [/time:<YYYY/MM/DD:hh:mm>]
            [/Clients:<Num of Clients>]
      mediatype:Install
       mediaGroup:<Image Group>]
        [/Filename:<File name>]
```

for boot image transmissions \(only supported for Windows Server 2008 R2\):

```
wdsutil [Options] /New-MulticastTransmissiomedia:<Image name>
        [/Server:<Server name>]
        /FriendlyName:<Friendly name>
        [/Description:<Description>]
        /Transmissiontype: {AutoCast | ScheduledCast}
            [/time:<YYYY/MM/DD:hh:mm>]
            [/Clients:<Num of Clients>]
      mediatype:Boot
        /Architecture:{x86 | ia64 | x64}
        [/Filename:<File name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image to be transmitted using multicasting.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
|\/FriendlyName:<Friendly name>|Specifies the friendly name of the transmission.|
|\[\/Description:<Description>\]|Specifies the description of the transmission.|
mediatype:{Boot&#124;Install}|Specifies the type of image to be transmitted using multicasting. Note **Boot** is only supported for Windows Server 2008 R2.|
|\mediaGroup:<Image group name>\]|Specifies the image group that contains the image. if no image group name is specified and only one image group exists on the server, that image group is used. if more than one image group exists on the server, you must use this option to specify the image group name.|
|\[\/Filename:<File name>\]|Specifies the file name. if the source image cannot be uniquely identified by name, you must use this option to specify the file name.|
|\/Transmissiontype:{AutoCast &#124; ScheduledCast}|Specifies whether to start the transmission automatically \(AutoCast\) or based on the specified start criteria \(ScheduledCast\).<br /><br /><ul><li>**Auto\-Cast**. This transmission type indicates that as soon as an applicable client requests an install image, a multicast transmission of the selected image begins. As other clients request the same image, they are joined to the transmission that is already started.</li><li>**Scheduled\-Cast**. This transmission type sets the start criteria for the transmission based on the number of clients that are requesting an image and\/or a specific day and time. You can specify the following options:<br /><br /><ul><li>\[\/time: <time>\] \- Sets the time that the transmission should start by using the following format: YYYY\/MM\/DD:hh:mm.</li><li>\[\/Clients: <Number of clients>\] \- Sets the minimum number of clients to wait for before the transmission starts.</li></ul></li></ul>|
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image to transmit using multicasting. Because it is possible to have the same name for boot images of different architectures, you should specify the architecture to ensure the correct image is used.|
|\[\/Filename:<File name>\]|Specifies the file name. if the source image cannot be uniquely identified by name, you must specify the file name.|

## <a name="BKMK_examples"></a>Examples
To create an Auto\-Cast transmission of a boot image in Windows Server 2008 R2, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:"WDS Boot Transmission"
/Image:"X64 Boot Imagemediatype:Boot /Architecture:x64 /Transmissiontype:AutoCast

```

To create an Auto\-Cast transmission of an install image, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:"WDS AutoCast Transmission"
/Image:"Vista with Officemediatype:Install /Transmissiontype:AutoCast
```

To create a Scheduled\-Cast transmission of an install image, type:

```
wdsutil /New-MulticastTransmission /FriendlyName:"WDS SchedCast Transmission" /Server:MyWDSServemedia:"Vista with Officemediatype:Install 
/Transmissiontype:ScheduledCast /time:"2006/11/20:17:00" /Clients:100
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the get-AllMulticastTransmissions Command](../using-get-command/using-getallmulticasttransmissions-command.md)

[Using the get-MulticastTransmission Command](../using-get-command/using-getmulticasttransmission-command.md)

[Using the remove-MulticastTransmission Command](../using-remove-command/using-removemulticasttransmission-command.md)

[Subcommand: start-MulticastTransmission](../the-start-server-command/subcommand-startmulticasttransmission.md)


