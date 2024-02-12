---
title: logman start and logman stop
description: Reference article for the logman start and logman stop commands, which starts a data collector and sets the begin time to manual, or stops a Data Collector Set and sets the end time to manual.
ms.topic: reference
ms.assetid: a40006a1-876e-474b-aaf1-f365c730deea
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman start and logman stop

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **logman start** command starts a data collector and sets the begin time to manual. The **logman stop** command stops a Data Collector Set and sets the end time to manual.

## Syntax

```
logman start <[-n] <name>> [options]
logman stop <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Perform the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Specifies the name of the target object. |
| -ets | Sends commands to Event Trace Sessions directly, without saving or scheduling. |
| -as | Performs the requested operation asynchronously. |
| -? | Displays context-sensitive help. |

### Examples

To start the data collector *perf_log*, on the remote computer *server_1*, type:

```
logman start perf_log -s server_1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman command](logman.md)
