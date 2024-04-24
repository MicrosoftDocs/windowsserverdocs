---
title: convert mbr
description: Reference article for the convert mbr command, which converts an empty basic disk with the GUID Partition Table (GPT) partition style into a basic disk with the master boot record (MBR) partition style.
ms.topic: reference
ms.assetid: a635a4c0-af73-4330-b021-51d483424537
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert mbr

Converts an empty basic disk with the GUID Partition Table (GPT) partition style into a basic disk with the master boot record (MBR) partition style. A basic disk must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a basic disk and shift the focus to it.

> [!IMPORTANT]
> The disk must be empty to convert it to a basic disk. Back up your data, and then delete all partitions or volumes before converting the disk.

> [!NOTE]
> For instructions regarding how to use this command, see [Change a GUID Partition Table Disk into a Master Boot Record Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc725797(v=ws.11)).

## Syntax

```
convert mbr [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To convert a basic disc from GPT partition style to MBR partition style, type>:

```
convert mbr
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [convert command](convert.md)
