---
title: Using the get-AllImageGroups Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ca06533-bcf5-4590-ac8e-263d6c9874f8
---
# Using the get-AllImageGroups Command
Retrieves information about all image groups on a server and all images in those image groups.

## Syntax

```
wdsutil [Options] /Get-AllImageGroups [/Server:<Server name>] [/detailed]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
|\[\/detailed\]|Returns the image metadata from each image. if this parameter is not used, the default behavior is to return only the image name, description, and file name for each image.|

## <a name="BKMK_examples"></a>Examples
To view information about the image groups, type one of the following:

```
wdsutil /Get-AllImageGroups
wdsutil /verbose /Get-AllImageGroups /Server:MyWDSServer /detailed
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-ImageGroup Command](../using-add-command/using-addimagegroup-command.md)

[Using the get-ImageGroup Command](using-getimagegroup-command.md)

[Using the remove-ImageGroup Command](../using-remove-command/using-removeimagegroup-command.md)

[Subcommand: set-ImageGroup](../the-set-command/subcommand-setimageGroup.md)


