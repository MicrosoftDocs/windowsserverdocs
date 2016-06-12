---
title: Using the remove-ImageGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b2c9813-5df2-4272-8449-26f3bb16f82b
---
# Using the remove-ImageGroup Command
removes an image group from a server.

## Syntax

```
wdsutil [Options] /remove-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group to be removed|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To remove the image group, type one of the following:

```
wdsutil /remove-ImageGroumediaGroup:ImageGroup1
wdsutil /verbose /remove-ImageGroumediaGroup:"My Image Group" /Server:MyWDSServer 
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-ImageGroup Command](../using-add-command/using-addimagegroup-command.md)

[Using the get-AllImageGroups Command](../using-get-command/using-getallimagegroups-command.md)

[Using the get-ImageGroup Command](../using-get-command/using-getimagegroup-command.md)

[Subcommand: set-ImageGroup](../the-set-command/subcommand-setimageGroup.md)


