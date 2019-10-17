---
title: bdehdcfg restart
description: Windows Commands topic for bdehdcfg restart - Tells bdehdcfg that the computer should be restarted after the drive preparation has concluded.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a98b76bb-36f1-4790-b337-7dc35f606bc6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bdehdcfg: restart



Informs the Bdehdcfg command-line tool that the computer should be restarted after the drive preparation has concluded. For an example of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -target {default|unallocated|<DriveLetter> shrink|<DriveLetter> merge} -restart
```

### Parameters

This command takes no additional parameters.

## Remarks

If other users are logged on to the computer and the **quiet** command is not specified, a prompt will be displayed to confirm that the computer should be restarted.

## <a name="BKMK_Examples"></a>Examples

The following example illustrates using the **restart** command.
```
bdehdcfg -target default -restart
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Bdehdcfg](bdehdcfg.md)