---
title: regsvr32
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 3345e964-7d3e-42b8-abeb-42ed6edfe2b2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# regsvr32



Registers .dll files as command components in the registry.



## Syntax

```
regsvr32 [/u] [/s] [/n] [/i[:cmdline]] <DllName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|/u|Unregisters server.|
|/s|Runs **Regsvr32** without displaying messages.|
|/n|Runs **Regsvr32** without calling **DllRegisterServer**. (Requires the **/i** parameter.)|
|/i:\<cmdline>|Passes an optional command-line string (*cmdline*) to **DllInstall**. If you use this parameter in conjunction with the **/u** parameter, it calls **DllUninstall**.|
|\<DllName>|The name of the .dll file that will be registered.|
|/?|Displays help at the command prompt.|

## Examples

To register the .dll for the Active Directory Schema, type:
```
regsvr32 schmmgmt.dll
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)