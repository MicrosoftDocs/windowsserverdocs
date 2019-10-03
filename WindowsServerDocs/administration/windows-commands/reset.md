---
title: reset
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afbdab44-199c-4e11-884f-e96804965c21
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# reset



Resets DiskShadow.exe to the default state. **Reset** is especially useful in separating compound DiskShadow operations such as **create**, **import**, **backup**, or **restore**.

## Syntax

```
reset
```

## Remarks

-   When you use the **reset** command, you lose state from commands such as **add**, **set**, **load**, or **writer**. **Reset** also releases IVssBackupComponent interfaces and loses non-persistent shadow copies.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)