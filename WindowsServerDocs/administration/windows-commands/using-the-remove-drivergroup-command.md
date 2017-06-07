---
title: Using the remove-DriverGroup Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1fefe9df-9782-433c-8abe-3f1a35e50da2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the remove-DriverGroup Command

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes a driver group from a server.

## Syntax

```
WDSUTIL /Remove-DriverGroup /DriverGroup:<Group Name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/DriverGroup:\<Group Name>|Specifies the name of the driver group to remove.|
|[/Server:\<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|

## <a name="BKMK_examples"></a>Examples

To remove a driver group, type one of the following:
```
WDSUTIL /Remove-DriverGroup /DriverGroup:PrinterDrivers
```
```
WDSUTIL /Remove-DriverGroup /DriverGroup:PrinterDrivers /Server:MyWdsServer
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)