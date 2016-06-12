---
title: detail volume
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 38f2bc75-2ed6-4e80-aa74-ab83133db1cd
---
# detail volume
Displays the disks on which the current volume resides.

## Syntax

```
detail volume
```

## remarks

-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.

-   The volume details are not applicable to read\-only volumes, such as a DVD\-ROM or cd\-ROM drive.

## <a name="BKMK_examples"></a>Examples
To see all the disks in which the current volume resides, type:

```
detail volume
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


