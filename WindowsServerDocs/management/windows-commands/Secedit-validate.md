---
title: Secedit:validate
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9fb06354-f55a-4ca4-9fbc-9a872eb9b9cf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Secedit:validate
Validates the security settings stored in a security template (.inf file). For examples of how this command can be used, see [Examples](Secedit-validate.md#BKMK_Examples).
## Syntax
```
Secedit /validate <configuration file name>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|Configuration file name|Required.<br /><br />Specifies the path and file name for the security template that will be validated.|
## Remarks
Validating security templates can help you if one is corrupted or inappropriately set.
An invalid security template will not be applied.
The log file will not be updated.
In Windows Server 2008, `Secedit /refreshpolicy` has been replaced with `gpupdate`. For information on how to refresh security settings, see [Gpupdate](Gpupdate.md).
## <a name="BKMK_Examples"></a>Examples
After a rollback is performed on a security template, you want to verify that the rollback inf file, secRBKcontoso.inf, is valid.
```
Secedit /validate secRBKcontoso.inf
```
## Additional references
-   [Secedit:generaterollback](Secedit-generaterollback.md)
-   [Secedit](Secedit.md)
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
