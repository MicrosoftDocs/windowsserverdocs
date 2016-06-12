---
title: Subcommand: set-DriverGroup
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4ba9b1c-8c52-4fd5-969b-f7905611b364
---
# Subcommand: set-DriverGroup
Sets the properties of an existing driver group on a server.

## Syntax

```
wdsutil /Set-DriverGroup /DriverGroup:<Group Name> [/Server:<Server Name>] [/Name:<New Group Name>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if a server name is not specified, the local server is used.|
|\[\/Name:<New Group Name>\]|Specifies the new name for the driver group.|
|\[\/Enabled:{Yes &#124; No}|Enables or disables the driver group.|
|\[\/Applicability:{Matched &#124; All}\]|Specifies which packages to install if the filter criteria is met. **Matched** means install only the driver packages that match a client’s hardware. **All** means install all packages to clients regardless of their hardware.|

## <a name="BKMK_examples"></a>Examples
To set the properties for a driver group, type one of the following:

```
wdsutil /Set-DriverGroup /DriverGroup:printerdrivers /Enabled:Yes
```

```
wdsutil /Set-DriverGroup /DriverGroup:printerdrivers /Name:colorprinterdrivers /Applicability:All
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Subcommand: set-DriverGroupFilter](subcommand-setdrivergroupFilter.md)


