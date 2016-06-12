---
title: Using the add-DriverGroupPackage Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cd323ae-9049-448e-a460-6c7d6462d4c8
---
# Using the add-DriverGroupPackage Command
adds a driver package to a driver group.

## Syntax

```
wdsutil /add-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|\/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if no server name is specified, the local server is used.|
|\/DriverPackage:<Name>|Specifies the name of the driver package to be added to the group. You must specify this option if the driver package cannot be uniquely identified by name.|
|\/PackageId:<ID>|Specifies the ID for a package. To find the Package ID, click the driver group that the package is in \(or the **All Packages** node\), right\-click the package, and then click **Properties**. The Package ID is listed on the **General** tab, for example: **{DD098D20\-1850\-4fc8\-8E35\-EA24A1BEFF5E}**.|

## <a name="BKMK_examples"></a>Examples
To add a driver package, type one of the following:

```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```

```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /DriverPackage:XYZ
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-DriverGroupPackages Command](using-adddrivergrouppackages-command.md)

[Using the add-DriverPackage Command]()

[Using the add-AllDriverPackages subcommand](using-addalldriverpackages-subcommand.md)


