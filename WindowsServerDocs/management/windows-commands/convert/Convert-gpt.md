---
title: convert gpt
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b3b1b747-0a7a-4be2-8487-2c4be16ee190
---
# convert gpt
converts an empty basic disk with the master boot record \(MBR\) partition style into a basic disk with the GUID partition table \(gpt\) partition style.

for instructions regarding how to use this command, see [change a Master Boot Record Disk into a GUID Partition Table Disk](http://go.microsoft.com/fwlink/?LinkId=207049) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207049\).

## Syntax

```
convert gpt [noerr]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## remarks

> [!importANT]
> The disk must be empty to convert it into a gpt disk. Back up your data, and then delete all partitions or volumes before converting the disk.

-   The required minimum disk size for conversion to gpt is 128 megabytes.

-   A basic MBR disk must be selected for this operation to succeed. Use the **select disk** command to select a basic disk and shift the focus to it.

## <a name="BKMK_examples"></a>Examples
To convert a basic disc from MBR partition style to gpt partition style, type:

```
convert gpt
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)


