---
title: reg copy
description: Reference article for the reg copy command, which copies a registry entry to a specified location on the local or remote computer.
ms.topic: reference
ms.assetid: 3fe74213-39ec-4b2d-ba3d-086243eac997
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg copy

Copies a registry entry to a specified location on the local or remote computer.

## Syntax

```
reg copy <keyname1> <keyname2> [/s] [/f]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname1>` | Specifies the full path of the subkey or entry to be added. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| `<keyname2>` | Specifies the full path of the second subkey to be compared. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /s | Copies all subkeys and entries under the specified subkey. |
| /f | Copies the subkey without prompting for confirmation. |
| /? | Displays help at the command prompt. |

#### Remarks

- This command doesn't ask for confirmation when copying a subkey.

- The return values for the **reg compare** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To copy all subkeys and values under the key MyApp to the key SaveMyApp, type:

```
reg copy HKLM\Software\MyCo\MyApp HKLM\Software\MyCo\SaveMyApp /s
```

To copy all values under the key MyCo on the computer named ZODIAC to the key MyCo1 on the current computer, type:

```
reg copy \\ZODIAC\HKLM\Software\MyCo HKLM\Software\MyCo1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
