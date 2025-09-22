---
title: serverweroptin
description: Reference article for the serverweroptin command, which allows you to turn on error reporting.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# serverweroptin



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
