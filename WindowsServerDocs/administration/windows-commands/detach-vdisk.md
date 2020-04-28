---
title: detach vdisk
description: Reference topic for detach vdisk, which stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 5f01dcb8-9237-4564-ad94-8a8dd0fd0cca
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# detach vdisk

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Stops the selected virtual hard disk (VHD) from appearing as a local hard disk drive on the host computer. When a VHD is detached, you can copy it to other locations.  
  
> [!NOTE]  
> This command is only applicable to Windows 7 and Windows Server 2008 R2.  
  
## Syntax  
  
```  
detach vdisk [noerr]  
```  
  
#### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   A VHD must be selected and detached for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.  
  
## Examples  
To detach the selected VHD, type:  
  
```  
detach vdisk  
```  
  
## Additional References  
  
-   - [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [attach vdisk](attach-vdisk.md)  
  
-   [compact vdisk](compact-vdisk.md)  

-   [detail vdisk](detail-vdisk.md)  
  
-   [expand vdisk](expand-vdisk.md)  
  
-   [Merge vdisk](merge-vdisk.md)  
  
-   [select vdisk](select-vdisk.md)  
  
-   [list_1](list_1.md)  
  

