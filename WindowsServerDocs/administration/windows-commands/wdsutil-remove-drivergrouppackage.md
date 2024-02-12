---
title: remove-DriverGroupPackage
description: Reference article for remove-DriverGroupPackage, which removes a driver package from a driver group on a server.
ms.topic: reference
ms.assetid: 2e48616d-d6a4-45f0-a5c6-efe62bf6a0ed
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# remove-DriverGroupPackage



Removes a driver package from a driver group on a server.

## Syntax

```
wdsutil /Remove-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```

### Parameters

|Parameter|Description|
|---------|-----------|
|[/Server:\<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|[/DriverPackage:\<Name>]|Specifies the name of the driver package to remove.|
|[/PackageId:\<ID>]|Specifies the Windows Deployment Services ID of the driver package to remove. You must specify this option if the driver package cannot be uniquely identified by name.|

## Examples

```
wdsutil /Remove-DriverGroupPackage /DriverGroup:PrinterDrivers /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318}
```
```
wdsutil /Remove-DriverGroupPackage /DriverGroup:PrinterDrivers /DriverPackage:XYZ
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)