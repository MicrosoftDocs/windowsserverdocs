---
title: reg delete
description: Reference article for the reg delete command, which deletes a subkey or entries from the registry.
ms.topic: reference
ms.assetid: cee05071-1607-4ab1-b8ab-65caebeb85c3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg delete

Deletes a subkey or entries from the registry.

## Syntax

```
reg delete <keyname> [{/v Valuename | /ve | /va}] [/f]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey or entry to be deleted. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /v `<Valuename>` | Deletes a specific entry under the subkey. If no entry is specified, then all entries and subkeys under the subkey will be deleted. |
| /ve | Specifies that only entries that have no value will be deleted. |
| /va | Deletes all entries under the specified subkey. Subkeys under the specified subkey are not deleted. |
| /f | Deletes the existing registry subkey or entry without asking for confirmation. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg delete** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To delete the registry key Timeout and its all subkeys and values, type:

```
reg delete HKLM\Software\MyCo\MyApp\Timeout
```

To delete the registry value MTU under HKLM\Software\MyCo on the computer named ZODIAC, type:

```
reg delete \\ZODIAC\HKLM\Software\MyCo /v MTU
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
