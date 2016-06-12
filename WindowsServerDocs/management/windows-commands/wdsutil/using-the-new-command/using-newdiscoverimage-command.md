---
title: Using the new-DiscoverImage Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ede9fbbb-0bba-4309-8c21-3cc13e1dc3cd
---
# Using the new-DiscoverImage Command
creates a new discover image from an existing boot image. Discover images are boot images that force the Setup.exe program to start in Windows deployment Services mode and then discover a Windows deployment Services server. Typically these images are used to deploy images to computers that are not capable of booting to PXE. for more information, see Creating Images \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=115311](http://go.microsoft.com/fwlink/?LinkId=115311)\).

## Syntax

```
wdsutil [Options] /New-DiscoverImage [/Server:<Server name>]
   media:<Image name>
     /Architecture:{x86 | ia64 | x64}
     [/Filename:<File name>]
     /DestinationImage
         /Filepath:<File path and name>
         [/Name:<Name>]
         [/Description:<Description>]
         [/WDSServer:<Server name>]
         [/Overwrite:{Yes | No | append}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
media:<Image name>|Specifies the name of the source boot image.|
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be returned. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture value ensures that wdsutil returns the correct image.|
|\[\/Filename:<File name>\]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|\/DestinationImage|Specifies the settings for the destination image. You can specify the settings using the following options:<br /><br />-   \/Filepath:< File path and name> \- Sets full file path for the new image.<br />-   \[\/Name:<Name>\] \- Sets the display name of the image. if no display name is specified, the display name of the source image will be used.<br />-   \[\/Description: <Description>\] \- Sets the description of the image.<br />-   \[\/WDSServer: <Server name>\] \- Specifies the name of the server that all clients who boot from the specified image should contact to download the install image. By default, all clients who boot this image will discover a valid Windows deployment Services server. Using this option bypasses the discovery functionality and forces the booted client to contact the specified server.<br />-   \[\/Overwrite:{Yes &#124; No &#124; append}\] \- Determines whether the file specified in **\/DestinationImage** should be overwritten if another file with that name already exists at the \/Filepath. **Yes** overwrites the existing file. **No** \(default\) causes an error to occur if another file with the same name already exists. **append** attaches the generated image as a new image within the existing .wim file.|

## <a name="BKMK_examples"></a>Examples
To create a discover image out of boot image, and name it WinPEDiscover.wim, type:

```
wdsutil /New-DiscoverImagmedia:"WinPE boot image" /Architecture:x86 /DestinationImage /Filepath:"C:\Temp\WinPEDiscover.wim"
```

To create a discover image out of boot image, and name it WinPEDiscover.wim with the specified settings, type:

```
wdsutil /verbose /Progress /New-DiscoverImage /Server:MyWDSServer
/Image:"WinPE boot image" /Architecture:x64 /Filename:boot.wim /DestinationImage /Filepath:"\\Server\Share\WinPEDiscover.wim" 
/Name:"New WinPE image" /Description:"WinPE image for WDS Client discovery" /Overwrite:No
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


