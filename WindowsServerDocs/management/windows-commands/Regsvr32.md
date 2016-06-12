---
title: regsvr32
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3345e964-7d3e-42b8-abeb-42ed6edfe2b2
---
# regsvr32
registers .dll files as command components in the registry.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
regsvr32 [/u] [/s] [/n] [/i[:cmdline]] <DllName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/u|Unregisters server.|
|\/s|Runs **regsvr32** without displaying messages.|
|\/n|Runs **regsvr32** without calling **DllregisterServer**. \(Requires the **\/i** parameter.\)|
|\/i:<cmdline>|Passes an optional command\-line string \(*cmdline*\) to **DllInstall**. if you use this parameter in conjunction with the **\/u** parameter, it calls **DllUninstall**.|
|<DllName>|The name of the .dll file that will be registered.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_examples"></a>Examples
To register the .dll for the active directory Schema, type:

```
regsvr32 schmmgmt.dll
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


