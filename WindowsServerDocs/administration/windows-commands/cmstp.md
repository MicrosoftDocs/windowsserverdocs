---
title: cmstp
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 34aad544-11c3-4e85-8bbf-5bc5a971da93
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# cmstp

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Installs or removes a Connection Manager service profile. Used without optional parameters, **cmstp** installs a service profile with default settings appropriate to the operating system and to the user's permissions. 
## Syntax
Syntax 1:
```
ServiceProfileFileName .exe /q:a /c:"cmstp.exe ServiceProfileFileName .inf [/nf] [/ni] [/ns] [/s] [/su] [/u]"
```
Syntax 2:
```
cmstp.exe [/nf] [/ni] [/ns] [/s] [/su] [/u]  [Drive:][path]ServiceProfileFileName.inf"
```
### Parameters
|Parameter|Description|
|-------|--------|
|< ServiceProfileFileName >.exe|Specifies, by name, the installation package that contains the profile that you want to install.<br /><br />Required for Syntax 1 but not valid for Syntax 2.|
|/q:a|Specifies that the profile should be installed without prompting the user. The verification message that the installation has succeeded will still appear.<br /><br />Required for Syntax 1 but not valid for Syntax 2.|
|[Drive:][path] <ServiceProfileFileName>.inf|Required. Specifies, by name, the configuration file that determines how the profile should be installed.<br /><br />The [Drive:][path] parameter is not valid for Syntax 1.|
|/nf|Specifies that the support files should not be installed.|
|/ni|Specifies that a desktop icon should not be created. This parameter is only valid for computers running Windows 95, Windows 98, Windows NT 4.0, or Windows Millennium edition.|
|/ns|Specifies that a desktop shortcut should not be created. This parameter is only valid for computers running a member of the Windows Server 2003 family, Windows 2000, or Windows XP.|
|/s|Specifies that the service profile should be installed or uninstalled silently (without prompting for user response or displaying verification message).|
|/su|Specifies that the service profile should be installed for a single user rather than for all users. This parameter is only valid for computers running a Windows Server 2003, Windows 2000, or Windows XP.|
|/au|Specifies that the service profile should be installed for all users. This parameter is only valid for computers running Windows Server 2003, Windows 2000, or Windows XP.|
|/u|Specifies that the service profile should be uninstalled.|
|/?|Displays help at the command prompt.|
## Remarks
**/s** is the only parameter that you can use in combination with **/u**.
Syntax 1 is the typical syntax used in a custom installation application. To use this syntax, you must run **cmstp** from the directory that contains the <ServiceProfileFileName>.exe file.
## <a name="BKMK_Examples"></a>Examples
To install the Fiction service profile without any support files, type:
```
fiction.exe /c:"cmstp.exe fiction.inf /nf"
```
To silently install the Fiction service profile for a single user, type:
```
fiction.exe /c:"cmstp.exe fiction.inf /s /su"
```
To silently uninstall the Fiction service profile, type:
```
fiction.exe /c:"cmstp.exe fiction.inf /s /u"
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
