---
title: dispdiag
description: Reference article for the dispdiag command, which logs display information to a file.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# dispdiag

Logs display information to a file.

## Syntax

```
dispdiag [-testacpi] [-d] [-delay <seconds>] [-out <filepath>]
```

#### Parameters

| Parameter | Description |
| --------- | ----------- |
| - testacpi | Runs hotkey diagnostics test. Displays the key name, code and scan code for any key pressed during the test. |
| -d | Generates a dump file with test results. |
| -delay `<seconds>` | Delays the collection of data by specified time in *seconds*. |
| -out `<filepath>`  | Specifies path and filename to save collected data. This must be the last parameter. |
| -? | Displays available command parameters and provides help for using them. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
