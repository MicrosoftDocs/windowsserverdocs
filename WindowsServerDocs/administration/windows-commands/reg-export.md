---
title: reg export
description: Reference article for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 0ad9526f-1e29-4fa5-9d2d-feaa92f12d7c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reg export



Copies the specified subkeys, entries, and values of the local computer into a file for transfer to other servers.



## Syntax

```
Reg export KeyName FileName [/y]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<KeyName>|Specifies the full path of the subkey. The export operation works only with the local computer. The KeyName must include a valid root key. Valid root keys are: HKLM, HKCU, HKCR, HKU, and HKCC.|
|\<FileName>|Specifies the name and path of the file to be created during the operation. The file must have a .reg extension.|
|/y|Overwrites any existing file with the name *FileName* without prompting for confirmation.|
|/?|Displays help for **reg export** at the command prompt.|

## Remarks

The following table lists the return values for the **reg export** operation.

|Value|Description|
|-----|-----------|
|0|Success|
|1|Failure|

## Examples

To export the contents of all subkeys and values of the key MyApp to the file AppBkUp.reg, type:
```
reg export HKLM\Software\MyCo\MyApp AppBkUp.reg
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)