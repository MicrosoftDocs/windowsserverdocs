---
title: reg copy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3fe74213-39ec-4b2d-ba3d-086243eac997
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg copy



Copies a registry entry to a specified location on the local or remote computer.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
reg copy <KeyName1> <KeyName2> [/s] [/f]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName1>|Specifies the full path of the subkey to copy. To specify a remote computer, include the computer name (in the format \\\\ComputerName\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|\<KeyName2>|Specifies the full path of the subkey destination. To specify a remote computer, include the computer name (in the format \\\\ComputerName\) as part of the *KeyName*. Omitting \\\\ComputerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/s|Copies all subkeys and entries under the specified subkey.|
|/f|Copies the subkey without prompting for confirmation.|
|/?|Displays help for **reg** copy at the command prompt.|

## Remarks

-   Reg does not ask for confirmation when copying a subkey.
-   The following table lists the return values for the **reg copy** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples

To copy all subkeys and values under the key MyApp to the key SaveMyApp, type:
```
REG COPY HKLM\Software\MyCo\MyApp HKLM\Software\MyCo\SaveMyApp /s
```
To copy all values under the key MyCo on the computer named ZODIAC to the key MyCo1 on the current computer, type:
```
REG COPY \\ZODIAC\HKLM\Software\MyCo HKLM\Software\MyCo1
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)