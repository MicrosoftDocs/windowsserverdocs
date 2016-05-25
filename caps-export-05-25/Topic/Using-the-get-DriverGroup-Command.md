---
title: Using the get-DriverGroup Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cfe10c3-a63f-48e7-bef9-f6b474b4ddbe
---
# Using the get-DriverGroup Command
Displays information about the driver groups on a server.  
  
## Syntax  
  
```  
WDSUTIL /Get-DriverGroup /DriverGroup:<Group Name> [/Server:<Server name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/DriverGroup:<Group Name>|Specifies the name of the driver group.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN.  If a server name is not specified, the local server is used.|  
|\[\/Show: {PackageMetaData &#124; Filters &#124; All}\]|Displays the metadata for all the driver packages in the specified group. **PackageMetaData** displays information about all the filters for the driver group. **Filters** displays the metadata for all driver packages and filters for the group.|  
  
## <a name="BKMK_examples"></a>Examples  
To view information about a driver file, type:  
  
```  
WDSUTIL /Get-DriverGroup /DriverGroup:PrinterDrivers /Show:PackageMetaData  
```  
  
```  
WDSUTIL /Get-DriverGroup /DriverGroup:PrinterDrivers /Server:MyWdsServer /Show:Filters  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the get-AllDriverGroups Command](../Topic/Using-the-get-AllDriverGroups-Command.md)  
  
