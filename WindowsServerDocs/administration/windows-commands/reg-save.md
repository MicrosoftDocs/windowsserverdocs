---
title: reg save
description: Reference article for the reg save command, which saves a copy of specified subkeys, entries, and values of the registry in a specified file.
ms.topic: reference
ms.assetid: b326482b-c8af-467d-a20c-0481eeda3d5c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg save

Saves a copy of specified subkeys, entries, and values of the registry in a specified file.

## Syntax

```
reg save <keyname> <filename> [/y]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| `<filename>` | Specifies the name and path of the created file. If no path is specified, the current path is used. |
| /y | Overwrites an existing file with the name *filename* without prompting for confirmation. |
| /? | Displays help at the command prompt. |

#### Remarks

- Before editing any registry entries, you must save the parent subkey using the **reg save** command. If the edit fails, you can then restore the original subkey using the **reg restore** operation.

- The return values for the **reg save** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To save the hive MyApp into the current folder as a file named AppBkUp.hiv, type:

```
reg save HKLM\Software\MyCo\MyApp AppBkUp.hiv
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [reg restore command](reg-restore.md)