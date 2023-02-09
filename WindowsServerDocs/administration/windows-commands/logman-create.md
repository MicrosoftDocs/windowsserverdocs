---
title: logman create
description: Reference article for the logman create command, which creates a counter, trace, configuration data collector, or API.
ms.topic: reference
ms.assetid: 972f0126-7bc4-4b14-9265-062864f3ffd4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman create

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a counter, trace, configuration data collector, or API.

## Syntax

```
logman create <counter | trace | alert | cfg | api> <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [logman create counter](logman-create-counter.md) | Creates a counter data collector. |
| [logman create trace](logman-create-trace.md) | Creates a trace data collector. |
| [logman create alert](logman-create-alert.md) | Creates an alert data collector. |
| [logman create cfg](logman-create-cfg.md) | Creates a configuration data collector. |
| [logman create api](logman-create-api.md) | Creates an API tracing data collector. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman command](logman.md)
