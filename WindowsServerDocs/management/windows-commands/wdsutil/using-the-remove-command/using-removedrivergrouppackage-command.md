---
title: Using the remove-DriverGroupPackage Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2e48616d-d6a4-45f0-a5c6-efe62bf6a0ed
---
# Using the remove-DriverGroupPackage Command
removes a driver package from a driver group on a server.

## Syntax

```
wdsutil /remove-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if a server name is not specified, the local server is used.|
|\[\/DriverPackage:<Name>\]|Specifies the name of the driver package to remove.|
|\[\/PackageId:<ID>\]|Specifies the Windows deployment Services ID of the driver package to remove. You must specify this option if the driver package cannot be uniquely identified by name.|

## <a name="BKMK_examples"></a>Examples

```
wdsutil /remove-DriverGroupPackage /DriverGroup:printerdrivers /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```

```
wdsutil /remove-DriverGroupPackage /DriverGroup:printerdrivers /DriverPackage:XYZ
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


