---
title: Fondue
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fc4467f6-ddbb-4d6d-b51e-5a50a957b8c0
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Fondue
Enables Windows optional features by downloading required files from Windows Update or another source specified by Group Policy. The manifest file for the feature must already be installed in your Windows image. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).
## Syntax
```
Fondue.exe /enable-feature:<feature_name> [/caller-name:<program_name>] [/hide-ux:{all | rebootRequest}]
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|/enable-feature:<*feature_name*>|Specifies the name of the Windows optional feature you want to enable. You can only enable one feature per command line. To enable multiple features, use Fondue.exe for each feature.|
|/caller-name:<*program_name*>|Specifies the program or process name when you call Fondue.exe from a script or batch file. You can use this option to add the program name to the SQM report if there is an error.|
|/hide-ux:{all &#124; rebootRequest}|Use **all** to hide all messages to the user including progress and permission requests to access Windows Update. If permission is required, the operation will fail.<br /><br />Use **rebootRequest** to only hide user messages asking for permission to reboot the computer. Use this option if you have a script that controls reboot requests.|
## <a name="BKMK_Examples"></a>Examples
To enable Microsoft .NET Framework 3.5, type:
```
Fondue.exe /enable-feature:NETFX3
```
To enable Microsoft .NET Framework 3.5, add the program name to the SQM report, and not display messages to the user, type:
```
Fondue.exe /enable-feature:NETFX3 /caller-name:Admin.bat /hide-ux:all
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
## See Also
[Microsoft .NET Framework 3.5 Deployment Considerations](http://go.microsoft.com/fwlink/?LinkId=248869)
