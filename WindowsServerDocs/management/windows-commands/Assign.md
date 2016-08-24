---
title: Assign
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57912b73-622e-489b-b053-a369021ba8e1author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Assign
Assigns a drive letter or mount point to the volume with focus.
For examples of how this command can be used, see [Examples](#BKMK_examples).
## Syntax
```
assign [{letter=<d> | mount=<path>}] [noerr]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|letter=<d>|The drive letter you want to assign to the volume.|
|mount=<path>|The mount point path you want to assign to the volume.<br /><br />For instructions regarding how to use this command, see [Assign a mount point folder path to a drive](http://go.microsoft.com/fwlink/?LinkId=207059) (http://go.microsoft.com/fwlink/?LinkId=207059).|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## Remarks
-   If no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.
-   By using the assign command, you can change the drive letter associated with a removable drive.
-   You cannot assign drive letters to system volumes, boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition or any GUID Partition Table (GPT) partition other than a basic data partition.
-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.
## <a name="BKMK_examples"></a>Examples
To assign the letter E to the volume in focus, type:
```
assign letter=e
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)
