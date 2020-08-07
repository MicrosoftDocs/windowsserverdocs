---
title: bitsadmin rawreturn
description: Reference article for the bitsadmin rawreturn command, which returns data suitable for parsing.
ms.topic: article
ms.assetid: bbe97130-26f6-4cdd-84f1-baf530ce38b7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin rawreturn

Returns data suitable for parsing. Typically, you use this command in conjunction with the **/create** and **/get*** switches to receive only the value. You must specify this switch before other switches.

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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
