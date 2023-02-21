---
title: serverweroptin
description: Reference article for the serverweroptin command, which allows you to turn on error reporting.
ms.topic: reference
ms.assetid: f3c0b0af-cafb-4f09-8b36-5a357ddf392d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# serverweroptin

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to turn on error reporting.

## Syntax

```
serverweroptin [/query] [/detailed] [/summary]
```

### Parameters

| Parameter | Description |
|--|--|
| /query | Verifies your current setting. |
| /detailed | Specifies to send detailed reports automatically. |
| /summary | Specifies to send summary reports automatically. |
| /? | Displays help at the command prompt. |

## Examples

To verify the current setting, type:

```
serverweroptin /query
```

To automatically send detailed reports, type:

```
serverweroptin /detailed
```

To automatically send summary reports, type:

```
serverweroptin /summary
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
