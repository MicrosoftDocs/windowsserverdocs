---
title: reg unload
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1d07791d-ca27-454e-9797-27d7e84c5048
---
# reg unload
removes a section of the registry that was loaded using the **reg load** operation.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
reg unload <KeyName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<KeyName>|Specifies the full path of the subkey to be unloaded. for specifying remote computers, include the computer name \(in the format \\\\computerName\\\) as part of the *KeyName*. Omitting \\\\computerName\\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are HKLM, HKCU, HKCR, HKU, and HKCC. if a remote computer is specified, valid root keys are HKLM and HKU.|
|\/?|Displays help for **reg unload** at the command prompt.|

## remarks
The following table lists the return values for the **reg unload** option.

|Value|Description|
|---------|---------------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples
To unload the hive TempHive in the file HKLM, type:

```
reg UNLOAD HKLM\TempHive
```

> [!CAUTION]
> Do not edit the registry directly unless you have no alternative. The registry editor bypasses standard safeguards, allowing settings that can degrade performance, damage your system, or even require you to reinstall Windows. You can safely alter most registry settings by using the programs in Control Panel or Microsoft management Console \(mmc\). if you must edit the registry directly, back it up first.

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


