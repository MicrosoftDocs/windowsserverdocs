---
title: reg import
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0be103de-08fc-4f02-b590-361782680b3e
---
# reg import
Copies the contents of a file that contains exported registry subkeys, entries, and values into the registry of the local computer.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
reg import FileName
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<FileName>|Specifies the name and path of the file that has content to be copied into the registry of the local computer. This file must be created in advance by using **reg export**.|
|\/?|Displays help for **reg import** at the command prompt.|

## remarks
The following table lists the return values for the **reg import** operation.

|Value|Description|
|---------|---------------|
|0|Success|
|1|Failure|

## <a name="BKMK_examples"></a>Examples
To import registry entries from the file named AppBkUp.reg, type:

```
reg import AppBkUp.reg
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


