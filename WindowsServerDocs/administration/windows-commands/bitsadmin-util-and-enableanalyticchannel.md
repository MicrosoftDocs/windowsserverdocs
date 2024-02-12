---
title: bitsadmin util and enableanalyticchannel
description: Reference article for the bitsadmin util and enableanalyticchannel command, which enables or disables the BITS client analytic channel.
ms.topic: reference
ms.assetid: 0d7645aa-b91b-4ed7-b630-a1e1be6f6ae9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin util and enableanalyticchannel

Enables or disables the BITS client analytic channel.

## Syntax

```
bitsadmin /util /enableanalyticchannel TRUE|FALSE
```

| Parameter | Description |
| --------- | ---------- |
| TRUE or FALSE | **TRUE** turns on content validation for the specified file, while **FALSE** turns it off. |

## Examples

To turn the BITS client analytic channel on or off.

```
bitsadmin /util / enableanalyticchannel TRUE
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin util command](bitsadmin-util.md)

- [bitsadmin command](bitsadmin.md)
