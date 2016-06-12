---
title: Using the add-AllDriverPackages subcommand
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba6641c1-d7e9-43a9-9819-702dad5484ed
---
# Using the add-AllDriverPackages subcommand
adds all driver packages that are stored in a folder to a server.

## Syntax

```
wdsutil /add-AllDriverPackages /Folderpath:<Folder path> [/Server:<Server name>] [/Architecture:{x86 | ia64 | x64}] [/DriverGroup:<Group Name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/Folderpath:<Folder path>|Specifies the full path to the folder that contains the .inf files for the driver packages.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if no server name is specified, the local server is used.|
|\[\/Architecture:{x86 &#124; ia64 &#124; x64}\]|Specifies the architecture of the driver packages to add. Driver packages for other architectures are ignored.|
|\[\/DriverGroup:<Group Name>\]|Specifies the name of the driver group to which the packages should be added.|

## <a name="BKMK_examples"></a>Examples
To add driver packages, type one of the following:

```
wdsutil /verbose /add-AllDriverPackages /Folderpath:"C:\Temp\Drivers" /Architecture:x86
```

```
wdsutil /add-AllDriverPackages /Folderpath:"C:\Temp\Drivers\printers" /DriverGroup:"printer Drivers"
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[add\-WdsDriverPackage](http://technet.microsoft.com/library/dn283440.aspx)


