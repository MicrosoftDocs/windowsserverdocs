---
title: logman import and logman export
description: Reference article for logman import and logman export, which imports a Data Collector Set from an XML file, or exports a Data Collector Set to an XML file.
ms.topic: reference
ms.assetid: c258daba-fb93-47c0-a53b-2fe83ed2c743
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman import and logman export

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Imports a Data Collector Set from an XML file, or exports a Data Collector Set to an XML file.

## Syntax

```
logman import <[-n] <name> <-xml <name> [options]
logman export <[-n] <name> <-xml <name> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Perform the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -xml `<name>` | Name of the XML file to import or export. |
| -ets | Sends commands to Event Trace Sessions directly without saving or scheduling. |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering an `*` for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
| -y | Answers yes to all questions without prompting. |
| /? | Displays context-sensitive help. |

### Examples

To import the XML file *c:\windows\perf_log.xml* from the computer *server_1* as a data collector set called *perf_log*, type:

```
logman import perf_log -s server_1 -xml c:\windows\perf_log.xml
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman command](logman.md)
