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
Adds a driver package to a driver group.  
  
## Syntax  
  
```  
WDSUTIL /Add-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/DriverGroup:<Group Name>|Specifies the name of the driver group.|  
|\/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|  
|\/DriverPackage:<Name>|Specifies the name of the driver package to be added to the group. You must specify this option if the driver package cannot be uniquely identified by name.|  
|\/PackageId:<ID>|Specifies the ID for a package. To find the Package ID, click the driver group that the package is in \(or the **All Packages** node\), right\-click the package, and then click **Properties**. The Package ID is listed on the **General** tab, for example: **{DD098D20\-1850\-4FC8\-8E35\-EA24A1BEFF5E}**.|  
  
## <a name="BKMK_examples"></a>Examples  
To add a driver package, type one of the following:  
  
```  
WDSUTIL /Add-DriverGroupPackage /DriverGroup:PrinterDrivers /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318}  
```  
  
```  
WDSUTIL /Add-DriverGroupPackage /DriverGroup:PrinterDrivers /DriverPackage:XYZ  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the add-DriverGroupPackages Command](../Topic/Using-the-add-DriverGroupPackages-Command.md)  
  
[Using the add-DriverPackage Command](../Topic/Using-the-add-DriverPackage-Command.md)  
  
[Using the add-AllDriverPackages subcommand](../Topic/Using-the-add-AllDriverPackages-subcommand.md)  
  
