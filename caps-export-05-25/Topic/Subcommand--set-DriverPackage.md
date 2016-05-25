---
title: Subcommand: set-DriverPackage
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 11804bb6-ca29-4461-8c63-5131748cd742
---
# Subcommand: set-DriverPackage
Renames and\/or enables or disables a driver package on a server.  
  
## Syntax  
  
```  
WDSUTIL /Set-DriverPackage [/Server:<Server name>] {/DriverPackage:<Name> | /PackageId:<ID>} [/Name:<New Name>] [/Enabled:{Yes | No}  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|  
|\[\/DriverPackage:<Name>\]|Specifies the current name of the driver package to modify.|  
|\[\/PackageId:<ID>\]|Specifies the Windows Deployment Services ID of the driver package. You must specify this option if the driver package cannot be uniquely identified by name. To find this ID for a package, click the driver group that the package is in \(or the **All Packages** node\), right\-click the package, and then click **Properties**. The Package ID is listed on the **General** tab. For example: {DD098D20\-1850\-4FC8\-8E35\-EA24A1BEFF5E}.|  
|\[\/Name:<New Name>\]|Specifies the new name for the driver package.|  
|\[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
