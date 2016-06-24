---
title: Using the get-AllDriverGroups Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f245ba53-f150-41b1-8418-38dcf0410a05
---
# Using the get-AllDriverGroups Command
Displays information about all the driver groups on a server.

## Syntax

```
WDSUTIL /Get-AllDriverGroups [/Server:<Server name>] [/Show:{PackageMetaData | Filters | All}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|[/Show: {PackageMetaData &#124; Filters &#124; All}]|Displays the metadata for all the driver packages in the specified group. **PackageMetaData** displays information about all the filters for the driver group. **Filters** displays the metadata for all driver packages and filters for the group.|

## <a name="BKMK_examples"></a>Examples
To view information about a driver file, type:

```
WDSUTIL /Get-AllDriverGroups /Server:MyWdsServer /Show:All
```

```
WDSUTIL /Get-AllDriverGroups [/Show:PackageMetaData]
```

#### Additional references
[Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)

[Using the get-DriverGroup Command](Using-the-get-DriverGroup-Command.md)


