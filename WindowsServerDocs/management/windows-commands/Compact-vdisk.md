---
title: Compact vdisk
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40ca0820-67de-4160-b62a-e9bf63fe2790
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Compact vdisk
Reduces the physical size of a dynamically expanding virtual hard disk (VHD) file. This parameter is useful because dynamically expanding VHDs increase in size as you add files, but they do not automatically reduce in size when you delete files.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.
## Syntax
```
compact vdisk
```
## Remarks
-   A dynamically expanding VHD must be selected for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.
-   You can only compact dynamically expanding VHDs that are detached or attached as read-only.
## <a name="BKMK_Examples"></a>Examples
To compact a dynamically expanding VHD, type:
```
compact vdisk
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Attach vdisk](Attach-vdisk.md)
-   [Create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)
-   [Detail vdisk](Detail-vdisk.md)
-   [Detach vdisk](Detach-vdisk.md)
-   [Expand vdisk](Expand-vdisk.md)
-   [Merge vdisk](Merge-vdisk.md)
-   [Select vdisk](Select-vdisk.md)
-   [List_1](List_1.md)
