---
title: reg delete
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cee05071-1607-4ab1-b8ab-65caebeb85c3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg delete



Deletes a subkey or entries from the registry.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
Reg delete <KeyName> [{/v ValueName | /ve | /va}] [/f]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName>|Specifies the full path of the subkey or entry to be deleted. To specify a remote computer, include the computer name (in the format \\\\ComputerName\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/v \<ValueName>|Deletes a specific entry under the subkey. If no entry is specified, then all entries and subkeys under the subkey will be deleted.|
|/ve|Specifies that only entries that have no value will be deleted.|
|/va|Deletes all entries under the specified subkey. Subkeys under the specified subkey are not deleted.|
|/f|Deletes the existing registry subkey or entry without asking for confirmation.|
|/?|Displays help for **reg delete** at the command prompt.|

## Remarks

The following table lists the return values for the **reg delete** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples

To delete the registry key Timeout and its all subkeys and values, type:
```
REG DELETE HKLM\Software\MyCo\MyApp\Timeout
```
To delete the registry value MTU under HKLM\Software\MyCo on the computer named ZODIAC, type:
```
REG DELETE \\ZODIAC\HKLM\Software\MyCo /v MTU
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)