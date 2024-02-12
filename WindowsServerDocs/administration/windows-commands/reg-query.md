---
title: reg query
description: Reference article for the reg query command, which returns a list of the next tier of subkeys and entries that are located under a specified subkey in the registry.
ms.topic: reference
ms.assetid: 0e6a0d7c-ed9b-4318-833d-33f265a81f39
ms.author: alalve
author: JasonGerend
ms.date: 11/02/2022
---

# reg query

Returns a list of the next tier of subkeys and entries that are located under a specified subkey in the registry.

## Syntax

```
reg query <keyname> [{/v <valuename> | /ve}] [/s] [/se <separator>] [/f <data>] [{/k | /d}] [/c] [/e] [/t <Type>] [/z] [/reg:32] [/reg:64]
```

### Parameters

| Parameter | Description |
|--|--|
| `<keyname>` | Specifies the full path of the subkey. To specify a remote computer, include the computer name (in the format `\\<computername>\`) as part of the *keyname*. Omitting `\\<computername>\` causes the operation to default to the local computer. The *keyname* must include a valid root key. Valid root keys for the local computer are: **HKLM**, **HKCU**, **HKCR**, **HKU**, and **HKCC**. If a remote computer is specified, valid root keys are: **HKLM** and **HKU**. If the registry key name contains a space, enclose the key name in quotes. |
| /v `<valuename>` | Specifies the registry value name that is to be queried. If omitted, all value names for *keyname* are returned. *Valuename* for this parameter is optional if the **/f** option is also used. |
| /ve | Runs a query for value names that are empty. |
| /s | Specifies to query all subkeys and value names recursively. |
| /se `<separator>` | Specifies the single value separator to search for in the value name type **REG_MULTI_SZ**. If *separator* isn't specified, **\0** is used. |
| /f `<data>` | Specifies the data or pattern to search for. Use double quotes if a string contains spaces. If not specified, a wildcard (**&#42;**) is used as the search pattern. |
| /k | Specifies to search in key names only. Must be used with /f. |
| /d | Specifies to search in data only. |
| /c | Specifies that the query is case sensitive. By default, queries are not case sensitive. |
| /e | Specifies to return only exact matches. By default, all the matches are returned. |
| /t `<Type>` | Specifies registry types to search. Valid types are: **REG_SZ**, **REG_MULTI_SZ**, **REG_EXPAND_SZ**, **REG_DWORD**, **REG_BINARY**, **REG_NONE**. If not specified, all types are searched. |
| /z | Specifies to include the numeric equivalent for the registry type in search results. |
| /reg:32 | Specifies the key should be accessed using the 32-bit registry view. |
| /reg:64 | Specifies the key should be accessed using the 64-bit registry view. |
| /? | Displays help at the command prompt. |

#### Remarks

- The return values for the **reg query** operation are:

    | Value | Description |
    |--|--|
    | 0 | Success |
    | 1 | Failure |

### Examples

To display the value of the name value Version in the HKLM\Software\Microsoft\ResKit key, type:

```
reg query HKLM\Software\Microsoft\ResKit /v Version
```

To display all subkeys and values under the key HKLM\Software\Microsoft\ResKit\Nt\Setup on a remote computer named ABC, type:

```
reg query \\ABC\HKLM\Software\Microsoft\ResKit\Nt\Setup /s
```

To display all the subkeys and values of the type REG_MULTI_SZ using **#** as the separator, type:

```
reg query HKLM\Software\Microsoft\ResKit\Nt\Setup /se #
```

To display the key, value, and data for exact and case sensitive matches of SYSTEM under the HKLM root of data type REG_SZ, type:

```
reg query HKLM /f SYSTEM /t REG_SZ /c /e
```

To display the key, value, and data that match **0F** in the data under the HKCU root key of data type REG_BINARY, type:

```
reg query HKCU /f 0F /d /t REG_BINARY
```

To display the keys, values, and data that match **asp.net** under the key HKLM\SOFTWARE\Microsoft and all subkeys, type:

```
reg query HKLM\SOFTWARE\Microsoft /s /f asp.net
```

To display only the keys that match **asp.net** under the key HKLM\SOFTWARE\Microsoft and all subkeys, type:

```
reg query HKLM\SOFTWARE\Microsoft /s /f asp.net /k
```

To display the value and data for value names of null (default) under HKLM\SOFTWARE, type:

```
reg query HKLM\SOFTWARE /ve
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
