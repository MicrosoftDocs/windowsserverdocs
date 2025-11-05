---
title: refsutil iometrics
description: Reference article for the refsutil iometrics tool, which tracks IO data to monitor performance and usage patterns on a Resilient File System (ReFS) volume in Windows.
author: robinharwood
ms.author: roharwoo
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil iometrics

The `refsutil iometrics` command allows you to query or set volume heat parameters for tracking input/output (IO) metrics on a ReFS (Resilient File System) volume. This tool helps monitor and manage the performance and usage patterns on the volume.

## Syntax

```
refsutil iometrics <drive> <[/q]> | <[/s] [/st <seconds>] [/sp <seconds>] [/sg <number>]>
```

## Parameters

| Parameters | Description |
|--|--|
| `<drive>` | Specifies the drive letter of the volume to be compressed in the format `E:`. |
| `/q` | Queries the current volume activity tracking settings. |
| `/s` | Configures the volume activity tracking settings. |
| `/st <seconds>` | Specifies how long in seconds the volume should track IO activity. |
| `/sp <seconds>` | Specifies how often in seconds the IO metrics should be tracked. |
| `/sg <number>` | Specifies the number of periods to track per volume tracking unit. |

ReFS enforces values for `/st`, `/sp`, and `/sg` to be within suitable ranges and adjusts them to the filesystem minimums if needed. These values can be omitted, in which case ReFS uses default settings. The current minimum values are:

- `/st`: 3,600 seconds (1 hour)
- `/sp`: 10 seconds
- `/sg`: 5 periods

## Examples

To query the volume activity tracking settings on the F: drive, run the command:

```
refsutil iometrics F: /q
```

To set the volume activity tracking settings on drive F: with default values, run the command:

```
refsutil iometrics F: /s
```

To set the volume activity tracking settings on drive F: to track IO activity for 604,800 seconds or 7 (seven) days, run the command:

```
refsutil iometrics F: /s /st 604800
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
