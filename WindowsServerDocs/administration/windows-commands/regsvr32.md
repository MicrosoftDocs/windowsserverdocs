---
title: regsvr32
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3345e964-7d3e-42b8-abeb-42ed6edfe2b2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# regsvr32

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

registers .dll files as command components in the registry.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
regsvr32 [/u] [/s] [/n] [/i[:cmdline]] <DllName>
```
## Parameters
|Parameter|Description|
|-------|--------|
|/u|Unregisters server.|
|/s|Runs **regsvr32** without displaying messages.|
|/n|Runs **regsvr32** without calling **DllregisterServer**. (Requires the **/i** parameter.)|
|/i:<cmdline>|Passes an optional command-line string (*cmdline*) to **DllInstall**. If you use this parameter in conjunction with the **/u** parameter, it calls **DllUninstall**.|
|<DllName>|The name of the .dll file that will be registered.|
|/?|Displays help at the command prompt.|
## <a name="BKMK_examples"></a>Examples
To register the .dll for the active directory Schema, type:
```
regsvr32 schmmgmt.dll
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
