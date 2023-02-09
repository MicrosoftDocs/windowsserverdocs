---
title: reg load
description: Reference article for the reg load command, which writes saved subkeys and entries into a different subkey in the registry.
ms.topic: reference
ms.assetid: 3b0b2b1b-f510-4108-9e9d-7057e924aa6e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg load

Writes saved subkeys and entries into a different subkey in the registry. This command is intended for use with temporary files that are used for troubleshooting or editing registry entries.

## Syntax

```
reg load <keyname> <filename>
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey to be loaded. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes.  |
| `<filename>` | Specifies the name and path of the file to be loaded. This file must be created in advance by using the **reg save** command, and must have a .hiv extension. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg load** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To load the file named TempHive.hiv to the key HKLM\TempHive, type:

```
reg load HKLM\TempHive TempHive.hiv
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [reg save command](reg-save.md)
