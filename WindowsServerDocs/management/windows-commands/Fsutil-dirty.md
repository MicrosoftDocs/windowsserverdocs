---
title: Fsutil dirty
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 83f271af-dc7e-4641-8e9c-b5da1be50625
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Fsutil dirty

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Queries or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted.  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
fsutil dirty {query | set} <VolumePath>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|query|Queries the specified volume's dirty bit.|  
|set|Sets the specified volume's dirty bit.|  
|<VolumePath>|Specifies the drive name followed by a colon or GUID in the following format: **Volume{***GUID***}**.|  
  
## Remarks  
  
-   A volume's dirty bit indicates that the file system may be in an inconsistent state. The dirty bit can be set because:  
  
    -   The volume is online and it has outstanding changes.  
  
    -   Changes were made to the volume and the computer was shut down before the changes were committed to the disk.  
  
    -   Corruption was detected on the volume.  
  
-   If the dirty bit is set when the computer restarts, **chkdsk** runs to verify the file system integrity and to attempt to fix any issues with the volume.  
  
## <a name="BKMK_examples"></a>Examples  
To query the dirty bit on drive C, type:  
  
```  
fsutil dirty query c:  
```  
  
-   If the volume is dirty, the following output displays:  
  
    `Volume C: is dirty`  
  
-   If the volume is not dirty, the following output displays:  
  
    `Volume C: is not dirty`  
  
To set the dirty bit on drive C, type:  
  
```  
fsutil dirty set C:  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Fsutil](Fsutil.md)  
  

