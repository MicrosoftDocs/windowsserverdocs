---
title: convert gpt
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3b1b747-0a7a-4be2-8487-2c4be16ee190
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# convert gpt



Converts an empty basic disk with the master boot record (MBR) partition style into a basic disk with the GUID partition table (GPT) partition style.

For instructions regarding how to use this command, see [Change a Master Boot Record Disk into a GUID Partition Table Disk](https://go.microsoft.com/fwlink/?LinkId=207049) (https://go.microsoft.com/fwlink/?LinkId=207049).

## Syntax

```
convert gpt [noerr]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

> [!IMPORTANT]
> The disk must be empty to convert it into a GPT disk. Back up your data, and then delete all partitions or volumes before converting the disk.
> -   The required minimum disk size for conversion to GPT is 128 megabytes.
> -   A basic MBR disk must be selected for this operation to succeed. Use the **select disk** command to select a basic disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To convert a basic disc from MBR partition style to GPT partition style, type:
```
convert gpt
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

