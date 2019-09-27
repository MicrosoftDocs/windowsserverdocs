---
title: add alias
description: "Windows Commands topic for **add alias** - adds aliases to the alias environment."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5fe12f5d-11e9-4f3d-b7f9-40b26c8685e5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# add alias



Adds aliases to the alias environment. If used without parameters, **add alias** displays help at the command prompt.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
add alias <AliasName> <AliasValue>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<AliasName>|Specifies the name of the alias.|
|\<AliasValue>|Specifies the value of the alias.|
|/?|Displays help at the command prompt.|

## Remarks

-   Aliases are saved in the metadata file and will be loaded with the **load metadata** command.

## <a name="BKMK_examples"></a>Examples

To list all shadows, including their aliases, type:
```
list shadows all
```
The following excerpt shows a shadow copy to which the default alias, VSS_SHADOW_x, has been assigned:
```
* Shadow Copy ID = {ff47165a-1946-4a0c-b7f4-80f46a309278}
%VSS_SHADOW_1%
```
To assign a new alias with the name System1 to this shadow copy, type:
```
add alias System1 %VSS_SHADOW_1%
```
Alternatively, you can assign the alias by using the shadow copy ID:
```
add alias System1 {ff47165a-1946-4a0c-b7f4-80f46a309278}
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)