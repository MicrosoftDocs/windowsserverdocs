---
title: Inactive
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4fb4695-4e66-4166-b4ab-2c86a4605580
author: JasonGerend
---
# Inactive
On basic master boot record \(MBR\) disks, marks the system partition or boot partition with focus as inactive.  
  
## Syntax  
  
```  
inactive  
```  
  
## Remarks  
  
> [!CAUTION]  
> Your computer might not start without an active partition. Do not mark a system or boot partition as inactive unless you are an experienced user with a thorough understanding of the Windows family of operating systems.  
>   
> If you are unable to start your computer after marking the system or boot partition as inactive, insert the Windows Setup CD in the CD\-ROM drive, restart the computer, and then repair the partition using the **fixmbr** and **fixboot** commands in the Recovery Console.  
  
-   After you mark the system partition or boot partition as inactive, your computer starts from the next option specified in the BIOS, such as the CD\-ROM drive or a Pre\-Boot eXecution Environment \(PXE\).  
  
-   An active system or boot partition must be selected for this operation to succeed. Use the **select partition** command to select the active partition and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
  
```  
inactive  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

