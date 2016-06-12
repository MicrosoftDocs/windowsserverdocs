---
title: Using the get-ImageGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0fc25aca-a529-44ee-bc8e-96bc8affb458
---
# Using the get-ImageGroup Command
Retrieves information about an image group and the images within it.

## Syntax

```
wdsutil [Options] /Get-ImageGroumediaGroup:<Image group name> [/Server:<Server name>] [/detailed]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
|\[\/detailed\]|Returns the image metadata for each image. if this parameter is not use, the default behavior is to return only the image name, description, and file name.|

## <a name="BKMK_examples"></a>Examples
To view information about an image group, type:

```
wdsutil /Get-ImageGroumediaGroup:ImageGroup1
```

To view information including metadata, type:

```
wdsutil /verbose /Get-ImageGroumediaGroup:ImageGroup1 /Server:MyWDSServer /detailed
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-ImageGroup Command](../using-add-command/using-addimagegroup-command.md)

[Using the get-AllImageGroups Command](using-getallimagegroups-command.md)

[Using the remove-ImageGroup Command](../using-remove-command/using-removeimagegroup-command.md)

[Subcommand: set-ImageGroup](../the-set-command/subcommand-setimageGroup.md)


