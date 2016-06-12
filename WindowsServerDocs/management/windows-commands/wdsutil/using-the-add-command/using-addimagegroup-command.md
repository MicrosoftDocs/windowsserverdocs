---
title: Using the add-ImageGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6ca88671-51de-4924-b969-88f3dfd84270
---
# Using the add-ImageGroup Command
adds an image group to a Windows deployment Services server.

## Syntax

```
wdsutil [Options] /add-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group to be added.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if a server name is not specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To add an image group, type one of the following:

```
wdsutil /add-ImageGroumediaGroup:ImageGroup2
wdsutil /verbose /add-ImageGroumediaGroup:"My Image Group" /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the get-AllImageGroups Command](../using-get-command/using-getallimagegroups-command.md)

[Using the get-ImageGroup Command](../using-get-command/using-getimagegroup-command.md)

[Using the remove-ImageGroup Command](../using-remove-command/using-removeimagegroup-command.md)

[Subcommand: set-ImageGroup](../the-set-command/subcommand-setimageGroup.md)


