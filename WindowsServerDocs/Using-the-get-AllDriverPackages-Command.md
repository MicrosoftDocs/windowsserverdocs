---
title: Using the get-AllDriverPackages Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9eb8fcb7-ef46-4c8d-9623-8969a3c8b8a4
---
# Using the get-AllDriverPackages Command
Displays information about all the driver packages on a server that match the specified search criteria.

## Syntax

```
WDSUTIL /Get-AllDriverPackages [/Server:<Server name>] [/Show:{Drivers | Files | All}] [/FilterType:<Filter Type> /Operator:{Equal | NotEqual | GreaterOrEqual | LessOrEqual | Contains} /Value:<Value> [/Value:<Value> ...]]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|The name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|\[\/Show: {Drivers &#124; Files &#124; All}\]|Indicates the package information to display. If **\/Show** is not specified, the default is to return only the driver package metadata. **Drivers** displays the list of drivers in the package. **Files** displays the list of files in the package. **All** displays drivers and files.|
|\/FilterType:<Filter Type>|Specifies the attribute of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **\/Operator** and **\/Value** with this option.<br /><br /><Filter Type> can be one of the following:<br /><br />**PackageId**<br /><br />**PackageName**<br /><br />**PackageEnabled**<br /><br />**PackageDateAdded**<br /><br />**PackageInfFilename**<br /><br />**PackageClass**<br /><br />**PackageProvider**<br /><br />**PackageArchitecture**<br /><br />**PackageLocale**<br /><br />**PackageSigned**<br /><br />**PackageDatePublished**<br /><br />**PackageVersion**<br /><br />**DriverDescription**<br /><br />**DriverManufacturer**<br /><br />**DriverHardwareId**<br /><br />**DriverCompatibleId**<br /><br />**DriverExcludeId**<br /><br />**DriverGroupId**<br /><br />**DriverGroupName**|
|\/Operator:{Equal &#124; NotEqual &#124; GreaterOrEqual &#124; LessOrEqual &#124; Contains}|Specifies the relationship between the attribute and the values. You can specify **Contains** only with string attributes. You can specify **GreaterOrEqual** and **LessOrEqual** only with date and version attributes.|
|\/Value:<Value>|Specifies the value to search on for the specified <Attribute>.  You can specify multiple values for a single **\/FilterType**. The list below outlines the attributes you can specify for each filter. For more information about these attributes, see [Driver and Package Attributes](http://go.microsoft.com/fwlink/?LinkId=166895) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166895\).<br /><br />-   PackageId \- Specify a valid GUID. For example: {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   PackageName – Specify any string value.<br />-   PackageEnabled \- Specify **Yes** or **No**.<br />-   PackageDateAdded \- Specify the date in the following format: YYYY\/MM\/DD<br />-   PackageInfFilename – Specify any string value.<br />-   PackageClass \- Specify a valid class name or class GUID. For example: **DiskDrive**, **Net**, or {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   PackageProvider – Specify any string value.<br />-   PackageArchitecture \- Specify **x86**, **x64**, or **ia64**.<br />-   PackageLocale \- Specify a valid language identifier. For example: **en\-US** or **es\-ES**.<br />-   PackageSigned \- Specify **Yes** or **No**.<br />-   PackageDatePublished \- Specify the date in the following format: YYYY\/MM\/DD<br />-   PackageVersion – Specify the version in the following format: a.b.x.y. For example: 6.1.0.0<br />-   DriverDescription – Specify any string value.<br />-   DriverManufacturer – Specify any string value.<br />-   DriverHardwareId \- Specify any string value.<br />-   DriverCompatibleId \- Specify any string value.<br />-   DriverExcludeId – Specify any string value.<br />-   DriverGroupId – Specify a valid GUID. For example: {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   DriverGroupName – Specify any string value.|

## <a name="BKMK_examples"></a>Examples
To display information, type one of the following:

```
WDSUTIL /Get-AllDriverPackages /Server:MyWdsServer /Show:All /FilterType:DriverGroupName /Operator:Contains /Value:Printer /FilterType:PackageArchitecture /Operator:Equal /Value:x64 /Value:x86
```

```
WDSUTIL /Get-AllDriverPackages /Show:Drivers /FilterType:PackageDateAdded /Operator:GreaterOrEqual /Value:2008/01/01
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Using the get-DriverPackage Command](Using-the-get-DriverPackage-Command.md)

[Using the get-DriverPackageFile Command](Using-the-get-DriverPackageFile-Command.md)


