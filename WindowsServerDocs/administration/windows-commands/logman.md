---
title: logman
description: Reference article for the logman command, which creates and manages Event Trace Session and Performance logs and supports many functions of Performance Monitor from the command line.
ms.topic: reference
ms.assetid: 574a5203-5b3b-4759-a678-f26d00dde447
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates and manages Event Trace Session and Performance logs and supports many functions of Performance Monitor from the command line.

## Syntax

```
logman [create | query | start | stop | delete| update | import | export | /?] [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [logman create](logman-create.md) | Creates a counter, trace, configuration data collector, or API. |
| [logman query](logman-query.md) | Queries data collector properties. |
| [logman start &#124; stop](logman-start-stop.md) | Starts or stops data collection. |
| [logman delete](logman-delete.md) | Deletes an existing data collector. |
| [logman update](logman-update.md) | Updates the properties of an existing data collector. |
| [logman import &#124; export](logman-import-export.md) | Imports a data collector set from an XML file or export a data collector set to an XML file. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
