---
title: reg restore
description: Reference article for the reg restore command, which writes saved subkeys and entries back to the registry.
ms.topic: reference
ms.assetid: a51f1c0c-969b-4b76-930a-c8bb14dea26e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg restore

Writes saved subkeys and entries back to the registry.

## Syntax

```
reg restore <keyname> <filename>
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey to be restored. The restore operation only works with the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If the registry key name contains a space, enclose the key name in quotes. |
| `<filename>` | Specifies the name and path of the file with content to be written into the registry. This file must be created in advance by using the **reg save** command, and must have a .hiv extension. |
| /? | Displays help at the command prompt. |

#### Remarks

- Before editing any registry entries, you must save the parent subkey using the **reg save** command. If the edit fails, you can then restore the original subkey using the **reg restore** operation.

- The return values for the **reg restore** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To restore the file named NTRKBkUp.hiv into the key HKLM\Software\Microsoft\ResKit, and overwrite the existing contents of the key, type:

```
reg restore HKLM\Software\Microsoft\ResKit NTRKBkUp.hiv
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [reg save command](reg-save.md)
