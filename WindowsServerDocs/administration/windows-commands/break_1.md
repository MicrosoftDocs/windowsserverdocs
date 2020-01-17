---
title: break
description: "Windows Commands topic for **break_1** - Sets or clears extended CTRL+C checking on MS-DOS systems. If used without parameters, **break** displays the current setting. "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c89b7357-d69e-4141-826e-73c9ba0fc630
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# break



Sets or clears extended CTRL+C checking on MS-DOS systems. If used without parameters, **break** displays the current setting.

> [!NOTE]
> This command is no longer in use. It is included only to preserve compatibility with existing MS-DOS files, but it has no effect at the command line because the functionality is automatic.

## Syntax

```
break=[on|off]
```

## Remarks

If command extensions are enabled and running on the Windows platform, inserting the **break** command into a batch file enters a hard-coded breakpoint if being debugged by a debugger.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)