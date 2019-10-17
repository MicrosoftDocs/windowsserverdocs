---
title: list
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57b6c8d0-872e-4dba-9715-1db8ab892e98
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# list



Lists writers, shadow copies, or currently registered shadow copy providers that are on the system. If used without parameters, **list** displays help at the command prompt.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
list writers [metadata | detailed | status]
list shadows {all | set <SetID> | id <ShadowID>}
list providers
```

## Parameters

|Parameter|Description|
|---------|-----------|
|writers|Lists writers. See [List writers](list-writers.md) for syntax and parameters.|
|shadows|Lists persistent and existing non-persistent shadow copies. See [List shadows](list-shadows.md) for syntax and parameters.|
|providers|Lists currently registered shadow copy providers. See [List providers](list-providers.md) for syntax and parameters.|

## <a name="BKMK_examples"></a>Examples

To list all shadow copies, type:
```
list shadows all
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)