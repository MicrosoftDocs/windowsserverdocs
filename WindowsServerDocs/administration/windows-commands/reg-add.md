---
title: reg add
description: Reference article for the reg add command, which adds a new subkey or entry to the registry.
ms.topic: reference
ms.assetid: d9ad143e-dc10-4e2e-a229-408393c40079
ms.author: wscontent
author: xelu86
ms.date: 09/19/2023
---

# reg add

Adds a new subkey or entry to the registry.

## Syntax

```
reg add <keyname> [/v valuename | /ve] [/t datatype] [/s separator] [/d data] [/f] [/reg:32 | /reg:64]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey or entry to be added. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /v `<Valuename>` | Specifies the name of the add registry entry. |
| /ve | Specifies that the added registry entry has a null value. |
| /t `<Type>` | Specifies the type for the registry entry. *Type* must be one of the following:<ul><li>REG_SZ</li><li>REG_MULTI_SZ</li><li>REG_DWORD_BIG_ENDIAN</li><li>REG_DWORD</li><li>REG_BINARY</li><li>REG_DWORD_LITTLE_ENDIAN</li><li>REG_LINK</li><li>REG_FULL_RESOURCE_DESCRIPTOR</li><li>REG_EXPAND_SZ</li></ul> |
| /s `<Separator>` | Specifies the character to be used to separate multiple instances of data when the **REG_MULTI_SZ** data type is specified and more than one entry is listed. If not specified, the default separator is **\0**. |
| /d `<Data>` | Specifies the data for the new registry entry. |
| /f | Adds the registry entry without prompting for confirmation. |
| /reg:32 | Specifies the key should be accessed using the 32-bit registry view. |
| /reg:64 | Specifies the key should be accessed using the 64-bit registry view. |
| /? | Displays help at the command prompt. |

#### Remarks

- Subtrees can't be added with this operation. This version of **reg** doesn't ask for confirmation when adding a subkey.

- The return values for the **reg add** operation are:

| Value | Description |
|--|--|
| 0 | Success |
| 1 | Failure |

- For the **REG_EXPAND_SZ** key type, use the caret symbol ( **^** ) with **%** inside the /d parameter.

### Examples

To add the key *HKLM\Software\MyCo* on remote computer *ABC*, type:

```
reg add \\ABC\HKLM\Software\MyCo
```

To add a registry entry to *HKLM\Software\MyCo* with a value named *Data*, the type *REG_BINARY*, and data of *fe340ead*, type:

```
reg add HKLM\Software\MyCo /v Data /t REG_BINARY /d fe340ead
```

To add a multi-valued registry entry to  *HKLM\Software\MyCo* with a value named *MRU*, the type *REG_MULTI_SZ*, and data of *fax\0mail\0*, type:

```
reg add HKLM\Software\MyCo /v MRU /t REG_MULTI_SZ /d fax\0mail\0
```

To add an expanded registry entry to *HKLM\Software\MyCo* with a value named *Path*, the type *REG_EXPAND_SZ*, and data of *%systemroot%*, type:

```
reg add HKLM\Software\MyCo /v Path /t REG_EXPAND_SZ /d ^%systemroot^%
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
