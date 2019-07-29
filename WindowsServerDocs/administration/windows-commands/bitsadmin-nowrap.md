---
title: bitsadmin nowrap
description: "Windows Commands topic for **bitsadmin nowrap** - Truncates any line of output text extending beyond the rightmost edge of the command window."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85a47b90-783a-41e4-96f2-81f26ae8ca93
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin nowrap

Truncates any line of output text extending beyond the rightmost edge of the command window.

## Syntax

```
bitsadmin /NoWrap
```

## Remarks

By default, all switches, except the **Monitor** switch, wrap the output. Specify the **NoWrap** switch before other switches.

## <a name="BKMK_examples"></a>Examples

The following example retrieves the state for the job named *myDownloadJob* and does not wrap the output
```
C:\>bitsadmin /NoWrap /GetState myDownloadJob
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)