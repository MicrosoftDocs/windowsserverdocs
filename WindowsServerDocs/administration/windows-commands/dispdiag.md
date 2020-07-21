---
title: dispdiag
description: Reference article for the dispdiag command, which logs display information to a file.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 5079e1dd-b57c-44ed-970f-e6b409369e03
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
