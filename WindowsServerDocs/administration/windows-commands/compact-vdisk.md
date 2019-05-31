---
title: compact vdisk
description: "Windows Commands topic for **** - "
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
ms.date: 10/16/2017
---
# compact vdisk

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Reduces the physical size of a dynamically expanding virtual hard disk (VHD) file. This parameter is useful because dynamically expanding VHDs increase in size as you add files, but they do not automatically reduce in size when you delete files.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.
> ## Syntax
> ```
> compact vdisk
> ```
> ## Remarks
> - A dynamically expanding VHD must be selected for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.
> - You can only compact dynamically expanding VHDs that are detached or attached as read-only.
>   ## <a name="BKMK_Examples"></a>Examples
>   To compact a dynamically expanding VHD, type:
>   ```
>   compact vdisk
>   ```
>   ## additional references
> - [Command-Line Syntax Key](command-line-syntax-key.md)
> - [attach vdisk](attach-vdisk.md)

-   [detail vdisk](detail-vdisk.md)
-   [Detach vdisk](detach-vdisk.md)
-   [expand vdisk](expand-vdisk.md)
-   [Merge vdisk](merge-vdisk.md)
-   [select vdisk](select-vdisk.md)
-   [list_1](list_1.md)
