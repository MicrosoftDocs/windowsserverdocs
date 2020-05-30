---
title: copy-DriverGroup
description: Reference topic for copy-DriverGroup, which duplicates an existing driver group on the server including the filters, driver packages, and enabled/disabled status. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 0aaf6fa5-8b5b-4a1e-ae9b-8b5c6d89f571
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# copy-DriverGroup

Duplicates an existing driver group on the server including the filters, driver packages, and enabled/disabled status.

## Syntax

```
WDSUTIL /Copy-DriverGroup [/Server:<Server name>] /DriverGroup:<Source Group Name> /GroupName:<New Group Name>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|[/Server:\<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|
|/DriverGroup:\<Source Group Name>|Specifies the name of the source driver group.|
|/GroupName:\<New Group Name>|Specifies the name of the new driver group.|

## Examples

To copy a driver group, type one of the following:
```
WDSUTIL /Copy-DriverGroup /Server:MyWdsServer /DriverGroup:PrinterDrivers /GroupName:X86PrinterDrivers
```
```
WDSUTIL /Copy-DriverGroup /DriverGroup:PrinterDrivers /GroupName:ColorPrinterDrivers
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)