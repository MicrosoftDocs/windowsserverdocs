---
title: bdehdcfg restart
description: Reference article for the bdehdcfg restart command, which tells bdehdcfg that the computer should be restarted after the drive preparation has concluded.
ms.topic: reference
ms.assetid: a98b76bb-36f1-4790-b337-7dc35f606bc6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bdehdcfg: restart

Informs the bdehdcfg command-line tool that the computer should be restarted after the drive preparation has concluded. If other users are logged on to the computer and the **quiet** command is not specified, a prompt appears to confirm that the computer should be restarted.

## Syntax

```
bdehdcfg -target {default|unallocated|<drive_letter> shrink|<drive_letter> merge} -restart
```

#### Parameters

This command has no additional parameters.

## Examples

To use the **restart** command:

```
bdehdcfg -target default -restart
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
