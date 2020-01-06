---
title: manage-bde changepin
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c85aa1c7-3485-4839-a292-99dfcd6db252
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# manage-bde: changepin



Modifies the PIN for an operating system drive. The user is prompted to enter a new PIN. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
manage-bde -changepin [<Drive>] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive>|Represents a drive letter followed by a colon.|
|-computername|Specifies that Manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.|
|\<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|-? or /?|Displays brief Help at the command prompt.|
|-help or -h|Displays complete Help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples

The following example illustrates using the **-changepin** command to change the PIN used with BitLocker on drive C.
```
manage-bde –changepin C:
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Manage-bde](manage-bde.md)