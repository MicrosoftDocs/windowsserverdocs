---
title: reg save
description: Reference article for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: b326482b-c8af-467d-a20c-0481eeda3d5c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg save



Saves a copy of specified subkeys, entries, and values of the registry in a specified file.



## Syntax

```
reg save <KeyName> <FileName> [/y]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName>|Specifies the full path of the subkey. For specifying remote computers, include the computer name (in the format \\\\ComputerName\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|\<FileName>|Specifies the name and path of the file that is created. If no path is specified, the current path is used.|
|/y|Overwrites an existing file with the name *FileName* without prompting for confirmation.|
|/?|Displays help for **reg save** at the command prompt.|

## Remarks \<optional section>

-   The following table lists the return values for the **reg save** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|
-   Before editing any registry entries, save the parent subkey with the **reg save** operation. If the edit fails, restore the original subkey with the **reg restore** operation.

## Examples

To save the hive MyApp into the current folder as a file named AppBkUp.hiv, type:
```
REG SAVE HKLM\Software\MyCo\MyApp AppBkUp.hiv
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)