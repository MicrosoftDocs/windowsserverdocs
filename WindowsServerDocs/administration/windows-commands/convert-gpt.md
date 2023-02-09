---
title: convert gpt
description: Reference article for the convert gpt command, which converts an empty basic disk with the master boot record (MBR) partition style into a basic disk with the GUID partition table (GPT) partition style.
ms.topic: reference
ms.assetid: b3b1b747-0a7a-4be2-8487-2c4be16ee190
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert gpt

Converts an empty basic disk with the master boot record (MBR) partition style into a basic disk with the GUID partition table (GPT) partition style. A basic MBR disk must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a basic disk and shift the focus to it.

> [!IMPORTANT]
> The disk must be empty to convert it to a basic disk. Back up your data, and then delete all partitions or volumes before converting the disk. The required minimum disk size for conversion to GPT is 128 megabytes.

> [!NOTE]
> For instructions regarding how to use this command, see [Change a Master Boot Record Disk into a GUID Partition Table Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc725671(v=ws.11)).

## Syntax

```
convert gpt [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To convert a basic disc from MBR partition style to GPT partition style, type:

```
convert gpt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [convert command](convert.md)
