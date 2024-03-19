---
title: list (diskshadow)
description: Reference article for the list command, which displays information about the shadow copy (snapshot) set of an existing drive or volume.
ms.topic: reference
ms.author: wscontent
author: xelu86
ms.date: 10/12/2023
---

# list (diskshadow)

Lists writers, shadow copies, or currently registered shadow copy providers that are on the system. If used without parameters, list displays help at the command prompt.

For examples of how to use this command, see Examples.

## Syntax

```
list writers [metadata | detailed | status]
list shadows {all | set <SetID> | id <ShadowID>}
list providers
```

### Parameters

|Parameter|Description|
|-|-|
|writers|Lists writers. See [List writers](list-writers.md) for syntax and parameters.|
|shadows|Lists persistent and existing non-persistent shadow copies. See [List shadows](list-shadows.md) for syntax and parameters.|
|providers|Lists currently registered shadow copy providers. See [List providers](list-providers.md) for syntax and parameters.|

### Examples

To list all shadow copies, type:

```
list shadows all
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
