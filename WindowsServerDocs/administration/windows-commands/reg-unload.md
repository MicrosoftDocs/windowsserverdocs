---
title: reg unload
description: Reference article for the reg unload command, which removes a section of the registry loaded using the reg load operation.
ms.topic: reference
ms.assetid: 1d07791d-ca27-454e-9797-27d7e84c5048
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg unload

Removes a section of the registry that was loaded using the **reg load** operation.

## Syntax

```
reg unload <keyname>
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg unload** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

## Examples

To unload the hive TempHive in the file HKLM, type:

```
reg unload HKLM\TempHive
```

> [!CAUTION]
> Don't edit the registry directly unless you have no alternative. The registry editor bypasses standard safeguards, allowing settings that can degrade performance, damage your system, or even require you to reinstall Windows. You can safely alter most registry settings by using the programs in Control Panel or Microsoft Management Console (MMC). If you must edit the registry directly, back it up first.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [reg load command](reg-load.md)
