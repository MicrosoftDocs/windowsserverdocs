---
title: wdsutil export-image
description: Reference article for the wdsutil export-image command, which exports an existing image from the image store to another Windows Image (.wim) file.
ms.topic: reference
ms.assetid: a9b8b467-0f2d-4754-8998-55503a262778
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil export-image

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Exports an existing image from the image store to another Windows Image (.wim) file.

## Syntax

For boot images:

```
wdsutil [options] /Export-Image image:<Image name> [/Server:<Servername>]
    imagetype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<Filename>]
     /DestinationImage
         /Filepath:<Filepath and name>
         [/Name:<Name>]
         [/Description:<Description>]
     [/Overwrite:{Yes | No}]
```

For install images:

```
wdsutil [options] /Export-Image image:<Image name> [/Server:<Servername>]
    imagetype:Install imageGroup:<Image group name>]
     [/Filename:<Filename>]
     /DestinationImage
         /Filepath:<Filepath and name>
         [/Name:<Name>]
         [/Description:<Description>]
     [/Overwrite:{Yes | No | append}]
```

### Parameters

| Parameter | Description |
|--|--|
| image:`<Imagename>` | Specifies the name of the image to be exported. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used. |
| imagetype:`{Boot|Install}` | Specifies the type of image to be exported. |
| \imageGroup:`<Image group name>`] | Specifies the image group containing the image to be exported. If no image group name is specified and only one image group exists on the server, that image group will be used by default. If more than one image group exists on the server, the image group must be specified. |
| /Architecture:`{x86|ia64|x64}` | Specifies the architecture of the image to be exported. Because it is possible to have the same image name for boot images in different architectures, specifying the architecture value ensures that the correct image will be returned. |
| [/Filename:`<Filename>`] | if the image cannot be uniquely identified by name, the file name must be specified. |
| /DestinationImage | Specifies the settings for the destination image. You can specify these settings using the following options:<ul><li>`/Filepath:<Filepath and name>` - Specifies the full file path for the new image.</li><li>`[/Name:<Name>]` - Sets the display name of the image. If no name is specified, the display name of the source image will be used.</li><li>`[/Description: <Description>]` - Sets the description of the image.</li></ul> |
| [/Overwrite:`{Yes|No|append}`] | Determines whether the file specified in the **/DestinationImage** option will be overwritten if an existing file with that name already exists at the /Filepath. The **Yes** option causes the existing file to be overwritten, the **No** option (default) causes an error to occur if a file with the same name already exists, and the **append** option causes the generated image to be appended as a new image within the existing .wim file. |

## Examples

To export a boot image, type either:

```
wdsutil /Export-Image image:WinPE boot image imagetype:Boot /Architecture:x86 /DestinationImage /Filepath:C:\temp\boot.wim
```

```
wdsutil /verbose /Progress /Export-Image image:WinPE boot image /Server:MyWDSServer imagetype:Boot /Architecture:x64 /Filename:boot.wim /DestinationImage /Filepath:\\Server\Share\ExportImage.wim /Name:Exported WinPE image /Description:WinPE Image from WDS server /Overwrite:Yes
```

To export an install image, type either:

```
wdsutil /Export-Image image:Windows Vista with Office imagetype:Install /DestinationImage /Filepath:C:\Temp\Install.wim
```

```
wdsutil /verbose /Progress /Export-Image image:Windows Vista with Office /Server:MyWDSServer imagetype:Instal imageGroup:ImageGroup1 /Filename:install.wim /DestinationImage /Filepath:\\server\share\export.wim /Name:Exported Windows image /Description:Windows Vista image from WDS server /Overwrite:append
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-image command](wdsutil-add-image.md)

- [wdsutil copy-image command](wdsutil-copy-image.md)

- [wdsutil get-image command](wdsutil-get-image.md)

- [wdsutil remove-image command](wdsutil-remove-image.md)

- [wdsutil replace-image command](wdsutil-replace-image.md)

- [wdsutil set-image command](wdsutil-set-image.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
