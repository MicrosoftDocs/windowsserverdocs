---
title: Create_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 837aa449-9b60-41ae-9ef1-ef67af6e5918
---
# Create_1
Starts the shadow copy creation process, using the current context and option settings. Requires at least one volume in the Shadow Copy Set.  
  
## Syntax  
  
```  
create  
```  
  
## Remarks  
  
-   You must add at least one volume with the **add volume** command before you can use the **create** command.  
  
-   You can use the **begin backup** command to specify a full backup, rather than a copy backup.  
  
-   After you run the **create** command, you can use the **exec** command to run a duplication script for backup from the shadow copy.  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
