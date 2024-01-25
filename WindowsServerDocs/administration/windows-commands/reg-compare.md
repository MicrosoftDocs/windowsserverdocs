---
title: reg compare
description: Reference article for the reg compare command, which compares specified registry subkeys or entries.
ms.topic: reference
ms.assetid: 177dc6a3-034e-4846-a394-330d03c14e0b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# reg compare

Compares specified registry subkeys or entries.

## Syntax

```
reg compare <keyname1> <keyname2> [{/v Valuename | /ve}] [{/oa | /od | /os | on}] [/s]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname1>` | Specifies the full path of the subkey or entry to be added. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| `<keyname2>` | Specifies the full path of the second subkey to be compared. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. Specifying only the computer name in *keyname2* causes the operation to use the path to the subkey specified in *keyname1*. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /v `<Valuename>` | Specifies the value name to compare under the subkey. |
| /ve | Specifies that only entries that have a value name of null should be compared. |
| /oa | Specifies that all differences and matches are displayed. By default, only the differences are listed. |
| /od | Specifies that only differences are displayed. This is the default behavior. |
| /os | Specifies that only matches are displayed. By default, only the differences are listed. |
| /on | Specifies that nothing is displayed. By default, only the differences are listed. |
| /s | Compares all subkeys and entries recursively. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg compare** operation are:

    | Value | Description |
    |--|--|
    | 0 | The comparison is successful and the result is identical. |
    | 1 | The comparison failed. |
    | 2 | The comparison was successful and differences were found. |

- The symbols displayed in the results, include:

    | Symbol | Description |
    |--|--|
    | = | *KeyName1* data is equal to *KeyName2* data. |
    | < | *KeyName1* data is less than *KeyName2* data. |
    | > | *KeyName1* data is greater than *KeyName2* data. |

### Examples

To compare all values under the key **MyApp** with all values under the key **SaveMyApp**, type:

```
reg compare HKLM\Software\MyCo\MyApp HKLM\Software\MyCo\SaveMyApp
```

To compare the value for the Version under the key **MyCo** and the value for the Version under the key **MyCo1**, type:

```
reg compare HKLM\Software\MyCo HKLM\Software\MyCo1 /v Version
```

To compare all subkeys and values under HKLM\Software\MyCo on the computer named ZODIAC, with all subkeys and values under HKLM\Software\MyCo on the local computer, type:

```
reg compare \\ZODIAC\HKLM\Software\MyCo \\. /s
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
