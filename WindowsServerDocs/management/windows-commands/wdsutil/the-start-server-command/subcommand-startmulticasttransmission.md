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
starts a Scheduled\-Cast transmission of an image.

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

## Parameters

|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
mediatype:{Install&#124;Boot}|Specifies the image type. Note that this option must be set to **Install** for Windows Server 2008.|
|\/Architecture:{x86 &#124; ia64 &#124; x64}|The architecture of the boot image that is associated with the transmission to start. Since it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure that the correct transmission is used.|
|\mediaGroup:<Image group name>\]|Specifies the image group of the image. if no image group name is specified and only one image group exists on the server, that image group will be used. if more than one image group exists on the server, you must use this option to specify the image group name.|
|\[\/Filename:<File name>\]|Specifies the name of the file that contains the image. if the image cannot be uniquely identified by name, you must use this option to specify the file name.|

## <a name="BKMK_examples"></a>Examples
To start a multicast transmission, type one of the following:

```
wdsutil /start-MulticastTransmissiomedia:"Vista with Office"
/Imagetype:Install
wdsutil /start-MulticastTransmission /Server:MyWDSServemedia:"Vista with Officemediatype:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```

To start a boot image multicast transmission for Windows Server 2008 R2, type:

```
wdsutil /start-MulticastTransmission /Server:MyWDSServemedia:"X64 Boot Imagemediatype:Boot /Architecture:x64
/Filename:boot.wim\n\
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the get-AllMulticastTransmissions Command](../using-get-command/using-getallmulticasttransmissions-command.md)

[Using the get-MulticastTransmission Command](../using-get-command/using-getmulticasttransmission-command.md)

[Using the new-MulticastTransmission Command](../using-new-command/using-newmulticasttransmission-command.md)

[Using the remove-MulticastTransmission Command](../using-remove-command/using-removemulticasttransmission-command.md)


