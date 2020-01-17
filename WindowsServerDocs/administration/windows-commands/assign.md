---
title: assign
description: "Windows Commands topic for **assign** - assigns a drive letter or mount point to the volume with focus."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57912b73-622e-489b-b053-a369021ba8e1

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# assign

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

assigns a drive letter or mount point to the volume with focus.

## Syntax
```
assign [{letter=<d> | mount=<path>}] [noerr]
```
## Parameters

|  Parameter   |                                                                                                                                 Description                                                                                                                                 |
|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  letter=<d>  |                                                                                                             The drive letter you want to assign to the volume.                                                                                                              |
| mount=<path> | The mount point path you want to assign to the volume.<br /><br />for instructions regarding how to use this command, see [assign a mount point folder path to a drive](https://go.microsoft.com/fwlink/?LinkId=207059) (<https://go.microsoft.com/fwlink/?LinkId=207059>). |
|    noerr     |                                    for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.                                     |

## Remarks
- if no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.
- By using the assign command, you can change the drive letter associated with a removable drive.
- You cannot assign drive letters to system volumes, boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition or any GUID Partition Table (gpt) partition other than a basic data partition.
- A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.
  ## <a name="BKMK_examples"></a>Examples
  To assign the letter E to the volume in focus, type:
  ```
  assign letter=e
  ```

