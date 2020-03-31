---
title: bitsadmin rawreturn
description: Windows Commands topic for bitsadmin rawreturn, which returns data suitable for parsing.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: bbe97130-26f6-4cdd-84f1-baf530ce38b7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin rawreturn

Returns data suitable for parsing.

## Syntax

```
bitsadmin /RawReturn
```

## Remarks

Strips newline characters and formatting from the output.

Typically, you use this command in conjunction with the **Create** and **Get\\*** switches to receive only the value. You must specify this switch before other switches.

## <a name=BKMK_examples></a>Examples

The following example retrieves the raw data for the state of the job named *myDownloadJob*.
```
C:\>bitsadmin /RawReturn /GetState myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)