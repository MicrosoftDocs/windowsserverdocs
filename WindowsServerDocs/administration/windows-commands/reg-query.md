---
title: reg query
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e6a0d7c-ed9b-4318-833d-33f265a81f39
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg query



Returns a list of the next tier of subkeys and entries that are located under a specified subkey in the registry.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
reg query <KeyName> [{/v <ValueName> | /ve}] [/s] [/se <Separator>] [/f <Data>] [{/k | /d}] [/c] [/e] [/t <Type>] [/z]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName>|Specifies the full path of the subkey. For specifying remote computers, include the computer name (in the format \\\\ComputerName\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/v \<ValueName>|Specifies the registry value name that is to be queried. If omitted, all value names for *KeyName* are returned. *ValueName* for this parameter is optional if the **/f** option is also used.|
|/ve|Runs a query for value names that are empty.|
|/s|Specifies to query all subkeys and value names recursively.|
|/se \<Separator>|Specifies the single value separator to search for in the value name type REG_MULTI_SZ. If *Separator* is not specified, **\0** is used.|
|/f \<Data>|Specifies the data or pattern to search for. Use double quotes if a string contains spaces. If not specified, a wildcard (**&#42;**) is used as the search pattern.|
|/k|Specifies to search in key names only.|
|/d|Specifies to search in data only.|
|/c|Specifies that the query is case sensitive. By default, queries are not case sensitive.|
|/e|Specifies to return only exact matches. By default, all the matches are returned.|
|/t \<Type>|Specifies registry types to search. Valid types are: REG_SZ, REG_MULTI_SZ, REG_EXPAND_SZ, REG_DWORD, REG_BINARY, REG_NONE. If not specified, all types are searched.|
|/z|Specifies to include the numeric equivalent for the registry type in search results.|
|/?|Displays help for **reg query** at the command prompt.|

## Remarks \<optional section>

The following table lists the return values for the **reg query** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples

To display the value of the name value Version in the HKLM\Software\Microsoft\ResKit key, type:
```
REG QUERY HKLM\Software\Microsoft\ResKit /v Version
```
To display all subkeys and values under the key HKLM\Software\Microsoft\ResKit\Nt\Setup on a remote computer named ABC, type:
```
REG QUERY \\ABC\HKLM\Software\Microsoft\ResKit\Nt\Setup /s
```
To display all the subkeys and values of the type REG_MULTI_SZ using **#** as the separator, type:
```
REG QUERY HKLM\Software\Microsoft\ResKit\Nt\Setup /se #
```
To display the key, value, and data for exact and case sensitive matches of SYSTEM under the HKLM root of data type REG_SZ, type:
```
REG QUERY HKLM /f SYSTEM /t REG_SZ /c /e
```
To display the key, value, and data that match **0F** in the data under the HKCU root key of data type REG_BINARY.
```
REG QUERY HKCU /f 0F /d /t REG_BINARY
```
To display the value and data for value names of null (default) under HKLM\SOFTWARE, type:
```
REG QUERY HKLM\SOFTWARE /ve
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)