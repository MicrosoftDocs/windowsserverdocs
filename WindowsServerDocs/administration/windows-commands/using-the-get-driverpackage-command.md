---
title: Using the get-DriverPackage Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94d231e4-ff01-48e7-9bc8-7b0d97a4339e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the get-DriverPackage Command



Displays information about a driver package on the server.

## Syntax

```
WDSUTIL /Get-DriverPackage [/Server:<Server name>] {/DriverPackage:<Package Name> | /PackageId:<ID>} [/Show:{Drivers | Files | All}]
```

## Parameters

|        Parameter         |                                                                           Description                                                                            |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |              Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.               |
| [/DriverPackage:\<Name>] |                                                        Specifies the name of the driver package to show.                                                         |
|    [/PackageId:\<ID>]    | Specifies the Windows Deployment Services ID of the driver package to show. You must specify the ID if the driver package cannot be uniquely identified by name. |
|     [/Show: {Drivers     |                                                                              Files                                                                               |

## <a name="BKMK_examples"></a>Examples

To view information about a driver package, type one of the following:
```
WDSUTIL /Get-DriverPackage /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318}
```
```
WDSUTIL /Get-DriverPackage /DriverPackage:MyDriverPackage /Show:All
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)