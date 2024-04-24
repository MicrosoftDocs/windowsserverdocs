---
title: assign
description: Reference article for the assign command, which assigns a drive letter or mount point to the volume with focus.
ms.topic: reference
ms.assetid: 57912b73-622e-489b-b053-a369021ba8e1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# assign

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Assigns a drive letter or mount point to the volume with focus. You can also use this command to change the drive letter associated with a removable drive. If no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.

A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.

> [!IMPORTANT]
> You can't assign drive letters to system volumes, boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition or any GUID Partition Table (gpt) partition other than a basic data partition.

## Syntax

```
assign [{letter=<d> | mount=<path>}] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `letter=<d>` | The drive letter you want to assign to the volume. |
| `mount=<path>` | The mount point path you want to assign to the volume. For instructions about how to use this command, see [Assign a mount point folder path to a drive](../../storage/disk-management/assign-a-mount-point-folder-path-to-a-drive.md). |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To assign the letter E to the volume in focus, type:

```
assign letter=e
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select volume command](select-volume.md)
