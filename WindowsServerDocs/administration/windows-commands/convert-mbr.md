---
title: convert mbr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a635a4c0-af73-4330-b021-51d483424537
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# convert mbr



Converts an empty basic disk with the GUID Partition Table (GPT) partition style into a basic disk with the master boot record (MBR) partition style.

> [!IMPORTANT]
> The disk must be empty to convert it into an MBR disk. Back up your data, and then delete all partitions or volumes before converting the disk.

For instructions regarding how to use this command, see [Change a GUID Partition Table Disk into a Master Boot Record Disk](https://go.microsoft.com/fwlink/?LinkId=207050) (https://go.microsoft.com/fwlink/?LinkId=207050).

## Syntax

```
convert mbr [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   A basic disk must be selected for this operation to succeed. Use the **select disk** command to select a basic disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To convert a basic disc from GPT partition style to MBR partition style, type>:
```
convert mbr
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

