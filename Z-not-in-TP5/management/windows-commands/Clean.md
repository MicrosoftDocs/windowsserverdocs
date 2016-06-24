---
title: Clean
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bbe6fd3-e07e-487b-9035-910957a1d326
---
# Clean
The Diskpart Clean command removes any and all partition or volume formatting from the disk with focus.

## Syntax

```
clean [all]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|all|Specifies that each and every sector on the disk is set to zero, which completely deletes all data contained on the disk.|

## Remarks

-   On master boot record (MBR) disks, only the MBR partitioning information and hidden sector information are overwritten.

-   On GUID Partition Table (GPT) disks, the GPT partitioning information, including the Protective MBR, is overwritten. There is no hidden sector information.

-   A disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples
To remove all formatting from the selected disk, type:

```
clean
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)

[Clear-Disk](http://technet.microsoft.com/library/hh848661.aspx)


