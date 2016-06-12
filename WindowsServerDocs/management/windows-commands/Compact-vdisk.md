---
title: compact vdisk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 40ca0820-67de-4160-b62a-e9bf63fe2790
---
# compact vdisk
Reduces the physical size of a dynamically expanding virtual hard disk \(VHD\) file. This parameter is useful because dynamically expanding VHDs increase in size as you add files, but they do not automatically reduce in size when you delete files.

> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

## Syntax

```
compact vdisk
```

## remarks

-   A dynamically expanding VHD must be selected for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.

-   You can only compact dynamically expanding VHDs that are detached or attached as read\-only.

## <a name="BKMK_Examples"></a>Examples
To compact a dynamically expanding VHD, type:

```
compact vdisk
```

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)

-   [attach vdisk](attach-vdisk.md)

-   [create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)

-   [detail vdisk](delete/detail/detail-vdisk.md)

-   [Detach vdisk]()

-   [expand vdisk](expand-vdisk.md)

-   [Merge vdisk](merge-vdisk.md)

-   [select vdisk](select/select-vdisk.md)

-   [list_1]()


