---
title: bdehdcfg newdriveletter
description: Windows Commands topic for bdehdcfg newdriveletter - assigns a new drive letter to the portion of a drive used as the system drive.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f1f200a0-6850-4f0d-9047-f9f982a590f8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bdehdcfg: newdriveletter



Assigns a new drive letter to the portion of a drive used as the system drive. For an example of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -target {default|unallocated|<DriveLetter> shrink|<DriveLetter> merge} -newdriveletter <DriveLetter>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<DriveLetter>|Defines the drive letter that will be assigned to the specified target drive.|

## Remarks

As a best practice, it is recommended that you do not assign a drive letter to your system drive.

## <a name="BKMK_Examples"></a>Examples

The following example shows the default drive being assigned the drive letter P.
```
bdehdcfg -target default -newdriveletter P:
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Bdehdcfg](bdehdcfg.md)