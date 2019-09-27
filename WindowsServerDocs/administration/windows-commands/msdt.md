---
title: msdt
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ead1b672-a120-4e16-94aa-a8e13602c1d0

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# msdt



Invokes a troubleshooting pack at the command line or as part of an automated script, and enables additional options without user input.

## Syntax

```
msdt </id <name> | /path <name> | /cab < name>> <</parameter> [options] … <parameter> [options]>>
```

## Parameters

The following table includes the parameters and options supported by msdt.exe.


|      Parameter      |                                                                                            Description                                                                                             |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /id \<package name> |        Specifies which diagnostic package to run. For a list of available packages, see the Troubleshooting Pack ID in the "Available troubleshooting packs" section later in this topic.         |
|  /path \<directory  |                                                                                           .diagpkg file                                                                                            |
|   /dci \<passkey>   |                                        Prepopulates the passkey field in msdt. This parameter is only used when a support provider has supplied a passkey.                                         |
|  /dt \<directory>   | Displays the troubleshooting history in the specified directory. Diagnostic results are stored in the user's **%LOCALAPPDATA%\Diagnostics** or **%LOCALAPPDATA%\ElevatedDiagnostics** directories. |
| /af \<answer file>  |                                               Specifies an answer file in XML format that contains responses to one or more diagnostic interactions.                                               |

