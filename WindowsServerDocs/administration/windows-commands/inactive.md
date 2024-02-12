---
title: inactive
description: Reference article for the inactive command, which marks the system partition or boot partition with focus as inactive on basic master boot record (MBR) disks.
ms.topic: reference
ms.assetid: f4fb4695-4e66-4166-b4ab-2c86a4605580
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# inactive

Marks the system partition or boot partition with focus as inactive on basic master boot record (MBR) disks.

An active system or boot partition must be selected for this operation to succeed. Use the [select partition command](select-partition.md) command to select the active partition and shift the focus to it.

> [!CAUTION]
> Your computer might not start without an active partition. Don't mark a system or boot partition as inactive unless you are an experienced user with a thorough understanding of the Windows family of operating systems.<p>If you're unable to start your computer after marking the system or boot partition as inactive, insert the Windows Setup CD in the CD-ROM drive, restart the computer, and then repair the partition using the **fixmbr** and **fixboot** commands in the Recovery Console.
>
> After you mark the system partition or boot partition as inactive, your computer starts from the next option specified in the BIOS, such as the CD-ROM drive or a Pre-Boot eXecution Environment (PXE).

## Syntax

```
inactive
```

### Examples

```
inactive
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select partition command](select-partition.md)

- [Advanced troubleshooting for Windows boot problems](/windows/client-management/advanced-troubleshooting-boot-problems)
