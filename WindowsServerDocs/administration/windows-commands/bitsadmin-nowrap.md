---
title: bitsadmin nowrap
description: Reference article for the bitsadmin nowrap command, which truncates any line of output text extending beyond the rightmost edge of the command window.
ms.topic: reference
ms.assetid: 85a47b90-783a-41e4-96f2-81f26ae8ca93
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin nowrap

Truncates any line of output text extending beyond the right-most edge of the command window. By default, all switches, except the **monitor** switch, wrap the output. Specify the **nowrap** switch before other switches.

## Syntax

```
bitsadmin /nowrap
```

## Examples

To retrieve the state for the job named *myDownloadJob* while not wrapping the output:

```
bitsadmin /nowrap /getstate myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
