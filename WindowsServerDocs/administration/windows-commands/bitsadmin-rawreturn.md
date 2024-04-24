---
title: bitsadmin rawreturn
description: Reference article for the bitsadmin rawreturn command that returns data suitable for parsing.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# bitsadmin rawreturn

Applies to: Windows Server (All supported versions)

The bitsadmin rawreturn command returns data suitable for parsing. Typically, you use this command with the **/create** and **/get*** switches to receive only the value. You must specify this switch before other switches.

> [!NOTE]
> This command strips newline characters and formatting from the output.

## Syntax

```
bitsadmin /rawreturn
```

## Examples

To retrieve the raw data for the state of the job named *myDownloadJob*:

```
bitsadmin /rawreturn /getstate myDownloadJob
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)