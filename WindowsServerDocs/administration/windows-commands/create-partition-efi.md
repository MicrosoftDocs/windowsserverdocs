---
title: create partition efi
description: Reference article for the create partition efi command, which creates an Extensible Firmware Interface (EFI) system partition on a GUID Partition Table (gpt) disk on Itanium-based computers.
ms.topic: reference
ms.assetid: 3cfc1fca-6515-4a4d-bfae-615fa8045ea9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# create partition efi

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates an Extensible Firmware Interface (EFI) system partition on a GUID Partition Table (gpt) disk on Itanium-based computers. After the partition is created, the focus is given to the new partition.

>[!NOTE]
> A gpt disk must be selected for this operation to succeed. Use the [select disk](select-disk.md) command to select a disk and shift the focus to it.

## Syntax

```
create partition efi [size=<n>] [offset=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | The size of the partition in megabytes (MB). If no size is given, the partition continues until there is no more free space in the current region. |
| offset=`<n>` | The offset in kilobytes (KB), at which the partition is created. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- You must add at least one volume with the **add volume** command before you can use the **create** command.

- After you run the **create** command, you can use the **exec** command to run a duplication script for backup from the shadow copy.

- You can use the **begin backup** command to specify a full backup, rather than a copy backup.

## Examples

To create an EFI partition of 1000 megabytes on the selected disk, type:

```
create partition efi size=1000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)

- [select disk](select-disk.md)
