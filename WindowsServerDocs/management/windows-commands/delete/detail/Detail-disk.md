---
title: detail disk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6b09cf40-8d93-452b-b449-5242e62a4102
---
# detail disk
Displays the properties of the selected disk and the volumes on that disk.

## Syntax

```
detail disk
```

## remarks

-   A disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.

-   if the selected disk is a virtual hard disk \(VHD\), **detail disk** reports the disk's bus type as Virtual.

## <a name="BKMK_examples"></a>Examples
To see the properties of the selected disk, and information about the volumes in the disk, type:

```
detail disk
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


