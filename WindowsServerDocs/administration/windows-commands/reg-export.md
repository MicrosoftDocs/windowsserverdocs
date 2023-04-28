---
title: reg export
description: Reference article for the reg export command, which copies the specified subkeys, entries, and values of the local computer into a file for transfer to other servers.
ms.topic: reference
ms.assetid: 0ad9526f-1e29-4fa5-9d2d-feaa92f12d7c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg export

Copies the specified subkeys, entries, and values of the local computer into a file for transfer to other servers.

## Syntax

```
reg export <keyname> <filename> [/y]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey. The export operation only works with the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If the registry key name contains a space, enclose the key name in quotes. |
| `<filename>` | Specifies the name and path of the file to be created during the operation. The file must have a .reg extension. |
| /y | Overwrites any existing file with the name *filename* without prompting for confirmation. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg export** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To export the contents of all subkeys and values of the key MyApp to the file AppBkUp.reg, type:

```
reg export HKLM\Software\MyCo\MyApp AppBkUp.reg
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
