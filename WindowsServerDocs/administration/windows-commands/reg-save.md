---
title: reg save
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b326482b-c8af-467d-a20c-0481eeda3d5c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg save

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Saves a copy of specified subkeys, entries, and values of the registry in a specified file.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg save <KeyName> <FileName> [/y]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<KeyName>|Specifies the full path of the subkey. For specifying remote computers, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|<FileName>|Specifies the name and path of the file that is created. If no path is specified, the current path is used.|
|/y|Overwrites an existing file with the name *FileName* without prompting for confirmation.|
|/?|Displays help for **reg save** at the command prompt.|
## remarks <optional section>
-   The following table lists the return values for the **reg save** operation.
|Value|Description|
|-----|--------|
|0|Success|
|1|Failure|
-   Before editing any registry entries, save the parent subkey with the **reg save** operation. If the edit fails, restore the original subkey with the **reg restore** operation.
## <a name="BKMK_examples"></a>Examples
To save the hive MyApp into the current folder as a file named AppBkUp.hiv, type:
```
reg SAVE HKLM\Software\MyCo\MyApp AppBkUp.hiv
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
