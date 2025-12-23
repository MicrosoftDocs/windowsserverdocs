---
title: rundll32
description: Reference article for the rundll32 command, which loads and runs 32-bit dynamic-link libraries (DLLs).
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# rundll32

Loads and runs procedures from dynamic-link libraries (DLLs) conforming to a specific interface (see remarks).

## Syntax

```
rundll32 <dllName>,<procedureName> [<arguments>[ ...]]
```

### Parameters

| Parameter | Description |
|--|--|
| `<dllName>` | The DLL from which to run the procedure from. |
| `<procedureName>` | The name of the procedure to run. |
| `<arguments>` | Parameters to pass into the procedure `lpCmdLine`. |

### Example

```
rundll32 devmgr,DeviceProperties_RunDLL /DeviceID root\system\0000
```

## Remarks

Rundll32 assumes the procedure has an interface conforming with the [WinMain entry point](/windows/win32/learnwin32/winmain--the-application-entry-point).

The ```,``` separator between the DLL name and the procedure can alternatively be a space (" ").

The ```procedureName``` can also alternatively be an ordinal, e.g. (```#2```) for ordinal 2.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [Rundll32 printui.dll,PrintUIEntry](rundll32-printui.md)
- [DeviceProperties_RunDLL](/windows-hardware/drivers/install/deviceproperties-rundll-function-prototype)
