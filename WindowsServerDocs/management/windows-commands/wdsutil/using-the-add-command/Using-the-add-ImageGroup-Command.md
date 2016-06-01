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
Adds an image group to a Windows Deployment Services server.

## Syntax

```
WDSUTIL [Options] /Add-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group to be added.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If a server name is not specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To add an image group, type one of the following:

```
WDSUTIL /Add-ImageGroumediaGroup:ImageGroup2
WDSUTIL /Verbose /Add-ImageGroumediaGroup:"My Image Group" /Server:MyWDSServer
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Using the get-AllImageGroups Command](Using-the-get-AllImageGroups-Command.md)

[Using the get-ImageGroup Command](Using-the-get-ImageGroup-Command.md)

[Using the remove-ImageGroup Command](Using-the-remove-ImageGroup-Command.md)

[Subcommand: set-ImageGroup](Subcommand--set-ImageGroup.md)


