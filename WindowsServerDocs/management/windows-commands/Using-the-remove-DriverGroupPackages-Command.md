---
title: Using the remove-DriverGroupPackages Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b499635-6285-491c-8854-5665489f4364
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the remove-DriverGroupPackages Command
Removes driver packages from a driver group on a server.
## Syntax
```
WDSUTIL /Remove-DriverGroupPackages /DriverGroup:<Group Name> [/Server:<Server Name>] /FilterType:<Filter Type> /Operator:{Equal | NotEqual | GreaterOrEqual | LessOrEqual | Contains} /Value:<Value> [/Value:<Value> ...]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|/FilterType:<Filter Type>|Specifies the attribute of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **/Operator** and **/Value** with this option.<br /><br /><Filter Type> can be one of the following:<br /><br />**PackageId**<br /><br />**PackageName**<br /><br />**PackageEnabled**<br /><br />**PackageDateAdded**<br /><br />**PackageInfFilename**<br /><br />**PackageClass**<br /><br />**PackageProvider**<br /><br />**PackageArchitecture**<br /><br />**PackageLocale**<br /><br />**PackageSigned**<br /><br />**PackageDatePublished**<br /><br />**PackageVersion**<br /><br />**DriverDescription**<br /><br />**DriverManufacturer**<br /><br />**DriverHardwareId**<br /><br />**DriverCompatibleId**<br /><br />**DriverExcludeId**<br /><br />**DriverGroupId**<br /><br />**DriverGroupName**|
|/Operator:{Equal &#124; NotEqual &#124; GreaterOrEqual &#124; LessOrEqual &#124; Contains}|Specifies the relationship between the attribute and the values. You can only specify **Contains** with string attributes. You can only specify **GreaterOrEqual** and **LessOrEqual** with date and version attributes.|
|/Value:<Value>|Specifies the value to search for the specified <Attribute>. You can specify multiple values for a single **/FilterType**. The following list outlines the attributes that you can specify for each filter. For more information about these attributes, see [Driver and Package Attributes](http://go.microsoft.com/fwlink/?LinkId=166895) (http://go.microsoft.com/fwlink/?LinkId=166895).<br /><br />-   PackageId - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}.<br />-   PackageName – Specify any string value.<br />-   PackageEnabled - Specify **Yes** or **No**.<br />-   PackageDateAdded - Specify the date in the following format: YYYY/MM/DD<br />-   PackageInfFilename – Specify any string value.<br />-   PackageClass - Specify a valid class name or class GUID. For example: **DiskDrive**, **Net**, or {4d36e972-e325-11ce-bfc1-08002be10318}.<br />-   PackageProvider – Specify any string value.<br />-   PackageArchitecture - Specify **x86**, **x64**, or **ia64**.<br />-   PckageLocale - Specify a valid language identifier. For example: **en-US** or **es-ES**.<br />-   PackageSigned - Specify **Yes** or **No**.<br />-   PackageDatePublished - Specify the date in the following format: YYYY/MM/DD<br />-   PackageVersion - Specify the version in the following format: a.b.x.y. For example: 6.1.0.0<br />-   DriverDescription – Specify any string value.<br />-   DriverManufacturer – Specify any string value.<br />-   DriverHardwareId - Specify any string value.<br />-   DriverCompatibleId - Specify any string value.<br />-   DriverExcludeId - Specify any string value.<br />-   DriverGroupId - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}.<br />-   DriverGroupName – Specify any string value.|
## <a name="BKMK_examples"></a>Examples
To remove driver packages from a driver group, type one of the following:
```
WDSUTIL /verbose /Remove-DriverGroupPackages /DriverGroup:PrinterDrivers
/FilterType:DriverManufacturer /Operator:NotEqual /Value:Name1 /Value:Name2
```
```
WDSUTIL /verbose /Remove-DriverGroupPackages /DriverGroup:DisplayDrivers
/FilterType:PackageArchitecture /Operator:Equal /Value:x86
/FilterType:PackageDateAdded /Operator:LessOrEqual /Value:2008/01/01
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the remove-DriverGroupPackage Command](Using-the-remove-DriverGroupPackage-Command.md)
