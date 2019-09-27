---
title: clean
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bbe6fd3-e07e-487b-9035-910957a1d326
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# clean

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Diskpart clean command removes any and all partition or volume formatting from the disk with focus.
## Syntax
```
clean [all]
```
## Parameters

| Parameter |                                                        Description                                                        |
|-----------|---------------------------------------------------------------------------------------------------------------------------|
|    all    | Specifies that each and every sector on the disk is set to zero, which completely deletes all data contained on the disk. |

## Remarks
- On master boot record (MBR) disks, only the MBR partitioning information and hidden sector information are overwritten.
- On GUID Partition Table (gpt) disks, the gpt partitioning information, including the Protective MBR, is overwritten. There is no hidden sector information.
- A disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.
  ## <a name="BKMK_examples"></a>Examples
  To remove all formatting from the selected disk, type:
  ```
  clean
  ```

[Clear-Disk](https://technet.microsoft.com/library/hh848661.aspx)
