---
title: logman delete
description: Reference article for the logman delete command, which deletes an existing data collector.
ms.topic: reference
ms.assetid: 8f3b2422-3dce-4fb4-adbb-8536b1d7da2b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman delete

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes an existing data collector.

## Syntax

```
logman delete <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Performs the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -ets | Sends commands to Event Trace Sessions directly without saving or scheduling. |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering a \* for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
| /? | Displays context-sensitive help. |

### Examples

To delete the data collector *perf_log*, type:

```
logman delete perf_log
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman command](logman.md)
