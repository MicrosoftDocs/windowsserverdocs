---
title: Using the get-DriverPackage Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94d231e4-ff01-48e7-9bc8-7b0d97a4339e
---
# Using the get-DriverPackage Command
Displays information about a driver package on the server.

## Syntax

```
wdsutil /Get-DriverPackage [/Server:<Server name>] {/DriverPackage:<Package Name> | /PackageId:<ID>} [/Show:{Drivers | Files | All}]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if no server name is specified, the local server is used.|
|\[\/DriverPackage:<Name>\]|Specifies the name of the driver package to show.|
|\[\/PackageId:<ID>\]|Specifies the Windows deployment Services ID of the driver package to show. You must specify the ID if the driver package cannot be uniquely identified by name.|
|\[\/Show: {Drivers &#124; Files &#124; All}\]|Indicates what information to display \(if specified\). if **\/Show** is not specified, the default is to return only the driver package metadata.  **Drivers** displays all drivers in the package. **Files** displays the list of files in the package. **All** displays drivers, files, and metadata.|

## <a name="BKMK_examples"></a>Examples
To view information about a driver package, type one of the following:

```
wdsutil /Get-DriverPackage /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```

```
wdsutil /Get-DriverPackage /DriverPackage:MyDriverPackage /Show:All
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)


