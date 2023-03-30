---
title: serverceipoptin
description: Reference article for the serverceipoptin, which allows you to participate in the Customer Experience Improvement Program (CEIP).
ms.topic: reference
ms.assetid: 3d7d7fa7-0689-4797-b802-36fe260d21a0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# serverceipoptin

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to participate in the Customer Experience Improvement Program (CEIP).

## Syntax

```
serverceipoptin [/query] [/enable] [/disable]
```

### Parameters

| Parameter | Description |
|--|--|
| /query | Verifies your current setting. |
| /enable | Turns on your participation in CEIP. |
| /disable | Turns off your participation in CEIP. |
| /? | Displays help at the command prompt. |

## Examples

To verify your current settings, type:

```
serverceipoptin /query
```

To turn on your participation, type:

```
serverceipoptin /enable
```

To turn off your participation, type:

```
serverceipoptin /disable
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
