---
title: reg delete
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cee05071-1607-4ab1-b8ab-65caebeb85c3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg delete

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes a subkey or entries from the registry.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg delete <KeyName> [{/v ValueName | /ve | /va}] [/f]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<KeyName>|Specifies the full path of the subkey or entry to be deleted. To specify a remote computer, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/v <ValueName>|deletes a specific entry under the subkey. If no entry is specified, then all entries and subkeys under the subkey will be deleted.|
|/ve|Specifies that only entries that have no value will be deleted.|
|/va|deletes all entries under the specified subkey. Subkeys under the specified subkey are not deleted.|
|/f|deletes the existing registry subkey or entry without asking for confirmation.|
|/?|Displays help for **reg delete** at the command prompt.|
## remarks
The following table lists the return values for the **reg delete** operation.
|Value|Description|
|-----|--------|
|0|Success|
|1|Failure|
## <a name="BKMK_examples"></a>Examples
To delete the registry key timeout and its all subkeys and values, type:
```
reg delete HKLM\Software\MyCo\MyApp\timeout
```
To delete the registry value MTU under HKLM\Software\MyCo on the computer named ZODIAC, type:
```
reg delete \\ZODIAC\HKLM\Software\MyCo /v MTU
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
