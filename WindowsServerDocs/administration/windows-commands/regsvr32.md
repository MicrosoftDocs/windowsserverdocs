---
title: regsvr32
description: Reference article for the regsvr32 command, which registers .dll files as command components in the registry.
ms.topic: reference
ms.assetid: 3345e964-7d3e-42b8-abeb-42ed6edfe2b2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# regsvr32

Registers .dll files as command components in the registry.

## Syntax

```
regsvr32 [/u] [/s] [/n] [/i[:cmdline]] <Dllname>
```

### Parameters

| Parameter | Description |
|--|--|
| /u | Unregisters server. |
| /s | Prevents displaying messages. |
| /n | Prevents calling **DllRegisterServer**. This parameter requires you to also use the **/i** parameter. |
| /i:`<cmdline>` | Passes an optional command-line string (*cmdline*) to **DllInstall**. If you use this parameter with the **/u** parameter, it calls **DllUninstall**. |
| `<Dllname>` | The name of the .dll file that will be registered. |
| /? | Displays help at the command prompt. |

### Examples

To register the .dll for the Active Directory Schema, type:

```
regsvr32 schmmgmt.dll
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
