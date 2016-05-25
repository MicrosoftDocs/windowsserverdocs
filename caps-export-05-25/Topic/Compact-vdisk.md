---
title: Compact vdisk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40ca0820-67de-4160-b62a-e9bf63fe2790
author: JasonGerend
---
# Compact vdisk
Reduces the physical size of a dynamically expanding virtual hard disk \(VHD\) file. This parameter is useful because dynamically expanding VHDs increase in size as you add files, but they do not automatically reduce in size when you delete files.  
  
> [!NOTE]  
> This command is only applicable to Windows 7 and Windows Server 2008 R2.  
  
## Syntax  
  
```  
compact vdisk  
```  
  
## Remarks  
  
-   A dynamically expanding VHD must be selected for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.  
  
-   You can only compact dynamically expanding VHDs that are detached or attached as read\-only.  
  
## <a name="BKMK_Examples"></a>Examples  
To compact a dynamically expanding VHD, type:  
  
```  
compact vdisk  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Attach vdisk](../Topic/Attach-vdisk.md)  
  
-   [Create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)  
  
-   [Detail vdisk](../Topic/Detail-vdisk.md)  
  
-   [Detach vdisk](../Topic/Detach-vdisk.md)  
  
-   [Expand vdisk](../Topic/Expand-vdisk.md)  
  
-   [Merge vdisk](../Topic/Merge-vdisk.md)  
  
-   [Select vdisk](../Topic/Select-vdisk.md)  
  
-   [List_1](../Topic/List_1.md)  
  
