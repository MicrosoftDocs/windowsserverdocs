---
title: exec
description: Reference article for the exec command, which runs a script file on the local computer.
ms.topic: reference
ms.assetid: 364e8baf-576f-401b-a431-7d3c06621614
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# exec

Runs a script file on the local computer. This command also duplicates or restores data as part of a backup or restore sequence. If the script fails, an error is returned and DiskShadow quits.

The file can be a **cmd** script.

## Syntax

```
exec <scriptfile.cmd>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<scriptfile.cmd>` | Specifies the script file to run. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diskshadow command](diskshadow.md)
