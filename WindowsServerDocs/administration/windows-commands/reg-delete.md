---
title: reg delete
description: Reference article for the reg delete command, which deletes a key, subkey, or entries from the registry.
ms.topic: reference
ms.assetid: cee05071-1607-4ab1-b8ab-65caebeb85c3
ms.author: alalve
author: JasonGerend
ms.date: 10/20/2022
---

# reg delete

Deletes a subkey or entries from the registry.

## Syntax

```
reg delete <keyname> [{/v valuename | /ve | /va}] [/f]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname1>` | Specifies the full path of the subkey or entry to be deleted. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /v `<valuename>` | Deletes a specific entry under the subkey. If no entry is specified, then all entries and subkeys under the subkey will be deleted. |
| /ve | Specifies that only entries that have no value will be deleted. |
| /va | Deletes all entries within the specified key. Subkey entries that reside within the specified key are not deleted. |
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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
