---
title: list
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69b105a1-9710-4a06-8102-38cc9e475ca5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# list



Displays a list of disks, of partitions in a disk, of volumes in a disk, or of virtual hard disks (VHDs).

## Syntax

```
list { disk | partition | volume | vdisk }
```

## Parameters

|Parameter|Description|
|---------|-----------|
|disk|Displays a list of disks and information about them, such as their size, amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the master boot record (MBR) or GUID partition table (GPT) partition style.|
|partition|Displays the partitions listed in the partition table of the current disk.|
|volume|Displays a list of basic and dynamic volumes on all disks.|
|vdisk|Displays a list of the VHDs that are attached and/or selected. This command lists detached VHDs if they are currently selected; however, the disk type is set to Unknown until the VHD is attached. The VHD marked with an asterisk (*) has focus.</br>Note: This command is only available for Windows 7 and Windows Server 2008 R2.|

## Remarks

-   When listing partitions on a dynamic disk, the partitions may not correspond to the dynamic volumes on the disk. This discrepancy occurs because dynamic disks contain entries in the partition table for the system volume or boot volume (if present on the disk). They also contain a partition that occupies the remainder of the disk in order to reserve the space for use by dynamic volumes.
-   The object marked with an asterisk (*) has focus.
-   When listing disks, if a disk is missing, its disk number is prefixed with M. For example, the first missing disk is numbered M0.

## <a name="BKMK_examples"></a>Examples

```
list disk
list partition
list volume
list vdisk
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

