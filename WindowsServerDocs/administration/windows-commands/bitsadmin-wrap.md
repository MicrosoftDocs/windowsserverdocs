---
title: bitsadmin wrap
description: Reference article for the bitsadmin wrap command, which wraps any line of output text extending beyond the rightmost edge of the command window to the next line.
ms.topic: reference
ms.assetid: 14e57522-539d-4621-ad15-09f7a44ccab7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# bitsadmin wrap

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Wraps any line of output text extending beyond the rightmost edge of the command window to the next line. You must specify this switch before any other switches.

By default, all switches except the [bitsadmin monitor](bitsadmin-monitor.md) switch, wrap the output text.

## Syntax

```
bitsadmin /wrap <job>
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| job | The job's display name or GUID. |

## Examples

To retrieve information for the job named *myDownloadJob* and wrap the output text:

```
bitsadmin /wrap /info myDownloadJob /verbose
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
