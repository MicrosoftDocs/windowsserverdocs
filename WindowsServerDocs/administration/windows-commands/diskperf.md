---
title: diskperf
description: Reference article for the diskperf command, which can be used to remotely enable or disable physical or logical disk performance counters on computers running Windows.
ms.topic: reference
ms.assetid: f06916e8-069b-4ec8-a6eb-59f1d9f77111
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# diskperf

The **diskperf** command remotely enables or disables physical or logical disk performance counters on computers running Windows.

## Syntax

```
diskperf [-y[d|v] | -n[d|v]] [\\computername]
```

## Options

| Option | Description |
| ------ | ----------- |
| -y | Starts all disk performance counters when the computer restarts. |
| -yd | Enables disk performance counters for physical drives when the computer restarts. |
| -yv | Enables disk performance counters for logical drives or storage volumes when the computer restarts. |
| -n | Disables all disk performance counters when the computer restarts. |
| -nd | Disable disk performance counters for physical drives when the computer restarts. |
| -nv | Disable disk performance counters for logical drives or storage volumes when the computer restarts. |
| `\\<computername>` | Specifies the name of the computer where you want to enable or disable disk performance counters. |
| -? | Displays context sensitive help. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
