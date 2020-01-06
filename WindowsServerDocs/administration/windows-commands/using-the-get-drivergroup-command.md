---
title: Using the get-DriverGroup Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cfe10c3-a63f-48e7-bef9-f6b474b4ddbe
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the get-DriverGroup Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about the driver groups on a server.
## Syntax
```
wdsutil /Get-DriverGroup /DriverGroup:<Group Name> [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN.  if a server name is not specified, the local server is used.|
|[/Show: {PackageMetaData &#124; Filters &#124; All}]|Displays the metadata for all the driver packages in the specified group. **PackageMetaData** displays information about all the filters for the driver group. **Filters** displays the metadata for all driver packages and filters for the group.|
## <a name="BKMK_examples"></a>Examples
To view information about a driver file, type:
```
wdsutil /Get-DriverGroup /DriverGroup:printerdrivers /Show:PackageMetaData
```
```
wdsutil /Get-DriverGroup /DriverGroup:printerdrivers /Server:MyWdsServer /Show:Filters
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the get-AllDriverGroups Command](using-the-get-alldrivergroups-command.md)
