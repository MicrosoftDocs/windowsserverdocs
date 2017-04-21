---
title: reg copy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3fe74213-39ec-4b2d-ba3d-086243eac997
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg copy

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies a registry entry to a specified location on the local or remote computer.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg copy <KeyName1> <KeyName2> [/s] [/f]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<KeyName1>|Specifies the full path of the subkey to copy. To specify a remote computer, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|<KeyName2>|Specifies the full path of the subkey destination. To specify a remote computer, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/s|Copies all subkeys and entries under the specified subkey.|
|/f|Copies the subkey without prompting for confirmation.|
|/?|Displays help for **reg** copy at the command prompt.|
## remarks
-   reg does not ask for confirmation when copying a subkey.
-   The following table lists the return values for the **reg copy** operation.
|Value|Description|
|-----|--------|
|0|Success|
|1|Failure|
## <a name="BKMK_examples"></a>Examples
To copy all subkeys and values under the key MyApp to the key SaveMyApp, type:
```
reg copy HKLM\Software\MyCo\MyApp HKLM\Software\MyCo\SaveMyApp /s
```
To copy all values under the key MyCo on the computer named ZODIAC to the key MyCo1 on the current computer, type:
```
reg copy \\ZODIAC\HKLM\Software\MyCo HKLM\Software\MyCo1
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
