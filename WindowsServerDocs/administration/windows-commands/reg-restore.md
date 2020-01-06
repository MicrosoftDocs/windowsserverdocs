---
title: reg restore
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a51f1c0c-969b-4b76-930a-c8bb14dea26e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg restore



Writes saved subkeys and entries back to the registry.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
Reg restore <KeyName> <FileName>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName>|Specifies the full path of the subkey to be restored. The restore operation works only with the local computer. The KeyName must include a valid root key. Valid root keys are: HKLM, HKCU, HKCR, HKU, and HKCC.|
|\<FileName>|Specifies the name and path of the file with content to be written into the registry. This file must be created in advance with the **reg save** operation using a .hiv extension.|
|/?|Displays help for **reg restore** at the command prompt.|

## Remarks

-   Before editing any registry entries, save the parent subkey with the **reg save** operation. If the edit fails, restore the original subkey with the **reg restore** operation.
-   The following table lists the return values for the **reg restore** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples

To restore the file named NTRKBkUp.hiv into the key HKLM\Software\Microsoft\ResKit, and overwrite the existing contents of the key, type:
```
REG RESTORE HKLM\Software\Microsoft\ResKit NTRKBkUp.hiv
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)