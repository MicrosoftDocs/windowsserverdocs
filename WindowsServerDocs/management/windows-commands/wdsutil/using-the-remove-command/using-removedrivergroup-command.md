---
title: Using the remove-DriverGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1fefe9df-9782-433c-8abe-3f1a35e50da2
---
# Using the remove-DriverGroup Command
removes a driver group from a server.

## Syntax

```
wdsutil /remove-DriverGroup /DriverGroup:<Group Name> [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/DriverGroup:<Group Name>|Specifies the name of the driver group to remove.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if a server name is not specified, the local server is used.|

## <a name="BKMK_examples"></a>Examples
To remove a driver group, type one of the following:

```
wdsutil /remove-DriverGroup /DriverGroup:printerdrivers
```

```
wdsutil /remove-DriverGroup /DriverGroup:printerdrivers /Server:MyWdsServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


