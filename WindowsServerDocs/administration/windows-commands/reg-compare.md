---
title: reg compare
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 177dc6a3-034e-4846-a394-330d03c14e0b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg compare

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

compares specified registry subkeys or entries.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg compare <KeyName1> <KeyName2> [{/v ValueName | /ve}] [{/oa | /od | /os | on}] [/s]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<KeyName1>|Specifies the full path of the first subkey to be compared. To specify a remote computer, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|<KeyName2>|Specifies the full path of the second subkey to be compared. To specify a remote computer, include the computer name (in the format \\\computerName\\) as part of the *KeyName*. Omitting \\\computerName\ causes the operation to default to the local computer. Specifying only the computer name in *KeyName2* causes the operation to use the path to the subkey specified in *KeyName1*. The *KeyName* must include a valid root key. Valid root keys for the local computer are: HKLM, HKCU, HKCR, HKU, and HKCC. If a remote computer is specified, valid root keys are: HKLM and HKU.|
|/v <ValueName>|Specifies the value name to compare under the subkey.|
|/ve|Specifies that only entries that have a value name of null should be compared.|
|[{/oa &#124; /od &#124; /os &#124; on}]|Specifies how to display the results of the compare operation. The default is **/od**. See the specific options below.|
|/oa|Specifies that all differences and matches are displayed. By default, only the differences are listed.|
|/od|Specifies that only differences are displayed. This is the default behavior.|
|/os|Specifies that only matches are displayed. By default, only the differences are listed.|
|/on|Specifies that nothing is displayed. By default, only the differences are listed.|
|/s|compares all subkeys and entries recursively.|
|/?|Displays help for **reg compare** at the command prompt.|
## remarks
The following table lists the return values for **reg compare**.
|Value|Description|
|-----|--------|
|0|The comparison is successful and the result is identical.|
|1|The comparison failed.|
|2|The comparison was successful and differences were found.|
The following table lists the symbols displayed in the results.
|Symbol|Description|
|-----|--------|
|=|*KeyName1* data is equal to *KeyName2* data.|
|<|*KeyName1* data is less than *KeyName2* data.|
|>|*KeyName1* data is greater than *KeyName2* data.|
## <a name="BKMK_examples"></a>Examples
To compare all values under the key **MyApp** with all values under the key **SaveMyApp**, type:
reg compARE HKLM\Software\MyCo\MyApp HKLM\Software\MyCo\SaveMyApp
To compare the value for the version under the key **MyCo** and the value for the version under the key **MyCo1**, type:
reg compARE HKLM\Software\MyCo HKLM\Software\MyCo1 /v version
To compare all subkeys and values under HKLM\Software\MyCo on the computer named ZODIAC with all subkeys and values under HKLM\Software\MyCo on the local computer, type:
reg compARE \\\ZODIAC\HKLM\Software\MyCo \\\\. /s
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
