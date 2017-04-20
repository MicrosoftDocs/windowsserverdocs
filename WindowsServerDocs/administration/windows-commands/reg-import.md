---
title: reg import
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0be103de-08fc-4f02-b590-361782680b3e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# reg import

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies the contents of a file that contains exported registry subkeys, entries, and values into the registry of the local computer.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
reg import FileName
```
## Parameters
|Parameter|Description|
|-------|--------|
|<FileName>|Specifies the name and path of the file that has content to be copied into the registry of the local computer. This file must be created in advance by using **reg export**.|
|/?|Displays help for **reg import** at the command prompt.|
## remarks
The following table lists the return values for the **reg import** operation.
|Value|Description|
|-----|--------|
|0|Success|
|1|Failure|
## <a name="BKMK_examples"></a>Examples
To import registry entries from the file named AppBkUp.reg, type:
```
reg import AppBkUp.reg
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
