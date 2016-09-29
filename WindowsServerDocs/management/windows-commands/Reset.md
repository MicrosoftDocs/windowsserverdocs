---
title: Reset
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afbdab44-199c-4e11-884f-e96804965c21 JasonGerend
---
# Reset
Resets DiskShadow.exe to the default state. **Reset** is especially useful in separating compound DiskShadow operations such as **create**, **import**, **backup**, or **restore**.  
  
## Syntax  
  
```  
reset  
```  
  
## Remarks  
  
-   When you use the **reset** command, you lose state from commands such as **add**, **set**, **load**, or **writer**. **Reset** also releases IVssBackupComponent interfaces and loses non\-persistent shadow copies.  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

