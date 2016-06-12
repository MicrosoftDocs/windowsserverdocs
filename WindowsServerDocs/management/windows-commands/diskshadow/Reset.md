---
title: reset
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afbdab44-199c-4e11-884f-e96804965c21
---
# reset
resets Diskshadow.exe to the default state. **reset** is especially useful in separating compound Diskshadow operations such as **create**, **import**, **backup**, or **restore**.

## Syntax

```
reset
```

## remarks

-   When you use the **reset** command, you lose state from commands such as **add**, **set**, **load**, or **writer**. **reset** also releases IVssBackupcomponent interfaces and loses non\-persistent shadow copies.

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


