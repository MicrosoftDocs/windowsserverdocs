---
title: reg load
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b0b2b1b-f510-4108-9e9d-7057e924aa6e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg load

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Writes saved subkeys and entries into a different subkey in the registry. Intended for use with temporary files that are used for troubleshooting or editing registry entries.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg load KeyName FileName
```
## Parameters
|Parameter|Description|
|-------|--------|
|<KeyName>|Specifies the full path of the subkey to be loaded. For specifying remote computers, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|<FileName>|Specifies the name and path of the file to be loaded. This file must be created in advance by using the **reg save** operation and a .hiv extension.|
|/?|Displays help for **reg load** at the command prompt.|
## remarks
The following table lists the return values for the **reg load** operation.
|Value|Description|
|-----|--------|
|0|Success|
|1|Failure|
## <a name="BKMK_examples"></a>Examples
To load the file named TempHive.hiv to the key HKLM\TempHive, type:
```
reg LOAD HKLM\TempHive TempHive.hiv
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
