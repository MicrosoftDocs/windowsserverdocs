---
title: Using the add-ImageDriverPackages Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9dc78909-a4d1-42a2-af8f-21ebcbfe8302
---
# Using the add-ImageDriverPackages Command
Adds driver packages from the driver store to a boot image. The image version must be Windows 7 or Windows Server 2008 R2 or later.  
  
For examples of how you can use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
WDSUTIL /Add-ImageDriverPackages [/Server:<Server name>] /Image:<Image name> /ImageType:Boot /Architecture:{x86 | ia64 | x64}   
[/Filename:<File name>] /FilterType:<Filter Type> /Operator:{Equal | NotEqual | GreaterOrEqual | LessOrEqual | Contains} /Value:<Value> [/Value:<Value> ...]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|  
|\/Image:<Image name>|Specifies the name of the image to add the driver to.|  
|\/ImageType:Boot|Specifies the type of image to add the driver to. Driver packages can be added only to boot images.|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure the correct image is used.|  
|\/Filename:<File name>|Specifies the file name. If the image cannot be uniquely identified by name, the file name must be specified.|  
|\/FilterType:<Filter Type>|Specifies the attribute of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **\/Operator** and **\/Value** with this option.<br /><br /><Filter Type> can be one of the following:<br /><br />**PackageId**<br /><br />**PackageName**<br /><br />**PackageEnabled**<br /><br />**PackageDateAdded**<br /><br />**PackageInfFilename**<br /><br />**PackageClass**<br /><br />**PackageProvider**<br /><br />**PackageArchitecture**<br /><br />**PackageLocale**<br /><br />**PackageSigned**<br /><br />**PackageDatePublished**<br /><br />**PackageVersion**<br /><br />**DriverDescription**<br /><br />**DriverManufacturer**<br /><br />**DriverHardwareId**<br /><br />**DriverCompatibleId**<br /><br />**DriverExcludeId**<br /><br />**DriverGroupId**<br /><br />**DriverGroupName**|  
|\/Operator:{Equal &#124; NotEqual &#124; GreaterOrEqual &#124; LessOrEqual &#124; Contains}|The relationship between the attribute and the values. You can only specify **Contains** with string attributes. You can only specify **GreaterOrEqual** and **LessOrEqual** with date and version attributes.|  
|\/Value:<Value>|Specifies the value to search for relative to the specified <Attribute>. You can specify multiple values for a single **\/FilterType**. The list below outlines the attributes that you can specify for each filter. For more information about these attributes, see [Driver and Package Attributes](http://go.microsoft.com/fwlink/?LinkId=166895) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=166895\).<br /><br />-   PackageId \- Specify a valid GUID. For example: {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   PackageName – Specify any string value.<br />-   PackageEnabled \- Specify **Yes** or **No**.<br />-   PackageDateAdded \- Specify the date in the following format: YYYY\/MM\/DD<br />-   PackageInfFilename – Specify any string value.<br />-   PackageClass \- Specify a valid class name or class GUID. For example: **DiskDrive**, **Net**, or {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   PackageProvider – Specify any string value.<br />-   PackageArchitecture \- Specify **x86**,  **x64**, or **ia64**.<br />-   PackageLocale \- Specify a valid language identifier. For example: **en\-US** or **es\-ES**.<br />-   PackageSigned \- Specify **Yes** or **No**.<br />-   PackageDatePublished \- Specify the date in the following format: YYYY\/MM\/DD<br />-   PackageVersion \- Specify the version in the following format: a.b.x.y. For example: 6.1.0.0<br />-   DriverDescription – Specify any string value.<br />-   DriverManufacturer – Specify any string value.<br />-   DriverHardwareId \- Specify any string value.<br />-   DriverCompatibleId \- Specify any string value.<br />-   DriverExcludeId \- Specify any string value.<br />-   DriverGroupId \- Specify a valid GUID. For example: {4d36e972\-e325\-11ce\-bfc1\-08002be10318}.<br />-   DriverGroupName – Specify any string value.|  
  
## <a name="BKMK_examples"></a>Examples  
To add driver packages to a boot image, type one of the following:  
  
```  
WDSUTIL /Add-ImageDriverPackages /Image:"WinPE Boot Image" /ImageType:Boot /Architecture:x86 /FilterType:DriverGroupName /Operator:Equal /Value:x86Bus /FilterType:PackageProvider /Operator:Contains /Value:Provider1 /FilterType:PackageVersion /Operator:GreaterOrEqual /Value:6.1.0.0  
```  
  
```  
WDSUTIL /verbose /Add-ImageDriverPackages /Image: "WinPE Boot Image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /FilterType:PackageClass /Operator:Equal /Value:Net /FilterType:DriverManufacturer /Operator:NotEqual /Value:Name1 /Value:Name2 /FilterType:PackageDateAdded /Operator:LessOrEqual /Value:2008/01/01  
```  
  
```  
WDSUTIL /verbose /Add-ImageDriverPackages /Image:"WinPE Boot Image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /FilterType:PackageClass /Operator:Equal /Value:Net /Value:System /Value:DiskDrive /Value:HDC /Value:SCSIAdapter  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-ImageDriverPackage Command](../Topic/Using-the-add-ImageDriverPackage-Command.md)  
  
[Using the add-AllDriverPackages subcommand](../Topic/Using-the-add-AllDriverPackages-subcommand.md)  
  
