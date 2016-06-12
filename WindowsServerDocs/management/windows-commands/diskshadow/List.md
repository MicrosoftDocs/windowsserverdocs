---
title: list
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57b6c8d0-872e-4dba-9715-1db8ab892e98
---
# list
lists writers, shadow copies, or currently registered shadow copy providers that are on the system. if used without parameters, **list** displays help at the command prompt.

for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
list writers [metadata | detailed | status]
list shadows {all | set <SetID> | id <shadowID>}
list providers
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|writers|lists writers. See [list writers](list/list-writers.md) for syntax and parameters.|
|shadows|lists persistent and existing non\-persistent shadow copies. See [list shadows](list/list-shadows.md) for syntax and parameters.|
|providers|lists currently registered shadow copy providers. See [list providers](list/list-providers.md) for syntax and parameters.|

## <a name="BKMK_examples"></a>Examples
To list all shadow copies, type:

```
list shadows all
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


