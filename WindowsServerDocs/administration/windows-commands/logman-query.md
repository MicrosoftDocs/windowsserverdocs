---
title: logman query
description: Reference article for the logman query command, which queries data collector or data collector set properties.
ms.topic: reference
ms.assetid: 1116a0f0-5415-4369-a045-12f79f8f66de
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman query

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Queries data collector or data collector set properties.

## Syntax

```
logman query [providers|Data Collector Set name] [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Perform the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -ets | Sends commands to Event Trace Sessions directly without saving or scheduling. |
| /? | Displays context-sensitive help. |

### Examples

To list all Data Collector Sets configured on the target system, type:

```
logman query
```

To list the data collectors contained in the Data Collector Set named *perf_log*, type:

```
logman query perf_log
```

To list all available providers of data collectors on the target system, type:

```
logman query providers
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman command](logman.md)
