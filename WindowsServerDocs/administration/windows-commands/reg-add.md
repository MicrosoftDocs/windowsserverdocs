---
title: reg add
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d9ad143e-dc10-4e2e-a229-408393c40079
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg add


Adds a new subkey or entry to the registry.

## Syntax

```
reg add <KeyName> [{/v ValueName | /ve}] [/t DataType] [/s Separator] [/d Data] [/f]
```
For examples of how to use this command, see [Examples](#BKMK_examples).

## Parameters

|      Parameter      |                                                                                                                                                                                                                                                                   Description                                                                                                                                                                                                                                                                   |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<KeyName<em>></em> | Specifies the full path of the subkey or entry to be added. To specify a remote computer, include the computer name (in the format \\\\\<ComputerName>\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU. If the registry key name contains a space, enclose the key name in quotes. |
|   /v \<ValueName>   |                                                                                                                                                                                                                                Specifies the name of the registry entry to be added under the specified subkey.                                                                                                                                                                                                                                 |
|         /ve         |                                                                                                                                                                                                                                Specifies that the registry entry that is added to the registry has a null value.                                                                                                                                                                                                                                |
|     /t \<Type>      |                                                                                                                                          Specifies the type for the registry entry. *Type* must be one of the following:</br>REG_SZ</br>REG_MULTI_SZ</br>REG_DWORD_BIG_ENDIAN</br>REG_DWORD</br>REG_BINARY</br>REG_DWORD_LITTLE_ENDIAN</br>REG_LINK</br>REG_FULL_RESOURCE_DESCRIPTOR</br>REG_EXPAND_SZ                                                                                                                                          |
|   /s \<Separator>   |                                                                                                                                                              Specifies the character to be used to separate multiple instances of data when the REG_MULTI_SZ data type is specified and more than one entry needs to be listed. If not specified, the default separator is **\0**.                                                                                                                                                              |
|     /d \<Data>      |                                                                                                                                                                                                                                                 Specifies the data for the new registry entry.                                                                                                                                                                                                                                                  |
|         /f          |                                                                                                                                                                                                                                           Adds the registry entry without prompting for confirmation.                                                                                                                                                                                                                                           |
|         /?          |                                                                                                                                                                                                                                              Displays help for **reg add** at the command prompt.                                                                                                                                                                                                                                               |

## Remarks

-   Subtrees cannot be added with this operation. This version of **reg** does not ask for confirmation when adding a subkey.
-   The following table lists the return values for the **reg add** operation.

| Value | Description |
|-------|-------------|
|   0   |   Success   |
|   1   |   Failure   |

-   For the REG_EXPAND_SZ key type, use the caret symbol ( **^** ) with **%**" inside the /d parameter

## <a name="BKMK_examples"></a>Examples

To add the key HKLM\Software\MyCo on remote computer ABC, type:
```
REG ADD \\ABC\HKLM\Software\MyCo
```
To add a registry entry to HKLM\Software\MyCo with a value named **Data** of type REG_BINARY and data of **fe340ead**, type:
```
REG ADD HKLM\Software\MyCo /v Data /t REG_BINARY /d fe340ead
```
To add a multivalued registry entry to  HKLM\Software\MyCo with a value name of **MRU** of type REG_MULTI_SZ and data of **fax\0mail\0\0**, type:
```
REG ADD HKLM\Software\MyCo /v MRU /t REG_MULTI_SZ /d fax\0mail\0\0
```
To add an expanded registry entry to HKLM\Software\MyCo with a value name of **Path** of type REG_EXPAND_SZ and data of **%systemroot%**, type:
```
REG ADD HKLM\Software\MyCo /v Path /t REG_EXPAND_SZ /d ^%systemroot^%
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
