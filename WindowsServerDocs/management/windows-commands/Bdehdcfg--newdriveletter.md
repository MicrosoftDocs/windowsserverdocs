---
title: Bdehdcfg: newdriveletter
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f1f200a0-6850-4f0d-9047-f9f982a590f8

author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bdehdcfg: newdriveletter
Assigns a new drive letter to the portion of a drive used as the system drive. For an example of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
bdehdcfg -target {default|unallocated|<DriveLetter> shrink|<DriveLetter> merge} -newdriveletter <DriveLetter>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|<DriveLetter>|Defines the drive letter that will be assigned to the specified target drive.|
## Remarks
As a best practice, it is recommended that you do not assign a drive letter to your system drive.
## <a name="BKMK_Examples"></a>Examples
The following example shows the default drive being assigned the drive letter P.
```
bdehdcfg -target default -newdriveletter P:
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Bdehdcfg](Bdehdcfg.md)
