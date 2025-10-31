---
title: logman start and logman stop
description: Reference article for the logman start and logman stop commands, which starts a data collector and sets the begin time to manual, or stops a Data Collector Set and sets the end time to manual.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# logman start and logman stop



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
